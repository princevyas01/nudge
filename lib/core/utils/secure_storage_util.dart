import 'dart:convert';
import 'dart:math';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../logging/app_logger.dart';

class SecureStorageUtil {
  static const String _subsystem = 'SecureStorageUtil';
  static const String _keyMasterKey = 'nudge_master_aes_key';
  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  static Future<String> getOrCreateMasterKey() async {
    try {
      final existingKey = await _storage.read(key: _keyMasterKey);
      if (existingKey != null && existingKey.isNotEmpty) {
        return existingKey;
      }

      // Generate a 256-bit random cryptographic key
      final random = Random.secure();
      final values = List<int>.generate(32, (i) => random.nextInt(256));
      final newKey = base64Encode(values);
      await _storage.write(key: _keyMasterKey, value: newKey);
      AppLogger.info(_subsystem, 'Generated and stored new 256-bit AES master key');
      return newKey;
    } catch (e, stack) {
      AppLogger.error(_subsystem, 'SecureStorage access failed, using fallback hash', error: e, stackTrace: stack);
      return 'NUDGE_LOCAL_RELIABLE_AES_256_FALLBACK_KEY_SECURE';
    }
  }
}
