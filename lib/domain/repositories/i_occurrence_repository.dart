import '../entities/reminder_occurrence.dart';

abstract class IOccurrenceRepository {
  Future<List<ReminderOccurrence>> getAllOccurrences();
  Future<List<ReminderOccurrence>> getOccurrencesForReminder(String reminderId);
  Future<ReminderOccurrence?> getOccurrenceById(String id);
  Future<ReminderOccurrence?> getPendingOccurrence(String reminderId);
  Future<void> saveOccurrence(ReminderOccurrence occurrence);
  Future<void> updateOccurrence(ReminderOccurrence occurrence);
  Future<void> deleteOccurrence(String id);
  Future<void> deleteOccurrencesForReminder(String reminderId);
}
