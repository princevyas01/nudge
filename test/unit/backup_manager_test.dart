import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_test/flutter_test.dart';
import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart' as enc;
import 'package:nudge/core/utils/pbkdf2_util.dart';
import 'package:nudge/data/backup/backup_manager.dart';
import 'package:nudge/core/utils/secure_storage_util.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('BackupManager Container & Security Tests', () {
    late Directory tempDir;

    setUp(() async {
      tempDir = await Directory.systemTemp.createTemp('nudge_backup_test_');
    });

    tearDown(() async {
      if (await tempDir.exists()) {
        await tempDir.delete(recursive: true);
      }
    });

    test('Rejects file with invalid container JSON format', () async {
      final badFile = File('${tempDir.path}/bad.nudgebackup');
      await badFile.writeAsString('NOT_JSON_DATA_CORRUPT');

      expect(
        () => BackupManager.inspectBackupFile(badFile.path),
        throwsA(isA<FormatException>()),
      );
    });

    test('Rejects file with incorrect magic header or schema version', () async {
      final badHeaderFile = File('${tempDir.path}/bad_header.nudgebackup');
      await badHeaderFile.writeAsString(jsonEncode({
        'magic': 'WRONG_MAGIC',
        'schemaVersion': 99,
        'iv': base64Encode(Uint8List(16)),
        'ciphertext': base64Encode(Uint8List(16)),
        'authTag': base64Encode(Uint8List(32)),
      }));

      expect(
        () => BackupManager.inspectBackupFile(badHeaderFile.path),
        throwsA(isA<FormatException>()),
      );
    });

    test('Legacy v2: Rejects container when HMAC authentication tag is tampered with', () async {
      final masterKey = await SecureStorageUtil.getOrCreateMasterKey();
      final keyBytes = sha256.convert(utf8.encode(masterKey)).bytes;
      final encKey = enc.Key(Uint8List.fromList(keyBytes));
      final iv = enc.IV.fromSecureRandom(16);

      final encrypter = enc.Encrypter(enc.AES(encKey, mode: enc.AESMode.cbc));
      final encrypted = encrypter.encrypt('{"test": 123}', iv: iv);

      // Create a corrupted auth tag
      final badAuthTag = Uint8List(32); // All zeros, invalid HMAC

      final tamperedFile = File('${tempDir.path}/tampered.nudgebackup');
      await tamperedFile.writeAsString(jsonEncode({
        'magic': BackupManager.legacyMagicV2,
        'schemaVersion': BackupManager.schemaVersion,
        'iv': base64Encode(iv.bytes),
        'ciphertext': encrypted.base64,
        'authTag': base64Encode(badAuthTag),
      }));

      expect(
        () => BackupManager.inspectBackupFile(tamperedFile.path),
        throwsA(
          predicate((e) =>
              e is FormatException &&
              e.message.contains('Authentication tag mismatch')),
        ),
      );
    });

    test('Legacy v2: Correctly decrypts and inspects valid backup container with master key', () async {
      final masterKey = await SecureStorageUtil.getOrCreateMasterKey();
      final keyBytes = sha256.convert(utf8.encode(masterKey)).bytes;
      final encKey = enc.Key(Uint8List.fromList(keyBytes));
      final iv = enc.IV.fromSecureRandom(16);

      final payload = {
        'manifest': {
          'magic': BackupManager.legacyMagicV2,
          'schemaVersion': BackupManager.schemaVersion,
          'appVersion': '2.0.0',
          'exportedAt': DateTime.now().toIso8601String(),
        },
        'reminders': [
          {
            'id': 'test_rem_1',
            'message': 'Test Reminder',
            'scheduledAt': DateTime.now().add(const Duration(days: 1)).toIso8601String(),
            'priority': 'normal',
            'alertStyle': 'notification',
            'repeatRule': 'none',
            'checklist': [],
          }
        ],
        'occurrences': [],
        'folders': [],
        'history': [],
        'templates': [],
        'companion': null,
        'media': {},
      };

      final encrypter = enc.Encrypter(enc.AES(encKey, mode: enc.AESMode.cbc));
      final encrypted = encrypter.encrypt(jsonEncode(payload), iv: iv);

      final hmacKey = sha256.convert(utf8.encode('$masterKey:HMAC')).bytes;
      final hmac = Hmac(sha256, hmacKey);
      final authTag = hmac.convert([...iv.bytes, ...encrypted.bytes]).bytes;

      final validFile = File('${tempDir.path}/valid.nudgebackup');
      await validFile.writeAsString(jsonEncode({
        'magic': BackupManager.legacyMagicV2,
        'schemaVersion': BackupManager.schemaVersion,
        'iv': base64Encode(iv.bytes),
        'ciphertext': encrypted.base64,
        'authTag': base64Encode(authTag),
      }));

      final preview = await BackupManager.inspectBackupFile(
        validFile.path,
        existingRemindersOverride: [],
      );
      expect(preview.validReminders.length, equals(1));
      expect(preview.validReminders.first.id, equals('test_rem_1'));
      expect(preview.validReminders.first.message, equals('Test Reminder'));
      expect(preview.invalidCount, equals(0));
    });

    test('Password Protected: isPasswordProtected correctly identifies JSON encrypted backups', () async {
      final jsonFile = File('${tempDir.path}/test_enc.json');
      await jsonFile.writeAsString(jsonEncode({
        'magic': BackupManager.containerMagic,
        'schemaVersion': BackupManager.schemaVersion,
        'kdf': 'PBKDF2_SHA256',
        'salt': 'abc',
      }));
      expect(await BackupManager.isPasswordProtected(jsonFile.path), isTrue);

      final legacyFile = File('${tempDir.path}/test_legacy.nudgebackup');
      await legacyFile.writeAsString(jsonEncode({
        'magic': BackupManager.legacyMagicV2,
        'schemaVersion': 2,
      }));
      expect(await BackupManager.isPasswordProtected(legacyFile.path), isFalse);
    });

    test('Password Protected: Successfully encrypts and decrypts across simulated devices with password', () async {
      const password = 'MySecureNudgePassword2026!';
      final salt = Pbkdf2Util.generateSalt(16);
      const iterations = 10000;

      final encKeyBytes = Pbkdf2Util.deriveKey(password, salt, iterations: iterations, blockIndex: 1);
      final hmacKeyBytes = Pbkdf2Util.deriveKey(password, salt, iterations: iterations, blockIndex: 2);

      final payload = {
        'manifest': {
          'magic': BackupManager.containerMagic,
          'schemaVersion': 3,
          'appVersion': '2.0.0',
          'exportedAt': DateTime.now().toIso8601String(),
        },
        'reminders': [
          {
            'id': 'cross_device_rem_1',
            'message': 'Cross-device portable reminder',
            'scheduledAt': DateTime.now().add(const Duration(days: 2)).toIso8601String(),
            'priority': 'urgent',
            'alertStyle': 'alarm',
            'repeatRule': 'none',
            'checklist': [],
          }
        ],
        'todos': [
          {
            'id': 'todo_cross_1',
            'title': 'Portable task',
            'priority': 'high',
            'status': 'pending',
          }
        ],
        'records': [
          {
            'id': 'record_cross_1',
            'title': 'Portable note',
            'content': 'Cross-device note content',
            'recordType': 'note',
          }
        ],
        'tags': [
          {
            'id': 'tag_cross_1',
            'name': 'security',
          }
        ],
        'occurrences': [],
        'folders': [],
        'history': [],
        'templates': [],
        'companion': null,
        'media': {},
      };

      final iv = enc.IV.fromSecureRandom(16);
      final encrypter = enc.Encrypter(enc.AES(enc.Key(encKeyBytes), mode: enc.AESMode.cbc));
      final encrypted = encrypter.encrypt(jsonEncode(payload), iv: iv);

      final hmac = Hmac(sha256, hmacKeyBytes);
      final authTag = hmac.convert([...salt, ...iv.bytes, ...encrypted.bytes]).bytes;

      final backupFile = File('${tempDir.path}/nudge_backup_cross_device.json');
      await backupFile.writeAsString(jsonEncode({
        'magic': BackupManager.containerMagic,
        'schemaVersion': 3,
        'appVersion': '2.0.0',
        'createdAt': DateTime.now().toIso8601String(),
        'kdf': 'PBKDF2_SHA256',
        'iterations': iterations,
        'salt': base64Encode(salt),
        'iv': base64Encode(iv.bytes),
        'ciphertext': encrypted.base64,
        'authTag': base64Encode(authTag),
      }));

      // SIMULATE DEVICE B: Inspect backup file with matching password
      final preview = await BackupManager.inspectBackupFile(
        backupFile.path,
        password: password,
        existingRemindersOverride: [],
      );

      expect(preview.validReminders.length, equals(1));
      expect(preview.validReminders.first.message, equals('Cross-device portable reminder'));
      expect(preview.validTodos.length, equals(1));
      expect(preview.validTodos.first.title, equals('Portable task'));
      expect(preview.validRecords.length, equals(1));
      expect(preview.validRecords.first.title, equals('Portable note'));
      expect(preview.validTags.length, equals(1));
      expect(preview.validTags.first.name, equals('security'));
    });

    test('Password Protected: Rejects inspection when password is missing', () async {
      final salt = Pbkdf2Util.generateSalt(16);
      final jsonFile = File('${tempDir.path}/nudge_backup_nopwd.json');
      await jsonFile.writeAsString(jsonEncode({
        'magic': BackupManager.containerMagic,
        'schemaVersion': 3,
        'salt': base64Encode(salt),
        'iv': base64Encode(Uint8List(16)),
        'ciphertext': base64Encode(Uint8List(16)),
        'authTag': base64Encode(Uint8List(32)),
      }));

      expect(
        () => BackupManager.inspectBackupFile(jsonFile.path),
        throwsA(
          predicate((e) =>
              e is FormatException &&
              e.message.contains('Password required')),
        ),
      );
    });

    test('Password Protected: Rejects inspection when password is wrong', () async {
      const password = 'CorrectPassword123';
      const wrongPassword = 'WrongPassword456';
      final salt = Pbkdf2Util.generateSalt(16);

      final encKeyBytes = Pbkdf2Util.deriveKey(password, salt, iterations: 10000, blockIndex: 1);
      final hmacKeyBytes = Pbkdf2Util.deriveKey(password, salt, iterations: 10000, blockIndex: 2);

      final iv = enc.IV.fromSecureRandom(16);
      final encrypter = enc.Encrypter(enc.AES(enc.Key(encKeyBytes), mode: enc.AESMode.cbc));
      final encrypted = encrypter.encrypt('{"reminders":[]}', iv: iv);

      final hmac = Hmac(sha256, hmacKeyBytes);
      final authTag = hmac.convert([...salt, ...iv.bytes, ...encrypted.bytes]).bytes;

      final backupFile = File('${tempDir.path}/wrong_pwd.json');
      await backupFile.writeAsString(jsonEncode({
        'magic': BackupManager.containerMagic,
        'schemaVersion': 3,
        'salt': base64Encode(salt),
        'iv': base64Encode(iv.bytes),
        'ciphertext': encrypted.base64,
        'authTag': base64Encode(authTag),
      }));

      expect(
        () => BackupManager.inspectBackupFile(backupFile.path, password: wrongPassword),
        throwsA(
          predicate((e) =>
              e is FormatException &&
              e.message.contains('Incorrect password or corrupted backup file')),
        ),
      );
    });

    test('Password Protected: Rejects container when ciphertext is corrupted or tampered with', () async {
      const password = 'TestPassword123';
      final salt = Pbkdf2Util.generateSalt(16);

      final encKeyBytes = Pbkdf2Util.deriveKey(password, salt, iterations: 10000, blockIndex: 1);
      final hmacKeyBytes = Pbkdf2Util.deriveKey(password, salt, iterations: 10000, blockIndex: 2);

      final iv = enc.IV.fromSecureRandom(16);
      final encrypter = enc.Encrypter(enc.AES(enc.Key(encKeyBytes), mode: enc.AESMode.cbc));
      final encrypted = encrypter.encrypt('{"reminders":[]}', iv: iv);

      final hmac = Hmac(sha256, hmacKeyBytes);
      final authTag = hmac.convert([...salt, ...iv.bytes, ...encrypted.bytes]).bytes;

      // Tamper with ciphertext by flipping one byte
      final tamperedCipherBytes = Uint8List.fromList(encrypted.bytes);
      tamperedCipherBytes[0] ^= 0xFF;

      final tamperedFile = File('${tempDir.path}/tampered_cipher.json');
      await tamperedFile.writeAsString(jsonEncode({
        'magic': BackupManager.containerMagic,
        'schemaVersion': 3,
        'salt': base64Encode(salt),
        'iv': base64Encode(iv.bytes),
        'ciphertext': base64Encode(tamperedCipherBytes),
        'authTag': base64Encode(authTag),
      }));

      expect(
        () => BackupManager.inspectBackupFile(tamperedFile.path, password: password),
        throwsA(
          predicate((e) =>
              e is FormatException &&
              e.message.contains('Incorrect password or corrupted backup file')),
        ),
      );
    });
  });
}
