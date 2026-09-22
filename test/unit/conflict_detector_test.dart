import 'package:flutter_test/flutter_test.dart';
import 'package:nudge/domain/entities/reminder.dart';
import 'package:nudge/domain/enums/enums.dart';
import 'package:nudge/domain/services/conflict_detector.dart';

void main() {
  group('ConflictDetector Unit Tests', () {
    final baseTime = DateTime(2026, 9, 15, 14, 0);

    final existingReminders = [
      Reminder(
        id: 'r1',
        message: 'Team Sync',
        scheduledAt: baseTime,
        priority: PriorityLevel.normal,
      ),
      Reminder(
        id: 'r2',
        message: 'Doctor Appointment',
        scheduledAt: DateTime(2026, 9, 15, 16, 0),
        priority: PriorityLevel.high,
      ),
      Reminder(
        id: 'r3_done',
        message: 'Completed Chore',
        scheduledAt: baseTime,
        isDone: true,
      ),
      Reminder(
        id: 'r4_archived',
        message: 'Old Archived Note',
        scheduledAt: baseTime,
        isArchived: true,
      ),
    ];

    test('No conflict when times and titles are distinct', () {
      final candidate = Reminder(
        id: 'candidate',
        message: 'Grocery Shopping',
        scheduledAt: DateTime(2026, 9, 15, 18, 0),
      );

      final result = ConflictDetector.checkConflicts(
        candidate: candidate,
        existingReminders: existingReminders,
      );

      expect(result.hasConflict, isFalse);
      expect(result.conflictingReminders, isEmpty);
      expect(result.warningMessage, isNull);
    });

    test('Exact title duplicate detected even if time is different', () {
      final candidate = Reminder(
        id: 'candidate',
        message: 'team sync', // Case insensitive check
        scheduledAt: DateTime(2026, 9, 15, 19, 0), // Outside 15m
      );

      final result = ConflictDetector.checkConflicts(
        candidate: candidate,
        existingReminders: existingReminders,
      );

      expect(result.hasConflict, isTrue);
      expect(result.warningMessage, contains('exact title is already active'));
      expect(result.conflictingReminders.length, equals(1));
      expect(result.conflictingReminders.first.id, equals('r1'));
    });

    test('15-minute time overlap detected for different title', () {
      final candidate = Reminder(
        id: 'candidate',
        message: 'Coffee with Bob',
        scheduledAt: baseTime.add(const Duration(minutes: 10)), // 10m away from Team Sync
      );

      final result = ConflictDetector.checkConflicts(
        candidate: candidate,
        existingReminders: existingReminders,
      );

      expect(result.hasConflict, isTrue);
      expect(result.warningMessage, contains('Scheduled within 15m of "Team Sync"'));
      expect(result.conflictingReminders.length, equals(1));
      expect(result.conflictingReminders.first.id, equals('r1'));
    });

    test('Time overlap outside 15-minute window is not a conflict', () {
      final candidate = Reminder(
        id: 'candidate',
        message: 'Coffee with Bob',
        scheduledAt: baseTime.add(const Duration(minutes: 16)), // 16m away
      );

      final result = ConflictDetector.checkConflicts(
        candidate: candidate,
        existingReminders: existingReminders,
      );

      expect(result.hasConflict, isFalse);
      expect(result.conflictingReminders, isEmpty);
    });

    test('Duplicate title AND time overlap combination reports both', () {
      final candidate = Reminder(
        id: 'candidate',
        message: 'Team Sync',
        scheduledAt: baseTime.add(const Duration(minutes: 5)),
      );

      final result = ConflictDetector.checkConflicts(
        candidate: candidate,
        existingReminders: existingReminders,
      );

      expect(result.hasConflict, isTrue);
      expect(result.warningMessage, contains('Duplicate reminder title and scheduled within 15m'));
    });

    test('Ignores completed and archived reminders', () {
      final candidateSameAsDone = Reminder(
        id: 'candidate',
        message: 'Completed Chore',
        scheduledAt: baseTime,
      );

      final result = ConflictDetector.checkConflicts(
        candidate: candidateSameAsDone,
        existingReminders: existingReminders,
      );

      // Should conflict with r1 on time (baseTime), but NOT with r3_done on title or r4_archived
      expect(result.hasConflict, isTrue);
      expect(result.conflictingReminders.any((r) => r.id == 'r3_done'), isFalse);
      expect(result.conflictingReminders.any((r) => r.id == 'r4_archived'), isFalse);
    });

    test('Ignores self when editing existing reminder', () {
      final candidate = Reminder(
        id: 'r1',
        message: 'Team Sync',
        scheduledAt: baseTime,
      );

      final result = ConflictDetector.checkConflicts(
        candidate: candidate,
        existingReminders: existingReminders,
        currentEditingId: 'r1',
      );

      expect(result.hasConflict, isFalse);
      expect(result.conflictingReminders, isEmpty);
    });
  });
}
