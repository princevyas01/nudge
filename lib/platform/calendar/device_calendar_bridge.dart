import 'package:device_calendar/device_calendar.dart' hide Reminder;
import 'package:timezone/data/latest.dart' as tz;
import '../../core/logging/app_logger.dart';
import '../../domain/entities/reminder.dart';
import 'i_calendar_bridge.dart';

class DeviceCalendarBridge implements ICalendarBridge {
  static const String _subsystem = 'DeviceCalendarBridge';
  final DeviceCalendarPlugin _calendarPlugin = DeviceCalendarPlugin();

  @override
  Future<String?> syncReminderToCalendar(Reminder reminder) async {
    try {
      tz.initializeTimeZones();
      final permissions = await _calendarPlugin.hasPermissions();
      if (permissions.isSuccess && !(permissions.data ?? false)) {
        final request = await _calendarPlugin.requestPermissions();
        if (!request.isSuccess || !(request.data ?? false)) {
          AppLogger.warning(_subsystem, 'Calendar permission denied');
          return null;
        }
      }

      final calendarsResult = await _calendarPlugin.retrieveCalendars();
      if (!calendarsResult.isSuccess || calendarsResult.data == null || calendarsResult.data!.isEmpty) {
        return null;
      }

      final defaultCal = calendarsResult.data!.firstWhere(
        (c) => c.isDefault ?? false,
        orElse: () => calendarsResult.data!.first,
      );

      final event = Event(
        defaultCal.id,
        eventId: (reminder.calendarEventId != null && reminder.calendarEventId != 'pending')
            ? reminder.calendarEventId
            : null,
      );
      event.title = reminder.message;
      event.start = TZDateTime.from(reminder.scheduledAt, local);
      event.end = TZDateTime.from(reminder.scheduledAt.add(const Duration(hours: 1)), local);

      final res = await _calendarPlugin.createOrUpdateEvent(event);
      if (res?.isSuccess == true && res?.data != null) {
        AppLogger.info(_subsystem, 'Synced reminder to calendar event ID: ${res?.data}');
        return res?.data;
      }
    } catch (e, stack) {
      AppLogger.error(_subsystem, 'Failed to sync reminder to device calendar', error: e, stackTrace: stack);
    }
    return null;
  }

  @override
  Future<void> removeReminderFromCalendar(String? eventId) async {
    if (eventId == null || eventId == 'pending') return;
    try {
      final calendarsResult = await _calendarPlugin.retrieveCalendars();
      if (calendarsResult.isSuccess && calendarsResult.data != null) {
        final defaultCal = calendarsResult.data!.firstWhere(
          (c) => c.isDefault ?? false,
          orElse: () => calendarsResult.data!.first,
        );
        await _calendarPlugin.deleteEvent(defaultCal.id, eventId);
        AppLogger.info(_subsystem, 'Deleted calendar event: $eventId');
      }
    } catch (e) {
      AppLogger.warning(_subsystem, 'Failed to delete calendar event $eventId: $e');
    }
  }
}
