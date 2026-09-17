import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../../core/constants/app_constants.dart';
import '../../core/logging/app_logger.dart';
import '../../domain/entities/reminder.dart';

class NotificationPlatformService {
  static const String _subsystem = 'NotificationPlatformService';
  static final FlutterLocalNotificationsPlugin _notifications = FlutterLocalNotificationsPlugin();

  static Future<void> initialize({
    void Function(NotificationResponse)? onDidReceiveNotificationResponse,
    void Function(NotificationResponse)? onDidReceiveBackgroundNotificationResponse,
  }) async {
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initSettings = InitializationSettings(android: androidSettings);

    await _notifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
      onDidReceiveBackgroundNotificationResponse: onDidReceiveBackgroundNotificationResponse,
    );

    // Create Notification Channels on Android 8.0+
    final androidPlugin = _notifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();

    if (androidPlugin != null) {
      await androidPlugin.createNotificationChannel(
        const AndroidNotificationChannel(
          AppConstants.alarmChannelId,
          AppConstants.alarmChannelName,
          description: 'High-priority full-screen alarms',
          importance: Importance.max,
          playSound: false,
          enableVibration: false,
        ),
      );

      await androidPlugin.createNotificationChannel(
        const AndroidNotificationChannel(
          AppConstants.gentleChannelId,
          AppConstants.gentleChannelName,
          description: 'Gentle notification reminders with actions',
          importance: Importance.high,
          playSound: true,
          enableVibration: true,
        ),
      );
    }
    AppLogger.info(_subsystem, 'Notification channels initialized');
  }

  static Future<void> showGentleNotification(Reminder reminder, int alarmId) async {
    final actions = <AndroidNotificationAction>[];
    if (reminder.snoozeCount < AppConstants.maxSnoozeCount) {
      actions.add(const AndroidNotificationAction('snooze', 'Snooze', showsUserInterface: true));
    }
    actions.add(const AndroidNotificationAction('done', 'Done', showsUserInterface: true));

    final androidDetails = AndroidNotificationDetails(
      AppConstants.gentleChannelId,
      AppConstants.gentleChannelName,
      importance: Importance.high,
      priority: Priority.high,
      playSound: true,
      enableVibration: reminder.vibrationEnabled,
      actions: actions,
    );

    await _notifications.show(
      alarmId,
      'Nudge Reminder',
      reminder.message,
      NotificationDetails(android: androidDetails),
      payload: reminder.id,
    );
  }

  static Future<void> cancel(int id) async {
    await _notifications.cancel(id);
  }

  static Future<void> cancelAll() async {
    await _notifications.cancelAll();
  }
}
