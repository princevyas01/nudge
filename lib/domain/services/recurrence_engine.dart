import '../entities/reminder.dart';
import '../enums/enums.dart';
import '../../core/utils/date_utils.dart';

class RecurrenceEngine {
  /// Computes the nth weekday of a given month (e.g. 2nd Tuesday of May).
  /// [nth] is 1-indexed (1 to 5). [weekday] is 1 (Monday) to 7 (Sunday).
  static DateTime calculateNthWeekdayOfMonth({
    required int year,
    required int month,
    required int nth,
    required int weekday,
    required int hour,
    required int minute,
  }) {
    DateTime firstDay = DateTime(year, month, 1, hour, minute);
    int diff = (weekday - firstDay.weekday) % 7;
    if (diff < 0) diff += 7;

    int targetDay = 1 + diff + (nth - 1) * 7;
    final daysInMonth = DateTime(year, month + 1, 0).day;
    if (targetDay > daysInMonth) {
      // Fallback to the last matching weekday of that month
      targetDay -= 7;
    }
    return DateTime(year, month, targetDay, hour, minute);
  }

  /// Calculates the next occurrence timestamp for a given reminder.
  /// Returns null if the reminder does not repeat or has reached its end criteria.
  static DateTime? calculateNextOccurrence(Reminder reminder, [DateTime? fromDate]) {
    if (reminder.repeatRule == RepeatRule.none) return null;

    final base = fromDate ?? reminder.scheduledAt;
    final origHour = reminder.scheduledAt.hour;
    final origMinute = reminder.scheduledAt.minute;
    DateTime next;

    switch (reminder.repeatRule) {
      case RepeatRule.daily:
        // Wall-clock safe date construction to handle DST transitions
        next = DateTime(base.year, base.month, base.day + 1, origHour, origMinute);
        break;

      case RepeatRule.weekly:
        next = DateTime(base.year, base.month, base.day + 7, origHour, origMinute);
        break;

      case RepeatRule.monthly:
        int nextYear = base.year;
        int nextMonth = base.month + 1;
        if (nextMonth > 12) {
          nextMonth = 1;
          nextYear += 1;
        }
        next = NudgeDateUtils.clampMonthDay(
          nextYear,
          nextMonth,
          reminder.scheduledAt.day,
          origHour,
          origMinute,
        );
        break;

      case RepeatRule.weekdays:
        // Mon = 1 ... Sun = 7
        var candidate = DateTime(base.year, base.month, base.day + 1, origHour, origMinute);
        while (candidate.weekday == DateTime.saturday || candidate.weekday == DateTime.sunday) {
          candidate = DateTime(candidate.year, candidate.month, candidate.day + 1, origHour, origMinute);
        }
        next = candidate;
        break;

      case RepeatRule.weekends:
        var candidate = DateTime(base.year, base.month, base.day + 1, origHour, origMinute);
        while (candidate.weekday != DateTime.saturday && candidate.weekday != DateTime.sunday) {
          candidate = DateTime(candidate.year, candidate.month, candidate.day + 1, origHour, origMinute);
        }
        next = candidate;
        break;

      case RepeatRule.customInterval:
        final interval = (reminder.customRepeatInterval != null && reminder.customRepeatInterval! > 0)
            ? reminder.customRepeatInterval!
            : 1;
        final type = reminder.customRepeatType ?? CustomRepeatType.days;
        final specificDays = reminder.customRepeatDays;

        if (specificDays != null && specificDays.isNotEmpty) {
          // Find the next day matching the list of weekdays (1=Mon ... 7=Sun)
          var candidate = DateTime(base.year, base.month, base.day + 1, origHour, origMinute);
          while (!specificDays.contains(candidate.weekday)) {
            candidate = DateTime(candidate.year, candidate.month, candidate.day + 1, origHour, origMinute);
          }
          next = candidate;
        } else {
          switch (type) {
            case CustomRepeatType.days:
              next = DateTime(base.year, base.month, base.day + interval, origHour, origMinute);
              break;
            case CustomRepeatType.weeks:
              next = DateTime(base.year, base.month, base.day + (interval * 7), origHour, origMinute);
              break;
            case CustomRepeatType.months:
              int nextYear = base.year;
              int nextMonth = base.month + interval;
              while (nextMonth > 12) {
                nextMonth -= 12;
                nextYear += 1;
              }
              next = NudgeDateUtils.clampMonthDay(
                nextYear,
                nextMonth,
                reminder.scheduledAt.day,
                origHour,
                origMinute,
              );
              break;
          }
        }
        break;

      case RepeatRule.none:
        return null;
    }

    // Check repeat end date
    if (reminder.repeatEndDate != null && next.isAfter(reminder.repeatEndDate!)) {
      return null;
    }

    // Check repeat end occurrences
    if (reminder.repeatEndOccurrences != null && reminder.repeatEndOccurrences! <= 1) {
      return null;
    }

    return next;
  }

  /// Catches up a recurring reminder that has been overdue across multiple cycles.
  /// Iteratively advances to the first occurrence that is >= [referenceTime].
  static DateTime? catchUpToFuture(Reminder reminder, DateTime referenceTime) {
    if (reminder.repeatRule == RepeatRule.none) return null;

    DateTime? current = reminder.scheduledAt;
    int remainingOccurrences = reminder.repeatEndOccurrences ?? 999999;

    while (current != null && current.isBefore(referenceTime) && remainingOccurrences > 1) {
      final updatedReminder = reminder.copyWith(
        scheduledAt: current,
        repeatEndOccurrences: remainingOccurrences,
      );
      current = calculateNextOccurrence(updatedReminder, current);
      remainingOccurrences--;
    }

    return current;
  }
}
