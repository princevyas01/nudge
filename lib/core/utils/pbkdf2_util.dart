import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';

/// Pure-Dart PBKDF2-HMAC-SHA256 implementation adhering to RFC 2898 / PKCS #5 v2.0.
/// Provides deterministic key derivation from passwords across devices without
/// relying on device-bound hardware keystores.
class Pbkdf2Util {
  static const int defaultIterations = 10000;

  /// Generates a cryptographically secure random salt of [length] bytes.
  static Uint8List generateSalt([int length = 16]) {
    final random = Random.secure();
    return Uint8List.fromList(List<int>.generate(length, (_) => random.nextInt(256)));
  }

  /// Derives a 32-byte (256-bit) key for a given [blockIndex] using PBKDF2-HMAC-SHA256.
  /// - blockIndex 1: Encryption Key (AES-256)
  /// - blockIndex 2: Authentication Key (HMAC-SHA256)
  static Uint8List deriveKey(
    String password,
    Uint8List salt, {
    int iterations = defaultIterations,
    int blockIndex = 1,
  }) {
    final passwordBytes = utf8.encode(password);
    final hmac = Hmac(sha256, passwordBytes);

    final blockBytes = Uint8List(4);
    ByteData.view(blockBytes.buffer).setUint32(0, blockIndex, Endian.big);

    final initial = Uint8List(salt.length + 4);
    initial.setRange(0, salt.length, salt);
    initial.setRange(salt.length, salt.length + 4, blockBytes);

    var u = Uint8List.fromList(hmac.convert(initial).bytes);
    final result = Uint8List.fromList(u);

    for (int i = 1; i < iterations; i++) {
      u = Uint8List.fromList(hmac.convert(u).bytes);
      for (int j = 0; j < 32; j++) {
        result[j] ^= u[j];
      }
    }

    return result;
  }

  /// Constant-time byte comparison to prevent timing attacks.
  static bool constantTimeEquals(List<int> a, List<int> b) {
    if (a.length != b.length) return false;
    var diff = 0;
    for (int i = 0; i < a.length; i++) {
      diff |= a[i] ^ b[i];
    }
    return diff == 0;
  }
}
