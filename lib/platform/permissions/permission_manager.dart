import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart' as ph;

import '../../core/constants/app_constants.dart';
import '../../core/logging/app_logger.dart';

class PermissionManager {
  static const String _subsystem = 'PermissionManager';

  static const MethodChannel _reliabilityChannel =
      MethodChannel(
    AppConstants.reliabilityChannel,
  );

  static Future<bool> requestNotificationPermission() async {
    try {
      final status =
          await ph.Permission.notification.request();

      AppLogger.info(
        _subsystem,
        'Notification permission status: $status',
      );

      return status.isGranted;
    } catch (e, stack) {
      AppLogger.error(
        _subsystem,
        'Notification permission request failed',
        error: e,
        stackTrace: stack,
      );

      return false;
    }
  }

  static Future<bool> requestMicrophonePermission() async {
    try {
      final status =
          await ph.Permission.microphone.request();

      AppLogger.info(
        _subsystem,
        'Microphone permission status: $status',
      );

      return status.isGranted;
    } catch (e, stack) {
      AppLogger.error(
        _subsystem,
        'Microphone permission request failed',
        error: e,
        stackTrace: stack,
      );

      return false;
    }
  }

  static Future<bool>
      isIgnoringBatteryOptimizations() async {

    try {
      final result =
          await _reliabilityChannel.invokeMethod<bool>(
        'isIgnoringBatteryOptimizations',
      );

      return result ?? false;
    } catch (e) {
      return false;
    }
  }

  static Future<void>
      openBatteryOptimizationSettings() async {

    try {
      await _reliabilityChannel.invokeMethod(
        'openBatteryOptimizationSettings',
      );
    } catch (e, stack) {
      AppLogger.error(
        _subsystem,
        'Unable to open battery optimization settings',
        error: e,
        stackTrace: stack,
      );
    }
  }

  static Future<void>
      openExactAlarmSettings() async {

    try {
      await _reliabilityChannel.invokeMethod(
        'openExactAlarmSettings',
      );
    } catch (e, stack) {
      AppLogger.error(
        _subsystem,
        'Unable to open exact alarm settings',
        error: e,
        stackTrace: stack,
      );
    }
  }

  static Future<bool>
      openAppSettings() async {

    try {
      return await ph.openAppSettings();
    } catch (_) {
      return false;
    }
  }
}
