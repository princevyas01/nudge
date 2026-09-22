import 'package:flutter_test/flutter_test.dart';
import 'package:nudge/domain/entities/reminder.dart';
import 'package:nudge/domain/entities/reminder_occurrence.dart';
import 'package:nudge/domain/enums/enums.dart';
import 'package:nudge/domain/services/stats_calculator.dart';

void main() {
  group('StatsCalculator Unit Tests', () {
    test('Empty data calculates clean zeroed stats', () {
      final stats = StatsCalculator.calculate(
        reminders: [],
        occurrences: [],
        history: [],
      );

      expect(stats.totalReminders, equals(0));
      expect(stats.totalOccurrences, equals(0));
      expect(stats.completedReminders, equals(0));
      expect(stats.completionPercentage, equals(0.0));
      expect(stats.totalSnoozes, equals(0));
      expect(stats.averageSnoozeFrequency, equals(0.0));
      expect(stats.hourlyDistribution.length, equals(24));
      expect(stats.sevenDayCompletionTrend.length, equals(7));
    });

    test('Occurrence-based completion percentage and snooze metrics', () {
      final occurrences = [
        ReminderOccurrence(
          id: 'o1',
          reminderId: 'r1',
          scheduledAt: DateTime(2026, 9, 10, 9, 0),
          status: OccurrenceStatus.completed,
          completedAt: DateTime(2026, 9, 10, 9, 5),
          snoozeCount: 1,
        ),
        ReminderOccurrence(
          id: 'o2',
          reminderId: 'r1',
          scheduledAt: DateTime(2026, 9, 11, 9, 0),
          status: OccurrenceStatus.completed,
          completedAt: DateTime(2026, 9, 11, 9, 10),
          snoozeCount: 2,
        ),
        ReminderOccurrence(
          id: 'o3',
          reminderId: 'r1',
          scheduledAt: DateTime(2026, 9, 12, 9, 0),
          status: OccurrenceStatus.pending,
          snoozeCount: 0,
        ),
        ReminderOccurrence(
          id: 'o4',
          reminderId: 'r1',
          scheduledAt: DateTime(2026, 9, 13, 9, 0),
          status: OccurrenceStatus.skipped,
          snoozeCount: 0,
        ),
      ];

      final reminders = [
        Reminder(
          id: 'r1',
          message: 'Daily Routine',
          scheduledAt: DateTime(2026, 9, 10, 9, 0),
        ),
      ];

      final stats = StatsCalculator.calculate(
        reminders: reminders,
        occurrences: occurrences,
        history: [],
      );

      expect(stats.totalOccurrences, equals(4));
      expect(stats.completedReminders, equals(2));
      expect(stats.completionPercentage, equals(50.0)); // 2 / 4 = 50%
      expect(stats.totalSnoozes, equals(3)); // 1 + 2 = 3
      expect(stats.averageSnoozeFrequency, equals(0.75)); // 3 / 4 = 0.75
    });

    test('Most missed folder computation', () {
      final now = DateTime.now();
      final overduePast = now.subtract(const Duration(hours: 2));

      final reminders = [
        Reminder(
          id: 'r1',
          message: 'Work Task 1',
          scheduledAt: overduePast,
          folderId: 'work_folder',
        ),
        Reminder(
          id: 'r2',
          message: 'Work Task 2',
          scheduledAt: overduePast,
          folderId: 'work_folder',
        ),
        Reminder(
          id: 'r3',
          message: 'Personal Task',
          scheduledAt: overduePast,
          folderId: 'personal_folder',
        ),
      ];

      final stats = StatsCalculator.calculate(
        reminders: reminders,
        occurrences: [],
        history: [],
      );

      expect(stats.mostMissedFolderId, equals('work_folder'));
    });

    test('Productive time window derived from completion hour', () {
      final morningCompletion = DateTime(2026, 9, 10, 10, 30); // 10:30 AM is Morning (6..12)

      final occurrences = [
        ReminderOccurrence(
          id: 'o1',
          reminderId: 'r1',
          scheduledAt: morningCompletion,
          status: OccurrenceStatus.completed,
          completedAt: morningCompletion,
        ),
      ];

      final stats = StatsCalculator.calculate(
        reminders: [],
        occurrences: occurrences,
        history: [],
      );

      expect(stats.productiveTimeWindow, equals('Morning'));
      expect(stats.hourlyDistribution[10], equals(1));
    });
  });
}
