import '../../domain/entities/reminder.dart';

abstract class ICalendarBridge {
  Future<String?> syncReminderToCalendar(Reminder reminder);
  Future<void> removeReminderFromCalendar(String? eventId);
}
