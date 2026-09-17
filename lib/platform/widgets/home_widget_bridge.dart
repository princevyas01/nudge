import 'package:home_widget/home_widget.dart';
import '../../core/logging/app_logger.dart';
import '../../domain/entities/reminder.dart';

class HomeWidgetBridge {
  static const String _subsystem = 'HomeWidgetBridge';

  static Future<void> updateWidget(List<Reminder> upcomingReminders) async {
    try {
      final count = upcomingReminders.length;
      final countText = count > 0 ? '$count upcoming' : 'All done';

      await HomeWidget.saveWidgetData<String>('widget_count', countText);

      if (upcomingReminders.isNotEmpty) {
        await HomeWidget.saveWidgetData<String>('widget_reminder_1', upcomingReminders[0].message);
      } else {
        await HomeWidget.saveWidgetData<String>('widget_reminder_1', 'No upcoming reminders');
      }

      if (upcomingReminders.length > 1) {
        await HomeWidget.saveWidgetData<String>('widget_reminder_2', upcomingReminders[1].message);
      } else {
        await HomeWidget.saveWidgetData<String>('widget_reminder_2', '');
      }

      if (upcomingReminders.length > 2) {
        await HomeWidget.saveWidgetData<String>('widget_reminder_3', upcomingReminders[2].message);
      } else {
        await HomeWidget.saveWidgetData<String>('widget_reminder_3', '');
      }

      await HomeWidget.updateWidget(
        name: 'NudgeWidgetProvider',
        androidName: 'NudgeWidgetProvider',
      );
      AppLogger.info(_subsystem, 'Home widget updated with $count reminders');
    } catch (e) {
      AppLogger.warning(_subsystem, 'Failed to update home widget: $e');
    }
  }
}
