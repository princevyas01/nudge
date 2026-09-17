import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart' as enc;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

import '../../core/constants/app_constants.dart';
import '../../core/logging/app_logger.dart';
import '../../core/utils/pbkdf2_util.dart';
import '../../core/utils/secure_storage_util.dart';
import '../../domain/entities/folder.dart';
import '../../domain/entities/reminder.dart';
import '../../domain/entities/reminder_history.dart';
import '../../domain/entities/reminder_occurrence.dart';
import '../../domain/entities/reminder_template.dart';
import '../../domain/entities/companion_profile.dart';
import '../../domain/entities/todo.dart';
import '../../domain/entities/record.dart';
import '../../domain/entities/tag.dart';
import '../database/app_database.dart';
import '../media/app_media_repository.dart';
import '../repositories/folder_repository_impl.dart';
import '../repositories/history_repository_impl.dart';
import '../repositories/occurrence_repository_impl.dart';
import '../repositories/reminder_repository_impl.dart';
import '../repositories/template_repository_impl.dart';
import '../repositories/companion_repository_impl.dart';
import '../repositories/todo_repository_impl.dart';
import '../repositories/record_repository_impl.dart';
import '../repositories/tag_repository_impl.dart';

enum BackupConflictPolicy {
  skip,
  replace,
  keep,
  importAsCopy,
}

class BackupPreview {
  final int totalRecords;
  final int addedCount;
  final int updatedCount;
  final int skippedCount;
  final int duplicateCount;
  final int invalidCount;
  final int invalidMediaCount;
  final List<Reminder> validReminders;
  final List<ReminderOccurrence> validOccurrences;
  final List<Folder> validFolders;
  final List<ReminderHistory> validHistory;
  final List<ReminderTemplate> validTemplates;
  final CompanionProfile? companionProfile;
  final List<Todo> validTodos;
  final List<Record> validRecords;
  final List<Tag> validTags;
  final Map<String, String> mediaFiles;

  const BackupPreview({
    required this.totalRecords,
    required this.addedCount,
    required this.updatedCount,
    required this.skippedCount,
    required this.duplicateCount,
    required this.invalidCount,
    required this.invalidMediaCount,
    required this.validReminders,
    required this.validOccurrences,
    required this.validFolders,
    required this.validHistory,
    required this.validTemplates,
    this.companionProfile,
    this.validTodos = const [],
    this.validRecords = const [],
    this.validTags = const [],
    this.mediaFiles = const {},
  });
}

class BackupManager {
  static const String _subsystem = 'BackupManager';
  static const int schemaVersion = 3;
  static const String containerMagic = 'NUDGE_ENC_JSON_V1';
  static const String legacyMagicV2 = 'NUDGE_ENC_V2';
  static const String legacyMagicV3 = 'NUDGE_ENC_V3';

