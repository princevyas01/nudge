import 'package:flutter_test/flutter_test.dart';
import 'package:nudge/domain/entities/reminder.dart';
import 'package:nudge/domain/entities/checklist_item.dart';
import 'package:nudge/domain/entities/reminder_occurrence.dart';
import 'package:nudge/domain/enums/enums.dart';

void main() {
  group('Reminder & Occurrence Lifecycle Unit Tests', () {
    test('Reminder serialization and deserialization roundtrip', () {
      final original = Reminder(
        id: 'rem_123',
        message: 'Review quarterly goals',
        folderId: 'folder_work',
        scheduledAt: DateTime(2026, 9, 20, 15, 30),
        repeatRule: RepeatRule.weekly,
        priority: PriorityLevel.high,
        alertStyle: AlertStyle.alarm,
        isPinned: true,
        isArchived: false,
        isAlarmSynced: true,
        soundId: 'gentle_bell',
        vibrationEnabled: true,
        checklist: [
          const ChecklistItem(id: 'c1', text: 'Prepare slide deck', isDone: true),
          const ChecklistItem(id: 'c2', text: 'Review financials', isDone: false),
        ],
        customRepeatDays: [1, 3, 5],
      );

      final json = original.toJson();
      final reconstructed = Reminder.fromJson(json);

      expect(reconstructed.id, equals(original.id));
      expect(reconstructed.message, equals(original.message));
      expect(reconstructed.folderId, equals(original.folderId));
      expect(reconstructed.scheduledAt, equals(original.scheduledAt));
      expect(reconstructed.repeatRule, equals(original.repeatRule));
      expect(reconstructed.priority, equals(original.priority));
      expect(reconstructed.alertStyle, equals(original.alertStyle));
      expect(reconstructed.isPinned, equals(original.isPinned));
      expect(reconstructed.soundId, equals(original.soundId));
      expect(reconstructed.checklist.length, equals(2));
      expect(reconstructed.checklist.first.text, equals('Prepare slide deck'));
      expect(reconstructed.checklist.first.isDone, isTrue);
      expect(reconstructed.checklist[1].isDone, isFalse);
      expect(reconstructed.checklistCompletedCount, equals(1));
      expect(reconstructed.hasChecklist, isTrue);
    });

    test('Occurrence state tracking and snooze incrementing', () {
      final occ = ReminderOccurrence(
        id: 'occ_001',
        reminderId: 'rem_123',
        scheduledAt: DateTime(2026, 9, 20, 15, 30),
        status: OccurrenceStatus.pending,
        snoozeCount: 0,
      );

      expect(occ.status, equals(OccurrenceStatus.pending));
      expect(occ.isCompleted, isFalse);

      // Simulate snooze
      final snoozedOcc = occ.copyWith(
        status: OccurrenceStatus.snoozed,
        snoozeCount: occ.snoozeCount + 1,
      );

      expect(snoozedOcc.status, equals(OccurrenceStatus.snoozed));
      expect(snoozedOcc.snoozeCount, equals(1));

      // Simulate completion
      final completedOcc = snoozedOcc.copyWith(
        status: OccurrenceStatus.completed,
        completedAt: DateTime(2026, 9, 20, 15, 45),
      );

      expect(completedOcc.isCompleted, isTrue);
      expect(completedOcc.completedAt, isNotNull);
    });

    test('Snooze limit is capped at 3', () {
      final occ = ReminderOccurrence(
        id: 'occ_002',
        reminderId: 'rem_123',
        scheduledAt: DateTime(2026, 9, 20, 15, 30),
        snoozeCount: 2,
      );

      expect(occ.canSnooze, isTrue);

      final thirdSnooze = occ.copyWith(snoozeCount: occ.snoozeCount + 1);
      expect(thirdSnooze.snoozeCount, equals(3));
      expect(thirdSnooze.canSnooze, isFalse);
    });
  });
}
