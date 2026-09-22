import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_test/flutter_test.dart';
import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart' as enc;
import 'package:nudge/data/backup/backup_manager.dart';
import 'package:nudge/core/utils/secure_storage_util.dart';
import 'package:nudge/domain/entities/todo.dart';
import 'package:nudge/domain/entities/record.dart';
import 'package:nudge/domain/entities/tag.dart';
import 'package:nudge/domain/enums/todo_enums.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('BackupManager Schema v2 & v3 Compatibility Tests', () {
    late Directory tempDir;

    setUp(() async {
      tempDir = await Directory.systemTemp.createTemp('nudge_v3_backup_test_');
    });

    tearDown(() async {
      if (await tempDir.exists()) {
        await tempDir.delete(recursive: true);
      }
    });

    Future<File> createEncryptedBackupFile(Map<String, dynamic> payload, {int schemaVersion = 3}) async {
      final rawJson = jsonEncode(payload);
      final masterKey = await SecureStorageUtil.getOrCreateMasterKey();

      final keyBytes = sha256.convert(utf8.encode(masterKey)).bytes;
      final encKey = enc.Key(Uint8List.fromList(keyBytes));
      final iv = enc.IV.fromSecureRandom(16);

      final encrypter = enc.Encrypter(enc.AES(encKey, mode: enc.AESMode.cbc));
      final encrypted = encrypter.encrypt(rawJson, iv: iv);

      final hmacKey = sha256.convert(utf8.encode('$masterKey:HMAC')).bytes;
      final hmac = Hmac(sha256, hmacKey);
      final authTag = hmac.convert([...iv.bytes, ...encrypted.bytes]).bytes;

      final container = {
        'magic': 'NUDGE_ENC_V2',
        'schemaVersion': schemaVersion,
        'iv': base64Encode(iv.bytes),
        'ciphertext': encrypted.base64,
        'authTag': base64Encode(authTag),
      };

      final file = File('${tempDir.path}/test_backup_$schemaVersion.nudgebackup');
      await file.writeAsString(jsonEncode(container));
      return file;
    }

    test('Seamlessly inspects legacy v2 backup without todos/records', () async {
      final v2Payload = {
        'manifest': {
          'magic': 'NUDGE_ENC_V2',
          'schemaVersion': 2,
          'appVersion': '2.0.0',
        },
        'reminders': [
          {
            'id': 'rem_1',
            'message': 'Legacy Reminder',
            'scheduledAt': DateTime.now().toIso8601String(),
            'repeatRule': 'none',
            'createdAt': DateTime.now().toIso8601String(),
            'priority': 'normal',
            'alertStyle': 'alarm',
            'checklist': [],
          }
        ],
        'occurrences': [],
        'folders': [],
        'history': [],
        'templates': [],
        // Notice: 'todos', 'records', 'tags' are completely absent in v2!
      };

      final backupFile = await createEncryptedBackupFile(v2Payload, schemaVersion: 2);
      final preview = await BackupManager.inspectBackupFile(backupFile.path, existingRemindersOverride: []);

      expect(preview.validReminders.length, 1);
      expect(preview.validReminders.first.message, 'Legacy Reminder');
      expect(preview.validTodos.isEmpty, true);
      expect(preview.validRecords.isEmpty, true);
      expect(preview.validTags.isEmpty, true);
    });

    test('Inspects v3 backup with todos, records, and tags', () async {
      final todo = Todo(
        id: 'todo_v3_1',
        title: 'Task from backup',
        priority: TodoPriority.high,
      );

      final record = Record(
        id: 'rec_v3_1',
        title: 'Note from backup',
        content: 'This note was restored from v3 backup',
        recordType: RecordType.idea,
      );

      final tag = Tag(
        id: 'tag_v3_1',
        name: 'productivity',
      );

      final v3Payload = {
        'manifest': {
          'magic': 'NUDGE_ENC_V2',
          'schemaVersion': 3,
          'appVersion': '2.0.0',
        },
        'reminders': [],
        'occurrences': [],
        'folders': [],
        'history': [],
        'templates': [],
        'todos': [todo.toJson()],
        'records': [record.toJson()],
        'tags': [tag.toJson()],
      };

      final backupFile = await createEncryptedBackupFile(v3Payload, schemaVersion: 3);
      final preview = await BackupManager.inspectBackupFile(backupFile.path, existingRemindersOverride: []);

      expect(preview.validReminders.isEmpty, true);
      expect(preview.validTodos.length, 1);
      expect(preview.validTodos.first.title, 'Task from backup');
      expect(preview.validTodos.first.priority, TodoPriority.high);

      expect(preview.validRecords.length, 1);
      expect(preview.validRecords.first.title, 'Note from backup');
      expect(preview.validRecords.first.recordType, RecordType.idea);

      expect(preview.validTags.length, 1);
      expect(preview.validTags.first.name, 'productivity');
    });
  });
}