  /// Exports all application data and media into an authenticated AES-256 encrypted JSON file.
  /// If [password] is provided, uses PBKDF2-HMAC-SHA256 key derivation with a random 16-byte salt,
  /// enabling cross-device portability without reliance on device-bound keystores.
  /// If [password] is omitted, falls back to legacy device-local master key encryption.
  static Future<File> exportBackup({String? password}) async {
    AppLogger.info(_subsystem, 'Starting backup export...');
    final reminderRepo = ReminderRepositoryImpl();
    final occurrenceRepo = OccurrenceRepositoryImpl();
    final folderRepo = FolderRepositoryImpl();
    final historyRepo = HistoryRepositoryImpl();
    final templateRepo = TemplateRepositoryImpl();
    final companionRepo = CompanionRepositoryImpl();
    final todoRepo = TodoRepositoryImpl();
    final recordRepo = RecordRepositoryImpl();
    final tagRepo = TagRepositoryImpl();

    final reminders = await reminderRepo.getAllReminders();
    final occurrences = await occurrenceRepo.getAllOccurrences();
    final folders = await folderRepo.getAllFolders();
    final history = await historyRepo.getAllHistory();
    final templates = await templateRepo.getAllTemplates();
    final companion = await companionRepo.getProfile();
    final todos = await todoRepo.getAllTodos(includeDeleted: true);
    final records = await recordRepo.getAllRecords(includeDeleted: true);
    final tags = await tagRepo.getAllTags();
    final mediaMap = await AppMediaRepository.exportAllMediaBase64();

    final isPasswordMode = password != null && password.trim().isNotEmpty;
    final currentMagic = isPasswordMode ? containerMagic : legacyMagicV2;

    final payload = {
      'manifest': {
        'magic': currentMagic,
        'schemaVersion': schemaVersion,
        'appVersion': AppConstants.appVersion,
        'exportedAt': DateTime.now().toIso8601String(),
        'reminderCount': reminders.length,
        'occurrenceCount': occurrences.length,
        'folderCount': folders.length,
        'todoCount': todos.length,
        'recordCount': records.length,
        'tagCount': tags.length,
        'mediaCount': mediaMap.length,
      },
      'reminders': reminders.map((r) => r.toJson()).toList(),
      'occurrences': occurrences.map((o) => o.toJson()).toList(),
      'folders': folders.map((f) => f.toJson()).toList(),
      'history': history.map((h) => h.toJson()).toList(),
      'templates': templates.map((t) => t.toJson()).toList(),
      'companion': companion.toJson(),
      'todos': todos.map((t) => t.toJson()).toList(),
      'records': records.map((r) => r.toJson()).toList(),
      'tags': tags.map((t) => t.toJson()).toList(),
      'media': mediaMap,
    };

    final rawJson = jsonEncode(payload);
    final tempDir = await getTemporaryDirectory();

    if (isPasswordMode) {
      final cleanPassword = password.trim();
      final salt = Pbkdf2Util.generateSalt(16);
      const iterations = 10000;

      final encKeyBytes = Pbkdf2Util.deriveKey(cleanPassword, salt, iterations: iterations, blockIndex: 1);
      final hmacKeyBytes = Pbkdf2Util.deriveKey(cleanPassword, salt, iterations: iterations, blockIndex: 2);

      final encKey = enc.Key(encKeyBytes);
      final iv = enc.IV.fromSecureRandom(16);
      final encrypter = enc.Encrypter(enc.AES(encKey, mode: enc.AESMode.cbc));
      final encrypted = encrypter.encrypt(rawJson, iv: iv);

      // Compute HMAC-SHA256 authentication tag over [salt + iv + ciphertext]
      final hmac = Hmac(sha256, hmacKeyBytes);
      final authenticatedPayload = [...salt, ...iv.bytes, ...encrypted.bytes];
      final authTag = hmac.convert(authenticatedPayload).bytes;

      final container = {
        'magic': containerMagic,
        'schemaVersion': schemaVersion,
        'appVersion': AppConstants.appVersion,
        'createdAt': DateTime.now().toIso8601String(),
        'kdf': 'PBKDF2_SHA256',
        'iterations': iterations,
        'salt': base64Encode(salt),
        'iv': base64Encode(iv.bytes),
        'ciphertext': encrypted.base64,
        'authTag': base64Encode(authTag),
      };

      final filename = 'nudge_backup_${DateTime.now().millisecondsSinceEpoch}.json';
      final backupFile = File('${tempDir.path}/$filename');
      await backupFile.writeAsString(jsonEncode(container));

      AppLogger.info(_subsystem, 'Password-encrypted JSON backup export complete: ${backupFile.path} (${backupFile.lengthSync()} bytes)');
      return backupFile;
    } else {
      final masterKey = await SecureStorageUtil.getOrCreateMasterKey();

      // Key derivation: SHA-256 of master key
      final keyBytes = sha256.convert(utf8.encode(masterKey)).bytes;
      final encKey = enc.Key(Uint8List.fromList(keyBytes));
      final iv = enc.IV.fromSecureRandom(16);

      final encrypter = enc.Encrypter(enc.AES(encKey, mode: enc.AESMode.cbc));
      final encrypted = encrypter.encrypt(rawJson, iv: iv);

      // Compute HMAC-SHA256 authentication tag over [IV + Ciphertext]
      final hmacKey = sha256.convert(utf8.encode('$masterKey:HMAC')).bytes;
      final hmac = Hmac(sha256, hmacKey);
      final authenticatedPayload = [...iv.bytes, ...encrypted.bytes];
      final authTag = hmac.convert(authenticatedPayload).bytes;

      final container = {
        'magic': legacyMagicV2,
        'schemaVersion': schemaVersion,
        'iv': base64Encode(iv.bytes),
        'ciphertext': encrypted.base64,
        'authTag': base64Encode(authTag),
      };

      final filename = 'nudge_backup_${DateTime.now().millisecondsSinceEpoch}.nudgebackup';
      final backupFile = File('${tempDir.path}/$filename');
      await backupFile.writeAsString(jsonEncode(container));

      AppLogger.info(_subsystem, 'Master key backup export complete: ${backupFile.path} (${backupFile.lengthSync()} bytes)');
      return backupFile;
    }
  }

