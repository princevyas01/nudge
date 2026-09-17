import '../entities/reminder_history.dart';

abstract class IHistoryRepository {
  Future<List<ReminderHistory>> getAllHistory();
  Future<List<ReminderHistory>> getHistoryForReminder(String reminderId);
  Future<void> logEvent(ReminderHistory event);
  Future<void> clearHistory();
}
