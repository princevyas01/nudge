import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart' as ph;

import '../../core/logging/app_logger.dart';
import '../../platform/alarms/alarm_platform_service.dart';
import '../../platform/permissions/permission_manager.dart';

class ReliabilityController extends ChangeNotifier {
  static const String _subsystem = 'ReliabilityController';

  bool _notificationsEnabled = false;
  bool _exactAlarmsEnabled = false;
  bool _fullScreenIntentEnabled = false;
  bool _batteryOptimizationIgnored = false;

  bool get notificationsEnabled => _notificationsEnabled;
  bool get exactAlarmsEnabled => _exactAlarmsEnabled;
  bool get fullScreenIntentEnabled => _fullScreenIntentEnabled;
  bool get batteryOptimizationIgnored => _batteryOptimizationIgnored;

  bool get isFullyReliable =>
      _notificationsEnabled &&
      _exactAlarmsEnabled &&
      _fullScreenIntentEnabled &&
      _batteryOptimizationIgnored;

  int get reliabilityScore {
    int score = 0;
    if (_notificationsEnabled) score += 25;
    if (_exactAlarmsEnabled) score += 35;
    if (_fullScreenIntentEnabled) score += 20;
    if (_batteryOptimizationIgnored) score += 20;
    return score;
  }

  Future<void> refreshStatuses() async {
    try {
      _notificationsEnabled = await ph.Permission.notification.isGranted;
      _exactAlarmsEnabled = await AlarmPlatformService.canScheduleExactAlarms();
      _fullScreenIntentEnabled = await AlarmPlatformService.canUseFullScreenIntent();
      _batteryOptimizationIgnored =
          await PermissionManager.isIgnoringBatteryOptimizations();
    } catch (e, stack) {
      AppLogger.error(
        _subsystem,
        'Failed to refresh reliability status',
        error: e,
        stackTrace: stack,
      );
    }
    notifyListeners();
  }

  Future<void> requestFullScreenIntent() async {
    await AlarmPlatformService.openFullScreenIntentSettings();
    await refreshStatuses();
  }

  Future<void> requestExactAlarmAccess() async {
    await AlarmPlatformService.openExactAlarmSettings();
    await refreshStatuses();
  }

  Future<void> requestExactAlarms() => requestExactAlarmAccess();

  Future<void> requestNotificationPermission() async {
    await PermissionManager.requestNotificationPermission();
    await refreshStatuses();
  }

  Future<void> requestNotifications() => requestNotificationPermission();

  Future<void> requestBatteryOptimization() async {
    await PermissionManager.openBatteryOptimizationSettings();
    await refreshStatuses();
  }

  Future<void> openAppSettings() async {
    await PermissionManager.openAppSettings();
    await refreshStatuses();
  }
}
