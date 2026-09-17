import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../../core/constants/app_constants.dart';
import '../../core/logging/app_logger.dart';
import '../../core/utils/fnv1a_hash.dart';
import '../../domain/entities/reminder.dart';

class AlarmPermissionRequiredException
    implements Exception {
  const AlarmPermissionRequiredException();

  @override
  String toString() =>
      'Exact alarm permission is required.';
}

class AlarmScheduleException
    implements Exception {
  final String message;

  const AlarmScheduleException(
    this.message,
  );

  @override
  String toString() => message;
}

class AlarmLaunchData {
  final int? alarmId;
  final String? reminderId;

  const AlarmLaunchData({
    this.alarmId,
    this.reminderId,
  });
}

class AlarmPlatformService {

  static const String _subsystem =
      'AlarmPlatformService';

  static const MethodChannel _channel =
      MethodChannel(
    AppConstants.alarmChannel,
  );

  static final StreamController<
      AlarmLaunchData> _events =
      StreamController<
          AlarmLaunchData>.broadcast();

  static final StreamController<void> _dismissEvents =
      StreamController<void>.broadcast();

  static Stream<AlarmLaunchData>
      get onAlarmTriggered =>
          _events.stream;

  static Stream<void>
      get onAlarmDismissed =>
          _dismissEvents.stream;

  static bool get isAndroid =>
      defaultTargetPlatform == TargetPlatform.android;

  static Future<void> initialize() async {

    _channel.setMethodCallHandler(
      (call) async {

        if (
            call.method ==
            'onAlarmTriggered'
        ) {

          final raw =
              Map<Object?, Object?>.from(
            call.arguments as Map,
          );

          _events.add(
            AlarmLaunchData(
              alarmId:
                  raw['alarmId'] as int?,
              reminderId:
                  raw['reminderId']
                      as String?,
            ),
          );
        } else if (call.method == 'onAlarmDismissed') {
          _dismissEvents.add(null);
        }
      },
    );
  }

  static int alarmIdFor(
    String reminderId
  ) {
    return Fnv1aHash.hash32(
      reminderId,
    );
  }

  static Future<bool>
      canScheduleExactAlarms() async {

    if (!isAndroid) {
      return true;
    }

    try {

      final result =
          await _channel.invokeMethod<bool>(
        'canScheduleExactAlarms',
      );

      return result ?? false;

    } catch (e, stack) {

      AppLogger.error(
        _subsystem,
        'Exact alarm capability query failed',
        error: e,
        stackTrace: stack,
      );

      return false;
    }
  }

  static Future<void>
      openExactAlarmSettings() async {

    if (!isAndroid) {
      return;
    }

    await _channel.invokeMethod(
      'openExactAlarmSettings',
    );
  }

  static Future<bool>
      canUseFullScreenIntent() async {

    if (!isAndroid) {
      return true;
    }

    try {

      final result =
          await _channel.invokeMethod<bool>(
        'canUseFullScreenIntent',
      );

      return result ?? false;

    } catch (e, stack) {

      AppLogger.error(
        _subsystem,
        'Full-screen capability query failed',
        error: e,
        stackTrace: stack,
      );

      return false;
    }
  }

  static Future<void>
      openFullScreenIntentSettings() async {

    if (!isAndroid) {
      return;
    }

    await _channel.invokeMethod(
      'openFullScreenIntentSettings',
    );
  }

  static Future<void>
      scheduleAlarm(
    Reminder reminder,
  ) async {

    if (
        reminder.isDone ||
        reminder.isArchived
    ) {
      return;
    }

    if (
        reminder.scheduledAt
            .isBefore(
          DateTime.now(),
        )
    ) {

      throw const AlarmScheduleException(
        'Cannot schedule an alarm in the past.',
      );
    }

    final exactAllowed =
        await canScheduleExactAlarms();

    if (!exactAllowed) {

      throw const AlarmPermissionRequiredException();
    }

    final alarmId =
        alarmIdFor(
      reminder.id,
    );

    AppLogger.info(
      _subsystem,
      'ALARM_SCHEDULE_REQUEST id=$alarmId reminder=${reminder.id} trigger=${reminder.scheduledAt}',
    );

    try {

      // Remove any existing alarm first.
      await cancelAlarm(
        reminder.id,
      );

      final result =
          await _channel.invokeMethod<bool>(
        'scheduleAlarm',
        <String, dynamic>{
          'id': alarmId,
          'reminderId': reminder.id,
          'title': 'Nudge Reminder',
          'message': reminder.message,
          'vibration':
              reminder.vibrationEnabled,
          'triggerAtMillis':
              reminder.scheduledAt
                  .millisecondsSinceEpoch,
        },
      );

      if (result != true) {

        throw const AlarmScheduleException(
          'Native AlarmManager did not confirm scheduling.',
        );
      }

      AppLogger.info(
        _subsystem,
        'ALARM_SCHEDULE_SUCCESS id=$alarmId',
      );

    } on PlatformException catch (e, stack) {

      AppLogger.error(
        _subsystem,
        'ALARM_SCHEDULE_PLATFORM_FAILURE',
        error: e,
        stackTrace: stack,
      );

      if (
          e.code ==
          'EXACT_ALARM_PERMISSION_REQUIRED'
      ) {

        throw const AlarmPermissionRequiredException();
      }

      throw AlarmScheduleException(
        e.message ??
            'Unable to schedule alarm.',
      );
    }
  }