  /// Detects if a given backup file requires a password for decryption.
  static Future<bool> isPasswordProtected(String filePath) async {
    final file = File(filePath);
    if (!await file.exists()) return false;
    try {
      final raw = await file.readAsString();
      final container = jsonDecode(raw) as Map<String, dynamic>;
      final magic = container['magic'] as String?;
      final kdf = container['kdf'] as String?;
      return magic == containerMagic || kdf == 'PBKDF2_SHA256';
    } catch (_) {
      return false;
    }
  }

  /// Parses, verifies authentication tag, decrypts, and inspects a backup without touching the database.
  static Future<BackupPreview> inspectBackupFile(
    String filePath, {
    String? password,
    BackupConflictPolicy policy = BackupConflictPolicy.skip,
    List<Reminder>? existingRemindersOverride,
  }) async {
    AppLogger.info(_subsystem, 'Inspecting backup file: $filePath');
    final file = File(filePath);
    if (!await file.exists()) {
      throw const FileSystemException('Backup file not found');
    }

    final raw = await file.readAsString();
    Map<String, dynamic> container;
    try {
      container = jsonDecode(raw) as Map<String, dynamic>;
    } catch (_) {
      throw const FormatException('Invalid backup container: not valid JSON');
    }

    final magic = container['magic'] as String?;
    final isPasswordContainer = magic == containerMagic || container['kdf'] == 'PBKDF2_SHA256';

    if (!isPasswordContainer && magic != legacyMagicV2 && magic != legacyMagicV3) {
      throw const FormatException('Unsupported backup format or wrong schema version');
    }

    final ivBytes = base64Decode(container['iv'] as String);
    final ciphertextBase64 = container['ciphertext'] as String;
    final cipherBytes = base64Decode(ciphertextBase64);
    final authTagBytes = base64Decode(container['authTag'] as String);

    String decrypted;

    if (isPasswordContainer) {
      if (password == null || password.trim().isEmpty) {
        throw const FormatException('Password required to decrypt this backup file.');
      }
      if (container['salt'] == null) {
        throw const FormatException('Corrupted backup file: missing salt.');
      }

      final saltBytes = base64Decode(container['salt'] as String);
      final iterations = (container['iterations'] as num?)?.toInt() ?? 10000;

      final encKeyBytes = Pbkdf2Util.deriveKey(password.trim(), saltBytes, iterations: iterations, blockIndex: 1);
      final hmacKeyBytes = Pbkdf2Util.deriveKey(password.trim(), saltBytes, iterations: iterations, blockIndex: 2);

      // Verify HMAC-SHA256 over [salt + iv + ciphertext]
      final hmac = Hmac(sha256, hmacKeyBytes);
      final computedTag = hmac.convert([...saltBytes, ...ivBytes, ...cipherBytes]).bytes;

      if (!Pbkdf2Util.constantTimeEquals(computedTag, authTagBytes)) {
        throw const FormatException('Incorrect password or corrupted backup file.');
      }

      try {
        final encKey = enc.Key(encKeyBytes);
        final encrypter = enc.Encrypter(enc.AES(encKey, mode: enc.AESMode.cbc));
        decrypted = encrypter.decrypt(enc.Encrypted(cipherBytes), iv: enc.IV(ivBytes));
      } catch (e) {
        throw const FormatException('Incorrect password or corrupted backup file.');
      }
    } else {
      final masterKey = await SecureStorageUtil.getOrCreateMasterKey();

      // Verify HMAC-SHA256 authentication tag over [iv + ciphertext]
      final hmacKey = sha256.convert(utf8.encode('$masterKey:HMAC')).bytes;
      final hmac = Hmac(sha256, hmacKey);
      final computedTag = hmac.convert([...ivBytes, ...cipherBytes]).bytes;

      if (!Pbkdf2Util.constantTimeEquals(computedTag, authTagBytes)) {
        throw const FormatException('Authentication tag mismatch: corrupted file or wrong encryption key');
      }

      // Decrypt
      final keyBytes = sha256.convert(utf8.encode(masterKey)).bytes;
      final encKey = enc.Key(Uint8List.fromList(keyBytes));
      final encrypter = enc.Encrypter(enc.AES(encKey, mode: enc.AESMode.cbc));
      decrypted = encrypter.decrypt(enc.Encrypted(cipherBytes), iv: enc.IV(ivBytes));
    }

    final Map<String, dynamic> payload = jsonDecode(decrypted) as Map<String, dynamic>;

    // Existing reminders for conflict / duplicate detection
    final existingReminders = existingRemindersOverride ?? await ReminderRepositoryImpl().getAllReminders();
    final existingIds = existingReminders.map((r) => r.id).toSet();

    final validReminders = <Reminder>[];
    final validOccurrences = <ReminderOccurrence>[];
    final validFolders = <Folder>[];
    final validHistory = <ReminderHistory>[];
    final validTemplates = <ReminderTemplate>[];
    final mediaMap = <String, String>{};

    int duplicates = 0;
    int invalid = 0;
    int invalidMedia = 0;

    // Process Reminders
    if (payload['reminders'] is List) {
      for (final r in payload['reminders'] as List) {
        try {
          final map = Map<String, dynamic>.from(r as Map);
          final reminder = Reminder.fromJson(map);
          if (existingIds.contains(reminder.id)) {
            duplicates++;
          }
          validReminders.add(reminder);
        } catch (_) {
          invalid++;
        }
      }
    }

    // Process Occurrences
    if (payload['occurrences'] is List) {
      for (final o in payload['occurrences'] as List) {
        try {
          validOccurrences.add(ReminderOccurrence.fromJson(Map<String, dynamic>.from(o as Map)));
        } catch (_) {
          invalid++;
        }
      }
    }

    // Process Folders
    if (payload['folders'] is List) {
      for (final f in payload['folders'] as List) {
        try {
          validFolders.add(Folder.fromJson(Map<String, dynamic>.from(f as Map)));
        } catch (_) {
          invalid++;
        }
      }
    }

    // Process History
    if (payload['history'] is List) {
      for (final h in payload['history'] as List) {
        try {
          validHistory.add(ReminderHistory.fromJson(Map<String, dynamic>.from(h as Map)));
        } catch (_) {
          invalid++;
        }
      }
    }

    // Process Templates
    if (payload['templates'] is List) {
      for (final t in payload['templates'] as List) {
        try {
          validTemplates.add(ReminderTemplate.fromJson(Map<String, dynamic>.from(t as Map)));
        } catch (_) {
          invalid++;
        }
      }
    }

    // Process Media
    if (payload['media'] is Map) {
      final m = payload['media'] as Map;
      m.forEach((key, val) {
        if (key is String && val is String) {
          mediaMap[key] = val;
        } else {
          invalidMedia++;
        }
      });
    }

    CompanionProfile? companionProfile;
    if (payload['companion'] is Map) {
      try {
        companionProfile = CompanionProfile.fromJson(Map<String, dynamic>.from(payload['companion'] as Map));
      } catch (_) {}
    }

    // Process Todos
    final validTodos = <Todo>[];
    if (payload['todos'] is List) {
      for (final t in payload['todos'] as List) {
        try {
          validTodos.add(Todo.fromJson(Map<String, dynamic>.from(t as Map)));
        } catch (_) {}
      }
    }

    // Process Records
    final validRecords = <Record>[];
    if (payload['records'] is List) {
      for (final r in payload['records'] as List) {
        try {
          validRecords.add(Record.fromJson(Map<String, dynamic>.from(r as Map)));
        } catch (_) {}
      }
    }

    // Process Tags
    final validTags = <Tag>[];
    if (payload['tags'] is List) {
      for (final tag in payload['tags'] as List) {
        try {
          validTags.add(Tag.fromJson(Map<String, dynamic>.from(tag as Map)));
        } catch (_) {}
      }
    }

    int added = 0;
    int updated = 0;
    int skipped = 0;

    for (final r in validReminders) {
      final exists = existingIds.contains(r.id);
      if (exists) {
        if (policy == BackupConflictPolicy.replace) {
          updated++;
        } else if (policy == BackupConflictPolicy.skip || policy == BackupConflictPolicy.keep) {
          skipped++;
        } else if (policy == BackupConflictPolicy.importAsCopy) {
          added++;
        }
      } else {
        added++;
      }
    }

    final total = validReminders.length + validTodos.length + validRecords.length + invalid;

    return BackupPreview(
      totalRecords: total,
      addedCount: added,
      updatedCount: updated,
      skippedCount: skipped,
      duplicateCount: duplicates,
      invalidCount: invalid,
      invalidMediaCount: invalidMedia,
      validReminders: validReminders,
      validOccurrences: validOccurrences,
      validFolders: validFolders,
      validHistory: validHistory,
      validTemplates: validTemplates,
      companionProfile: companionProfile,
      validTodos: validTodos,
      validRecords: validRecords,
      validTags: validTags,
      mediaFiles: mediaMap,
    );
  }

