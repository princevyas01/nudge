import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nudge/core/constants/app_constants.dart';
import 'package:nudge/domain/entities/reminder.dart';
import 'package:nudge/domain/enums/enums.dart';
import 'package:nudge/platform/alarms/alarm_platform_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const channel = MethodChannel(AppConstants.alarmChannel);
  final List<MethodCall> log = [];

  setUp(() {
    debugDefaultTargetPlatformOverride = TargetPlatform.android;
    log.clear();
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
      log.add(methodCall);

      switch (methodCall.method) {
        case 'canScheduleExactAlarms':
          return true;
        case 'canUseFullScreenIntent':
          return true;
        case 'scheduleAlarm':
          return true;
        case 'cancelAlarm':
          return true;
        case 'dismissAlarm':
          return true;
        case 'openExactAlarmSettings':
          return true;
        case 'openFullScreenIntentSettings':
          return true;
        case 'getAlarmData':
          return {
            'alarmId': 12345,
            'reminderId': 'rem_test_1',
          };
        case 'closeAlarmUi':
          return true;
        case 'getAudioDuration':
          return {
            'durationMs': 45000,
            'title': 'Test Song',
            'artist': 'Test Artist',
          };
        case 'playAudioPreview':
          return true;
        case 'stopAudioPreview':
          return true;
        case 'saveCustomAlarmSound':
          return true;
        case 'getCustomAlarmSound':
          return {
            'filePath': '/path/to/test.mp3',
            'startMs': 10000,
            'endMs': 40000,
            'title': 'Test Song',
          };
        case 'clearCustomAlarmSound':
          return true;
        default:
          return null;
      }
    });
  });

  tearDown(() {
    debugDefaultTargetPlatformOverride = null;
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  group('AlarmPlatformService Unit Tests', () {
    test('alarmIdFor generates consistent FNV-1a 32-bit positive integer', () {
      final id1 = AlarmPlatformService.alarmIdFor('reminder-123');
      final id2 = AlarmPlatformService.alarmIdFor('reminder-123');
      final id3 = AlarmPlatformService.alarmIdFor('reminder-456');

      expect(id1, equals(id2));
      expect(id1, isNot(equals(id3)));
      expect(id1, isPositive);
    });

    test('AlarmLaunchData holds alarmId and reminderId', () {
      const data = AlarmLaunchData(alarmId: 999, reminderId: 'rem_abc');
      expect(data.alarmId, equals(999));
      expect(data.reminderId, equals('rem_abc'));
    });

    test('AlarmPermissionRequiredException has meaningful message', () {
      const ex = AlarmPermissionRequiredException();
      expect(ex.toString(), contains('Exact alarm permission is required'));
    });

    test('AlarmScheduleException has custom message', () {
      const ex = AlarmScheduleException('Device memory failure');
      expect(ex.toString(), equals('Device memory failure'));
    });

    test('canScheduleExactAlarms returns true on mocked platform channel', () async {
      final canSchedule = await AlarmPlatformService.canScheduleExactAlarms();
      expect(canSchedule, isTrue);
      expect(log.any((call) => call.method == 'canScheduleExactAlarms'), isTrue);
    });

    test('canUseFullScreenIntent returns true on mocked platform channel', () async {
      final canFsi = await AlarmPlatformService.canUseFullScreenIntent();
      expect(canFsi, isTrue);
      expect(log.any((call) => call.method == 'canUseFullScreenIntent'), isTrue);
    });

    test('scheduleAlarm throws AlarmScheduleException when reminder is in the past', () async {
      final pastReminder = Reminder(
        id: 'past_rem',
        message: 'Old reminder',
        scheduledAt: DateTime.now().subtract(const Duration(hours: 1)),
      );

      expect(
        () => AlarmPlatformService.scheduleAlarm(pastReminder),
        throwsA(isA<AlarmScheduleException>()),
      );
    });

    test('scheduleAlarm ignores inactive reminders and does not invoke channel', () async {
      final doneReminder = Reminder(
        id: 'done_rem',
        message: 'Completed reminder',
        scheduledAt: DateTime.now().add(const Duration(hours: 1)),
        isDone: true,
      );

      await AlarmPlatformService.scheduleAlarm(doneReminder);
      expect(log.any((c) => c.method == 'scheduleAlarm'), isFalse);
    });

    test('scheduleAlarm cancels previous alarm and invokes scheduleAlarm on channel', () async {
      final futureReminder = Reminder(
        id: 'future_rem',
        message: 'Active future reminder',
        scheduledAt: DateTime.now().add(const Duration(hours: 2)),
        alertStyle: AlertStyle.alarm,
        soundId: 'gentle_bell',
        vibrationEnabled: true,
      );

      await AlarmPlatformService.scheduleAlarm(futureReminder);

      final cancelCalls = log.where((c) => c.method == 'cancelAlarm').toList();
      final scheduleCalls = log.where((c) => c.method == 'scheduleAlarm').toList();

      expect(cancelCalls.isNotEmpty, isTrue);
      expect(scheduleCalls.isNotEmpty, isTrue);

      final scheduleArgs = scheduleCalls.first.arguments as Map;
      expect(scheduleArgs['reminderId'], equals('future_rem'));
      expect(scheduleArgs['vibration'], isTrue);
    });

    test('scheduleAlarm throws AlarmPermissionRequiredException when permission denied', () async {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
        if (methodCall.method == 'canScheduleExactAlarms') {
          return false;
        }
        return null;
      });

      final futureReminder = Reminder(
        id: 'blocked_rem',
        message: 'Should fail due to permission',
        scheduledAt: DateTime.now().add(const Duration(hours: 1)),
      );

      expect(
        () => AlarmPlatformService.scheduleAlarm(futureReminder),
        throwsA(isA<AlarmPermissionRequiredException>()),
      );
    });

    test('scheduleAlarm throws AlarmPermissionRequiredException when platform throws EXACT_ALARM_PERMISSION_REQUIRED', () async {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
        if (methodCall.method == 'canScheduleExactAlarms') {
          return true;
        }
        if (methodCall.method == 'cancelAlarm') {
          return true;
        }
        if (methodCall.method == 'scheduleAlarm') {
          throw PlatformException(
            code: 'EXACT_ALARM_PERMISSION_REQUIRED',
            message: 'Permission denied',
          );
        }
        return null;
      });

      final futureReminder = Reminder(
        id: 'platform_blocked_rem',
        message: 'Should fail due to native permission check',
        scheduledAt: DateTime.now().add(const Duration(hours: 1)),
      );

      expect(
        () => AlarmPlatformService.scheduleAlarm(futureReminder),
        throwsA(isA<AlarmPermissionRequiredException>()),
      );
    });

    test('getLaunchAlarmData retrieves pending launch data from platform', () async {
      final launchData = await AlarmPlatformService.getLaunchAlarmData();
      expect(launchData.alarmId, equals(12345));
      expect(launchData.reminderId, equals('rem_test_1'));
    });

    test('dismissRingingAlarm calls dismissAlarm on channel', () async {
      await AlarmPlatformService.dismissRingingAlarm(123);
      expect(log.any((c) => c.method == 'dismissAlarm'), isTrue);
    });

    test('openExactAlarmSettings and openFullScreenIntentSettings invoke correct methods', () async {
      await AlarmPlatformService.openExactAlarmSettings();
      expect(log.any((c) => c.method == 'openExactAlarmSettings'), isTrue);

      await AlarmPlatformService.openFullScreenIntentSettings();
      expect(log.any((c) => c.method == 'openFullScreenIntentSettings'), isTrue);
    });

    test('closeAlarmUi invokes platform channel method', () async {
      await AlarmPlatformService.closeAlarmUi();
      expect(log.any((c) => c.method == 'closeAlarmUi'), isTrue);
    });

    test('getAudioDuration returns duration and title metadata', () async {
      final info = await AlarmPlatformService.getAudioDuration('/test.mp3');
      expect(info, isNotNull);
      expect(info!['durationMs'], equals(45000));
      expect(info['title'], equals('Test Song'));
      expect(log.any((c) => c.method == 'getAudioDuration'), isTrue);
    });

    test('playAudioPreview and stopAudioPreview send correct channel invocations', () async {
      await AlarmPlatformService.playAudioPreview('/test.mp3', 5000, 20000);
      expect(log.any((c) => c.method == 'playAudioPreview'), isTrue);

      await AlarmPlatformService.stopAudioPreview();
      expect(log.any((c) => c.method == 'stopAudioPreview'), isTrue);
    });

    test('custom alarm sound save, get, and clear operate correctly', () async {
      await AlarmPlatformService.saveCustomAlarmSound('/test.mp3', 5000, 25000, title: 'Ring');
      expect(log.any((c) => c.method == 'saveCustomAlarmSound'), isTrue);

      final sound = await AlarmPlatformService.getCustomAlarmSound();
      expect(sound, isNotNull);
      expect(sound!['filePath'], equals('/path/to/test.mp3'));
      expect(sound['startMs'], equals(10000));
      expect(sound['endMs'], equals(40000));

      await AlarmPlatformService.clearCustomAlarmSound();
      expect(log.any((c) => c.method == 'clearCustomAlarmSound'), isTrue);
    });
  });
}
