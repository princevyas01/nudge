class TimeService {
  static DateTime Function() _clock = () => DateTime.now();

  /// Returns the current DateTime, using the custom clock if set.
  static DateTime now() => _clock();

  /// Returns the start of the current day (00:00:00.000).
  static DateTime today() {
    final current = now();
    return DateTime(current.year, current.month, current.day);
  }

  /// Checks if the given DateTime is today.
  static bool isToday(DateTime dateTime) {
    final current = now();
    return dateTime.year == current.year &&
        dateTime.month == current.month &&
        dateTime.day == current.day;
  }

  /// Checks if two DateTimes fall on the same calendar day.
  static bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  /// Returns 00:00:00.000 for the given date.
  static DateTime startOfDay(DateTime dateTime) {
    return DateTime(dateTime.year, dateTime.month, dateTime.day);
  }

  /// Returns 23:59:59.999 for the given date.
  static DateTime endOfDay(DateTime dateTime) {
    return DateTime(dateTime.year, dateTime.month, dateTime.day, 23, 59, 59, 999);
  }

  /// Allows unit tests to freeze or control time deterministically.
  static void setCustomClock(DateTime Function() customClock) {
    _clock = customClock;
  }

  /// Resets clock to real system time.
  static void resetClock() {
    _clock = () => DateTime.now();
  }
}
