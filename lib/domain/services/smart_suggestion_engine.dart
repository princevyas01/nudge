import 'package:uuid/uuid.dart';
import '../entities/reminder.dart';
import '../entities/smart_suggestion.dart';

class SmartSuggestionEngine {
  static List<SmartSuggestion> generateSuggestions(List<Reminder> reminders) {
    final suggestions = <SmartSuggestion>[];

    for (final reminder in reminders) {
      if (reminder.isDone || reminder.isArchived) continue;

      // 1. Task snoozed 3 times -> Frequently snoozed suggestion
      if (reminder.snoozeCount >= 3) {
        suggestions.add(SmartSuggestion(
          id: const Uuid().v4(),
          title: 'Frequently Snoozed Task',
          description: '"${reminder.message}" was snoozed 3 times. Consider rescheduling to tomorrow morning.',
          reminderId: reminder.id,
          suggestedTime: DateTime.now().add(const Duration(days: 1)).copyWith(hour: 10, minute: 0),
          actionType: 'reschedule',
        ));
      }

      // 2. Overdue task for > 2 hours -> Recovery suggestion
      if (reminder.isOverdue && DateTime.now().difference(reminder.scheduledAt).inHours >= 2) {
        suggestions.add(SmartSuggestion(
          id: const Uuid().v4(),
          title: 'Missed Reminder Recovery',
          description: '"${reminder.message}" is overdue. Move to this evening or complete now.',
          reminderId: reminder.id,
          suggestedTime: DateTime.now().copyWith(hour: 19, minute: 0),
          actionType: 'recover',
        ));
      }
    }

    return suggestions;
  }
}
