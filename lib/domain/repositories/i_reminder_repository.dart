import '../entities/reminder.dart';

abstract class IReminderRepository {
  Future<List<Reminder>> getAllReminders();
  Future<Reminder?> getReminderById(String id);
  Future<void> saveReminder(Reminder reminder);
  Future<void> updateReminder(Reminder reminder);
  Future<void> deleteReminder(String id);
  Future<void> clearAllReminders();
}
