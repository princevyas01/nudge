import '../entities/reminder.dart';
import '../../core/constants/app_constants.dart';

class ConflictDetectionResult {
  final bool hasConflict;
  final String? warningMessage;
  final List<Reminder> conflictingReminders;

  const ConflictDetectionResult({
    required this.hasConflict,
    this.warningMessage,
    this.conflictingReminders = const [],
  });

  static const noConflict = ConflictDetectionResult(hasConflict: false);
}

class ConflictDetector {
  /// Detects whether [candidate] conflicts with any active reminders.
  /// Ignores done reminders, archived reminders, or self (when editing).
  static ConflictDetectionResult checkConflicts({
    required Reminder candidate,
    required List<Reminder> existingReminders,
    String? currentEditingId,
  }) {
    final active = existingReminders.where((r) {
      if (r.id == currentEditingId || r.id == candidate.id) return false;
      if (r.isDone || r.isArchived) return false;
      return true;
    }).toList();

    final duplicates = <Reminder>[];
    final overlaps = <Reminder>[];

    final candidateMessageTrimmed = candidate.message.trim().toLowerCase();

    for (final reminder in active) {
      // Check duplicate active title
      if (candidateMessageTrimmed.isNotEmpty &&
          reminder.message.trim().toLowerCase() == candidateMessageTrimmed) {
        duplicates.add(reminder);
      }

      // Check within 15 minutes window
      final diffMinutes = reminder.scheduledAt.difference(candidate.scheduledAt).inMinutes.abs();
      if (diffMinutes < AppConstants.conflictWindowMinutes) {
        overlaps.add(reminder);
      }
    }

    if (duplicates.isNotEmpty && overlaps.isNotEmpty) {
      return ConflictDetectionResult(
        hasConflict: true,
        warningMessage: 'Duplicate reminder title and scheduled within 15m of "${overlaps.first.message}"',
        conflictingReminders: [...duplicates, ...overlaps],
      );
    } else if (duplicates.isNotEmpty) {
      return ConflictDetectionResult(
        hasConflict: true,
        warningMessage: 'A reminder with this exact title is already active',
        conflictingReminders: duplicates,
      );
    } else if (overlaps.isNotEmpty) {
      return ConflictDetectionResult(
        hasConflict: true,
        warningMessage: 'Scheduled within 15m of "${overlaps.first.message}" (${overlaps.first.scheduledAt.hour}:${overlaps.first.scheduledAt.minute.toString().padLeft(2, '0')})',
        conflictingReminders: overlaps,
      );
    }

    return ConflictDetectionResult.noConflict;
  }
}
