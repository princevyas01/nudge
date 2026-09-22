import 'package:flutter_test/flutter_test.dart';
import 'package:nudge/domain/entities/reminder.dart';
import 'package:nudge/domain/enums/enums.dart';
import 'package:nudge/domain/services/recurrence_engine.dart';

void main() {
  group('RecurrenceEngine Tests', () {
    test('Rule: none returns null', () {
      final reminder = Reminder(
        message: 'One-off task',
        scheduledAt: DateTime(2026, 9, 10, 10, 0),
        repeatRule: RepeatRule.none,
      );

      final next = RecurrenceEngine.calculateNextOccurrence(reminder);
      expect(next, isNull);
    });

    test('Rule: daily advances exactly 1 day and preserves wall-clock time', () {
      final reminder = Reminder(
        message: 'Daily standup',
        scheduledAt: DateTime(2026, 9, 10, 9, 30),
        repeatRule: RepeatRule.daily,
      );

      final next = RecurrenceEngine.calculateNextOccurrence(reminder);
      expect(next, equals(DateTime(2026, 9, 11, 9, 30)));
    });

    test('Rule: weekly advances exactly 7 days', () {
      final reminder = Reminder(
        message: 'Weekly review',
        scheduledAt: DateTime(2026, 9, 10, 14, 0),
        repeatRule: RepeatRule.weekly,
      );

      final next = RecurrenceEngine.calculateNextOccurrence(reminder);
      expect(next, equals(DateTime(2026, 9, 17, 14, 0)));
    });

    test('Rule: weekdays skips Saturday and Sunday', () {
      // 2026-09-11 is Friday
      final fridayReminder = Reminder(
        message: 'Friday report',
        scheduledAt: DateTime(2026, 9, 11, 17, 0),
        repeatRule: RepeatRule.weekdays,
      );

      final next = RecurrenceEngine.calculateNextOccurrence(fridayReminder);
      // Next weekday should be Monday (2026-09-14)
      expect(next, equals(DateTime(2026, 9, 14, 17, 0)));
      expect(next!.weekday, equals(DateTime.monday));
    });

    test('Rule: weekends skips Monday through Friday', () {
      // 2026-09-13 is Sunday
      final sundayReminder = Reminder(
        message: 'Weekend workout',
        scheduledAt: DateTime(2026, 9, 13, 8, 0),
        repeatRule: RepeatRule.weekends,
      );

      final next = RecurrenceEngine.calculateNextOccurrence(sundayReminder);
      // Next weekend day should be Saturday (2026-09-19)
      expect(next, equals(DateTime(2026, 9, 19, 8, 0)));
      expect(next!.weekday, equals(DateTime.saturday));
    });

    test('Rule: monthly with month-end clamping (Jan 31 -> Feb 28 non-leap)', () {
      // 2025 is non-leap year (February has 28 days)
      final reminder = Reminder(
        message: 'Month-end bill',
        scheduledAt: DateTime(2025, 1, 31, 20, 0),
        repeatRule: RepeatRule.monthly,
      );

      final next = RecurrenceEngine.calculateNextOccurrence(reminder);
      expect(next, equals(DateTime(2025, 2, 28, 20, 0)));
    });

    test('Rule: monthly with leap year clamping (Jan 31 -> Feb 29 in 2028 leap year)', () {
      final reminder = Reminder(
        message: 'Leap year bill',
        scheduledAt: DateTime(2028, 1, 31, 10, 0),
        repeatRule: RepeatRule.monthly,
      );

      final next = RecurrenceEngine.calculateNextOccurrence(reminder);
      expect(next, equals(DateTime(2028, 2, 29, 10, 0)));
    });

    test('Rule: custom interval (every 3 days)', () {
      final reminder = Reminder(
        message: 'Water plants',
        scheduledAt: DateTime(2026, 9, 10, 11, 0),
        repeatRule: RepeatRule.customInterval,
        customRepeatInterval: 3,
        customRepeatType: CustomRepeatType.days,
      );

      final next = RecurrenceEngine.calculateNextOccurrence(reminder);
      expect(next, equals(DateTime(2026, 9, 13, 11, 0)));
    });

    test('Rule: custom specific weekdays (Mon, Wed, Fri)', () {
      // 2026-09-09 is Wednesday (3)
      final reminder = Reminder(
        message: 'Gym workout',
        scheduledAt: DateTime(2026, 9, 9, 7, 0),
        repeatRule: RepeatRule.customInterval,
        customRepeatDays: [1, 3, 5], // Mon, Wed, Fri
      );

      final next = RecurrenceEngine.calculateNextOccurrence(reminder);
      // Next after Wednesday should be Friday (2026-09-11)
      expect(next, equals(DateTime(2026, 9, 11, 7, 0)));
      expect(next!.weekday, equals(DateTime.friday));
    });

    test('Nth weekday of month: 2nd Tuesday of October 2026', () {
      // In Oct 2026:
      // Oct 1 is Thursday
      // Oct 6 is 1st Tuesday
      // Oct 13 is 2nd Tuesday
      final result = RecurrenceEngine.calculateNthWeekdayOfMonth(
        year: 2026,
        month: 10,
        nth: 2,
        weekday: DateTime.tuesday,
        hour: 15,
        minute: 0,
      );

      expect(result, equals(DateTime(2026, 10, 13, 15, 0)));
      expect(result.weekday, equals(DateTime.tuesday));
    });

    test('Recurrence termination: endOnDate respected', () {
      final reminder = Reminder(
        message: 'Temporary daily chore',
        scheduledAt: DateTime(2026, 9, 10, 8, 0),
        repeatRule: RepeatRule.daily,
        repeatEndDate: DateTime(2026, 9, 10, 23, 59),
      );

      final next = RecurrenceEngine.calculateNextOccurrence(reminder);
      expect(next, isNull);
    });

    test('Recurrence termination: endAfterOccurrences respected', () {
      final reminder = Reminder(
        message: 'Finish in 1 occurrence',
        scheduledAt: DateTime(2026, 9, 10, 8, 0),
        repeatRule: RepeatRule.daily,
        repeatEndOccurrences: 1,
      );

      final next = RecurrenceEngine.calculateNextOccurrence(reminder);
      expect(next, isNull);
    });

    test('Catch-up overdue recurrence to future', () {
      // Reminder scheduled 10 days ago with daily recurrence
      final overdueReminder = Reminder(
        message: 'Daily medicine',
        scheduledAt: DateTime(2026, 9, 1, 9, 0),
        repeatRule: RepeatRule.daily,
      );

      final targetNow = DateTime(2026, 9, 10, 12, 0);
      final caughtUp = RecurrenceEngine.catchUpToFuture(overdueReminder, targetNow);

      expect(caughtUp, isNotNull);
      expect(caughtUp!.isAfter(targetNow), isTrue);
      expect(caughtUp, equals(DateTime(2026, 9, 11, 9, 0)));
    });
  });
}
