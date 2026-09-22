import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nudge/application/controllers/timer_controller.dart';
import 'package:nudge/core/services/time_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    TimeService.resetClock();
  });

  tearDown(() {
    TimeService.resetClock();
  });

  group('TimerStateMachine / TimerController Unit Tests', () {
    test('Initial state is idle with zero duration', () {
      final controller = TimerController();
      expect(controller.state, equals(TimerState.idle));
      expect(controller.isIdle, isTrue);
      expect(controller.isRunning, isFalse);
      expect(controller.isPaused, isFalse);
      expect(controller.progress, equals(0.0));
      expect(controller.remainingTime, equals(Duration.zero));
      controller.dispose();
    });

    test('Starting a valid timer transitions to running with accurate total duration', () {
      final controller = TimerController();
      controller.startTimer(const Duration(minutes: 10));

      expect(controller.state, equals(TimerState.running));
      expect(controller.isRunning, isTrue);
      expect(controller.totalDuration.inMinutes, equals(10));
      expect(controller.remainingTime.inMinutes, equals(10));
      expect(controller.progress, closeTo(1.0, 0.01));
      controller.dispose();
    });

    test('Ignoring startTimer with zero or negative duration', () {
      final controller = TimerController();
      controller.startTimer(Duration.zero);
      expect(controller.state, equals(TimerState.idle));

      controller.startTimer(const Duration(seconds: -10));
      expect(controller.state, equals(TimerState.idle));
      controller.dispose();
    });

    test('Pause and resume transitions', () {
      var simulatedNow = DateTime(2026, 9, 10, 12, 0, 0);
      TimeService.setCustomClock(() => simulatedNow);

      final controller = TimerController();
      controller.startTimer(const Duration(minutes: 5)); // target: 12:05:00
      expect(controller.state, equals(TimerState.running));

      // Advance clock by 2 minutes
      simulatedNow = simulatedNow.add(const Duration(minutes: 2));

      controller.pauseTimer();
      expect(controller.state, equals(TimerState.paused));
      expect(controller.isPaused, isTrue);
      expect(controller.remainingTime.inMinutes, equals(3));

      // Resuming restarts running towards new target
      controller.resumeTimer();
      expect(controller.state, equals(TimerState.running));

      controller.dispose();
    });

    test('Cancel transitions and resets to idle', () {
      final controller = TimerController();
      controller.startTimer(const Duration(minutes: 15));
      expect(controller.isRunning, isTrue);

      controller.cancelTimer();
      expect(controller.state, equals(TimerState.idle));
      expect(controller.remainingTime, equals(Duration.zero));

      controller.dispose();
    });

    test('Reset timer clears all values', () {
      final controller = TimerController();
      controller.startTimer(const Duration(minutes: 25));
      controller.resetTimer();

      expect(controller.state, equals(TimerState.idle));
      expect(controller.totalDuration, equals(Duration.zero));
      expect(controller.remainingTime, equals(Duration.zero));
      expect(controller.progress, equals(0.0));

      controller.dispose();
    });
  });
}
