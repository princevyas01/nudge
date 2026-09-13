import 'package:intl/intl.dart';

class NudgeDateUtils {
  static bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  static bool isToday(DateTime dt) {
    return isSameDay(dt, DateTime.now());
  }

  static bool isTomorrow(DateTime dt) {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return isSameDay(dt, tomorrow);
  }

  static bool isPast(DateTime dt) {
    return dt.isBefore(DateTime.now());
  }

  static String formatDateTime(DateTime dt) {
    return DateFormat('EEE, MMM d, y • h:mm a').format(dt);
  }

  static String formatDate(DateTime dt) {
    return DateFormat('EEE, MMM d').format(dt);
  }

  static String formatTime(DateTime dt) {
    return DateFormat('h:mm a').format(dt);
  }

  static String getRelativeDayLabel(DateTime dt) {
    final now = DateTime.now();
    if (isSameDay(dt, now)) return 'Today';
    if (isSameDay(dt, now.add(const Duration(days: 1)))) return 'Tomorrow';
    if (isSameDay(dt, now.subtract(const Duration(days: 1)))) return 'Yesterday';
    if (dt.isBefore(now)) return 'Overdue';
    return DateFormat('EEE, MMM d').format(dt);
  }

  /// Clamps day of month safely, e.g. Jan 31 + 1 month -> Feb 28 (or 29 in leap year)
  static DateTime clampMonthDay(int year, int month, int targetDay, int hour, int minute) {
    final daysInMonth = DateTime(year, month + 1, 0).day;
    final clampedDay = targetDay.clamp(1, daysInMonth);
    return DateTime(year, month, clampedDay, hour, minute);
  }
}
