import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/constants/app_constants.dart';
import '../../core/logging/app_logger.dart';
import '../../data/database/app_database.dart';
import '../../platform/alarms/alarm_platform_service.dart';
import '../../platform/notifications/notification_platform_service.dart';
import '../../platform/widgets/home_widget_bridge.dart';
import 'reminder_controller.dart';
import 'folder_controller.dart';

class SettingsController extends ChangeNotifier {
  static const String _subsystem = 'SettingsController';

  int _defaultSnoozeMinutes = AppConstants.defaultSnoozeMinutes;
  int get defaultSnoozeMinutes => _defaultSnoozeMinutes;

  bool _soundEnabled = true;
  bool get soundEnabled => _soundEnabled;

  String? _customSoundPath;
  String? get customSoundPath => _customSoundPath;

  String? _customSoundTitle;
  String? get customSoundTitle => _customSoundTitle;

  int _customSoundStartMs = 0;
  int get customSoundStartMs => _customSoundStartMs;

  int _customSoundEndMs = -1;
  int get customSoundEndMs => _customSoundEndMs;

  bool get hasCustomSound => _customSoundPath != null && _customSoundPath!.isNotEmpty;

  SettingsController() {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _defaultSnoozeMinutes = prefs.getInt(AppConstants.prefDefaultSnooze) ?? AppConstants.defaultSnoozeMinutes;
    _soundEnabled = prefs.getBool(AppConstants.prefSoundEnabled) ?? true;

    final customSound = await AlarmPlatformService.getCustomAlarmSound();
    if (customSound != null) {
      _customSoundPath = customSound['filePath'] as String?;
      _customSoundStartMs = (customSound['startMs'] as num?)?.toInt() ?? 0;
      _customSoundEndMs = (customSound['endMs'] as num?)?.toInt() ?? -1;
      _customSoundTitle = customSound['title'] as String?;
    }

    notifyListeners();
  }

  Future<void> refreshCustomSound() async {
    final customSound = await AlarmPlatformService.getCustomAlarmSound();
    if (customSound != null) {
      _customSoundPath = customSound['filePath'] as String?;
      _customSoundStartMs = (customSound['startMs'] as num?)?.toInt() ?? 0;
      _customSoundEndMs = (customSound['endMs'] as num?)?.toInt() ?? -1;
      _customSoundTitle = customSound['title'] as String?;
    } else {
      _customSoundPath = null;
      _customSoundTitle = null;
      _customSoundStartMs = 0;
      _customSoundEndMs = -1;
    }
    notifyListeners();
  }

  Future<void> setCustomSound({
    required String filePath,
    required int startMs,
    required int endMs,
    String? title,
  }) async {
    _customSoundPath = filePath;
    _customSoundStartMs = startMs;
    _customSoundEndMs = endMs;
    _customSoundTitle = title;
    notifyListeners();

    await AlarmPlatformService.saveCustomAlarmSound(
      filePath,
      startMs,
      endMs,
      title: title,
    );
  }

  Future<void> resetCustomSound() async {
    _customSoundPath = null;
    _customSoundTitle = null;
    _customSoundStartMs = 0;
    _customSoundEndMs = -1;
    notifyListeners();

    await AlarmPlatformService.clearCustomAlarmSound();
  }

  Future<void> setDefaultSnoozeMinutes(int minutes) async {
    _defaultSnoozeMinutes = minutes;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(AppConstants.prefDefaultSnooze, minutes);
  }

  Future<void> setSoundEnabled(bool enabled) async {
    _soundEnabled = enabled;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(AppConstants.prefSoundEnabled, enabled);
  }

  /// Complete destructive reset of all application data, alarms, widgets, and database
  Future<void> resetAppData({
    required ReminderController reminderController,
    required FolderController folderController,
  }) async {
    AppLogger.warning(_subsystem, 'Initiating full Reset App Data');

    // 1. Cancel all alarms & stop ringing
    await AlarmPlatformService.dismissRingingAlarm();
    for (final r in reminderController.reminders) {
      await AlarmPlatformService.cancelAlarm(r.id);
    }
    await NotificationPlatformService.cancelAll();

    // 2. Clear home widget
    await HomeWidgetBridge.updateWidget([]);

    // 3. Reset database destructively and reseed
    await AppDatabase.resetDatabase();

    // 4. Reload controllers with fresh initial data
    await reminderController.loadReminders();
    await folderController.loadFolders();

    // 5. Reset preferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(AppConstants.prefTimerEndTime);
    await prefs.remove(AppConstants.prefTimerTotalDuration);
    await prefs.remove(AppConstants.prefTimerIsRunning);

    AppLogger.info(_subsystem, 'Reset App Data completed successfully');
    notifyListeners();
  }
}