  static Future<void>
      cancelAlarm(
    String reminderId,
  ) async {

    if (!isAndroid) {
      return;
    }

    final alarmId =
        alarmIdFor(
      reminderId,
    );

    await _channel.invokeMethod(
      'cancelAlarm',
      <String, dynamic>{
        'id': alarmId,
      },
    );
  }

  static Future<void>
      dismissRingingAlarm([
    int? alarmId,
  ]) async {

    if (!isAndroid) {
      return;
    }

    await _channel.invokeMethod(
      'dismissAlarm',
      alarmId == null
          ? null
          : <String, dynamic>{
              'id': alarmId,
            },
    );
  }

  static Future<AlarmLaunchData>
      getLaunchAlarmData() async {

    try {

      final result =
          await _channel.invokeMethod<
              Map<dynamic, dynamic>>(
        'getAlarmData',
      );

      if (result == null) {
        return const AlarmLaunchData();
      }

      return AlarmLaunchData(
        alarmId:
            result['alarmId']
                as int?,
        reminderId:
            result['reminderId']
                as String?,
      );

    } catch (e, stack) {

      AppLogger.error(
        _subsystem,
        'Failed to read launch alarm',
        error: e,
        stackTrace: stack,
      );

      return const AlarmLaunchData();
    }
  }

  static Future<void> closeAlarmUi() async {
    if (!isAndroid) return;
    try {
      await _channel.invokeMethod('closeAlarmUi');
    } catch (e, stack) {
      AppLogger.error(
        _subsystem,
        'Failed to close alarm UI',
        error: e,
        stackTrace: stack,
      );
    }
  }

  static Future<Map<String, dynamic>?> getAudioDuration(String filePath) async {
    if (!isAndroid) return null;
    try {
      final result = await _channel.invokeMethod<Map<dynamic, dynamic>>(
        'getAudioDuration',
        {'filePath': filePath},
      );
      if (result == null) return null;
      return Map<String, dynamic>.from(result);
    } catch (e, stack) {
      AppLogger.error(
        _subsystem,
        'Failed to get audio duration',
        error: e,
        stackTrace: stack,
      );
      return null;
    }
  }

  static Future<void> playAudioPreview(String filePath, int startMs, int endMs) async {
    if (!isAndroid) return;
    try {
      await _channel.invokeMethod('playAudioPreview', {
        'filePath': filePath,
        'startMs': startMs,
        'endMs': endMs,
      });
    } catch (e, stack) {
      AppLogger.error(
        _subsystem,
        'Failed to play audio preview',
        error: e,
        stackTrace: stack,
      );
    }
  }

  static Future<void> stopAudioPreview() async {
    if (!isAndroid) return;
    try {
      await _channel.invokeMethod('stopAudioPreview');
    } catch (e, stack) {
      AppLogger.error(
        _subsystem,
        'Failed to stop audio preview',
        error: e,
        stackTrace: stack,
      );
    }
  }

  static Future<void> saveCustomAlarmSound(
    String filePath,
    int startMs,
    int endMs, {
    String? title,
  }) async {
    if (!isAndroid) return;
    try {
      await _channel.invokeMethod('saveCustomAlarmSound', {
        'filePath': filePath,
        'startMs': startMs,
        'endMs': endMs,
        'title': title,
      });
    } catch (e, stack) {
      AppLogger.error(
        _subsystem,
        'Failed to save custom alarm sound',
        error: e,
        stackTrace: stack,
      );
    }
  }

  static Future<Map<String, dynamic>?> getCustomAlarmSound() async {
    if (!isAndroid) return null;
    try {
      final result = await _channel.invokeMethod<Map<dynamic, dynamic>>('getCustomAlarmSound');
      if (result == null) return null;
      return Map<String, dynamic>.from(result);
    } catch (e, stack) {
      AppLogger.error(
        _subsystem,
        'Failed to get custom alarm sound',
        error: e,
        stackTrace: stack,
      );
      return null;
    }
  }

  static Future<void> clearCustomAlarmSound() async {
    if (!isAndroid) return;
    try {
      await _channel.invokeMethod('clearCustomAlarmSound');
    } catch (e, stack) {
      AppLogger.error(
        _subsystem,
        'Failed to clear custom alarm sound',
        error: e,
        stackTrace: stack,
      );
    }
  }
}
