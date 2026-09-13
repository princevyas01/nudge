class Fnv1aHash {
  /// Deterministic 32-bit FNV-1a hash algorithm converting string UUID to positive integer.
  /// Stable across device reboots and application restarts.
  static int hash32(String input) {
    var hash = 0x811c9dc5;
    for (final codeUnit in input.codeUnits) {
      hash = (hash ^ codeUnit) * 0x01000193;
      hash &= 0x7fffffff;
    }
    return hash == 0 ? 1 : hash;
  }
}