  /// Commits the previewed backup atomically inside a SQLite transaction according to [policy].
  static Future<void> commitImport(
    BackupPreview preview, {
    BackupConflictPolicy policy = BackupConflictPolicy.skip,
  }) async {
    AppLogger.info(_subsystem, 'Committing backup import atomically with policy: $policy');
    final db = await AppDatabase.database;

    final existingReminders = await ReminderRepositoryImpl().getAllReminders();
    final existingIds = existingReminders.map((r) => r.id).toSet();

    await db.transaction((txn) async {
      // 1. Folders: insert with conflict ignore
      for (final folder in preview.validFolders) {
        await txn.insert(
          'folders',
          folder.toJson(),
          conflictAlgorithm: ConflictAlgorithm.ignore,
        );
      }

      // 2. ID Mapping if importing as copy
      final idMap = <String, String>{};
      if (policy == BackupConflictPolicy.importAsCopy) {
        for (final r in preview.validReminders) {
          if (existingIds.contains(r.id)) {
            idMap[r.id] = const Uuid().v4();
          }
        }
      }

      // 3. Reminders & Checklist Items
      for (final reminder in preview.validReminders) {
        final isConflict = existingIds.contains(reminder.id);
        if (isConflict && (policy == BackupConflictPolicy.skip || policy == BackupConflictPolicy.keep)) {
          continue;
        }

        final targetId = idMap[reminder.id] ?? reminder.id;
        final finalReminder = reminder.copyWith(id: targetId);

        final rData = finalReminder.toJson();
        rData.remove('checklist');

        await txn.insert(
          'reminders',
          rData,
          conflictAlgorithm: ConflictAlgorithm.replace,
        );

        for (final item in finalReminder.checklist) {
          await txn.insert(
            'checklist_items',
            {
              'id': const Uuid().v4(),
              'reminderId': targetId,
              'text': item.text,
              'isDone': item.isDone ? 1 : 0,
            },
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
        }
      }

      // 4. Occurrences
      for (final occ in preview.validOccurrences) {
        final targetReminderId = idMap[occ.reminderId] ?? occ.reminderId;
        final targetOccId = idMap.containsKey(occ.reminderId) ? const Uuid().v4() : occ.id;

        await txn.insert(
          'reminder_occurrences',
          occ.copyWith(id: targetOccId, reminderId: targetReminderId).toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }

      // 5. History
      for (final h in preview.validHistory) {
        final targetReminderId = idMap[h.reminderId] ?? h.reminderId;
        await txn.insert(
          'reminder_history',
          {
            'id': const Uuid().v4(),
            'reminderId': targetReminderId,
            'action': h.action.name,
            'timestamp': h.timestamp.toIso8601String(),
            'details': h.details,
          },
          conflictAlgorithm: ConflictAlgorithm.ignore,
        );
      }

      // 6. Templates
      for (final t in preview.validTemplates) {
        await txn.insert(
          'reminder_templates',
          {
            'id': t.id,
            'title': t.title,
            'message': t.message,
            'priority': t.priority.name,
            'alertStyle': t.alertStyle.name,
            'repeatRule': t.repeatRule.name,
            'checklistJson': jsonEncode(t.checklist.map((e) => e.toJson()).toList()),
          },
          conflictAlgorithm: ConflictAlgorithm.ignore,
        );
      }

      // 7. Companion profile
      if (preview.companionProfile != null) {
        final c = preview.companionProfile!;
        await txn.insert(
          'companion_profile',
          {
            'id': 1,
            'name': c.name,
            'lifetimeCompletions': c.lifetimeCompletions,
            'currentStreak': c.currentStreak,
            'streakFreezes': c.streakFreezes,
            'equippedCosmetic': c.equippedCosmetic,
            'unlockedCosmeticsJson': jsonEncode(c.unlockedCosmetics),
            'lastActiveDate': c.lastActiveDate?.toIso8601String(),
          },
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }

      // 8. Tags
      for (final tag in preview.validTags) {
        await txn.insert(
          'tags',
          tag.toJson(),
          conflictAlgorithm: ConflictAlgorithm.ignore,
        );
      }

      // 9. Todos & Subtasks
      for (final todo in preview.validTodos) {
        final targetTodoId = policy == BackupConflictPolicy.importAsCopy ? const Uuid().v4() : todo.id;
        final tData = todo.copyWith(id: targetTodoId).toJson();
        tData.remove('subtasks');
        await txn.insert(
          'todos',
          tData,
          conflictAlgorithm: ConflictAlgorithm.replace,
        );

        for (final subtask in todo.subtasks) {
          await txn.insert(
            'todo_subtasks',
            subtask.copyWith(id: const Uuid().v4(), todoId: targetTodoId).toJson(),
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
        }
      }

      // 10. Records
      for (final record in preview.validRecords) {
        final targetRecordId = policy == BackupConflictPolicy.importAsCopy ? const Uuid().v4() : record.id;
        await txn.insert(
          'records',
          record.copyWith(id: targetRecordId).toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    });

    // 11. Restore sandboxed media files
    for (final entry in preview.mediaFiles.entries) {
      await AppMediaRepository.importMediaBase64(entry.key, entry.value);
    }

    AppLogger.info(_subsystem, 'Backup import committed successfully');
  }
}
