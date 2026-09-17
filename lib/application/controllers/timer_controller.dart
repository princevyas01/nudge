import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/constants/app_constants.dart';
import '../../core/services/time_service.dart';
import '../../platform/notifications/notification_platform_service.dart';

enum TimerState {
  idle,
  running,
  paused,
  completed,
  cancelled,
}

class TimerController extends ChangeNotifier {
  Timer? _ticker;
  TimerState _state = TimerState.idle;
  Duration _remainingTime = Duration.zero;
  Duration _totalDuration = Duration.zero;
  DateTime? _targetEndTime;
  bool _disposed = false;

  TimerState get state => _state;
  bool get isRunning => _state == TimerState.running;
  bool get isPaused => _state == TimerState.paused;
  bool get isFinished => _state == TimerState.completed;
  bool get isIdle => _state == TimerState.idle;

  Duration get remainingTime => _remainingTime;
  Duration get totalDuration => _totalDuration;

  double get progress {
    if (_totalDuration.inSeconds == 0) return 0.0;
    return (_remainingTime.inSeconds / _totalDuration.inSeconds).clamp(0.0, 1.0);
  }

  TimerController() {
    _restoreTimerState();
  }

  Future<void> _restoreTimerState() async {
    final prefs = await SharedPreferences.getInstance();
    final savedStateStr = prefs.getString('nudge_timer_state') ?? 'idle';
    final endMillis = prefs.getInt(AppConstants.prefTimerEndTime);
    final totalSec = prefs.getInt(AppConstants.prefTimerTotalDuration) ?? 0;
    final remainingSec = prefs.getInt('nudge_timer_remaining_sec') ?? 0;

    _totalDuration = Duration(seconds: totalSec);

    if (savedStateStr == 'running' && endMillis != null && totalSec > 0) {
      final endTime = DateTime.fromMillisecondsSinceEpoch(endMillis);
      final now = TimeService.now();

      if (now.isBefore(endTime)) {
        // Still running
        _targetEndTime = endTime;
        _remainingTime = endTime.difference(now);
        _state = TimerState.running;
        _startTicker();
      } else {
        // Expired while app was backgrounded / dead
        _remainingTime = Duration.zero;
        _state = TimerState.completed;
        _clearPersistedState();
      }
    } else if (savedStateStr == 'paused' && remainingSec > 0) {
      _remainingTime = Duration(seconds: remainingSec);
      _state = TimerState.paused;
    } else {
      _state = TimerState.idle;
      _remainingTime = Duration.zero;
    }

    if (_disposed) return;
    notifyListeners();
  }

  void startTimer(Duration duration) {
    if (duration.inSeconds <= 0) return;
    if (_state == TimerState.running) return; // Prevent duplicate start

    _ticker?.cancel();
    _totalDuration = duration;
    _remainingTime = duration;
    _targetEndTime = TimeService.now().add(duration);
    _state = TimerState.running;

    _persistTimerState();
    _startTicker();
    notifyListeners();
  }

  void pauseTimer() {
    if (_state != TimerState.running || _targetEndTime == null) return;

    _ticker?.cancel();
    final now = TimeService.now();
    final diff = _targetEndTime!.difference(now);
    _remainingTime = diff.isNegative ? Duration.zero : diff;
    _state = TimerState.paused;
    _targetEndTime = null;

    _persistTimerState();
    notifyListeners();
  }

  void resumeTimer() {
    if (_state != TimerState.paused || _remainingTime.inSeconds <= 0) return;

    _ticker?.cancel();
    _targetEndTime = TimeService.now().add(_remainingTime);
    _state = TimerState.running;

    _persistTimerState();
    _startTicker();
    notifyListeners();
  }

  void cancelTimer() {
    _ticker?.cancel();
    _remainingTime = Duration.zero;
    _targetEndTime = null;
    _state = TimerState.cancelled;

    _clearPersistedState();
    notifyListeners();

    // Reset to idle
    _state = TimerState.idle;
  }

  void resetTimer() {
    _ticker?.cancel();
    _remainingTime = Duration.zero;
    _totalDuration = Duration.zero;
    _targetEndTime = null;
    _state = TimerState.idle;

    _clearPersistedState();
    notifyListeners();
  }

  void _startTicker() {
    _ticker?.cancel();
    _ticker = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_targetEndTime == null) {
        timer.cancel();
        return;
      }

      final diff = _targetEndTime!.difference(TimeService.now());
      if (diff.inSeconds <= 0) {
        _remainingTime = Duration.zero;
        _state = TimerState.completed;
        timer.cancel();
        _clearPersistedState();
        _onTimerExpired();
      } else {
        _remainingTime = diff;
      }
      notifyListeners();
    });
  }

  void _onTimerExpired() {
    // Fire gentle notification / tone for timer
    NotificationPlatformService.cancelAll();
  }

  Future<void> _persistTimerState() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('nudge_timer_state', _state.name);
    await prefs.setInt(AppConstants.prefTimerTotalDuration, _totalDuration.inSeconds);
    await prefs.setInt('nudge_timer_remaining_sec', _remainingTime.inSeconds);

    if (_targetEndTime != null) {
      await prefs.setInt(AppConstants.prefTimerEndTime, _targetEndTime!.millisecondsSinceEpoch);
      await prefs.setBool(AppConstants.prefTimerIsRunning, true);
    } else {
      await prefs.remove(AppConstants.prefTimerEndTime);
      await prefs.setBool(AppConstants.prefTimerIsRunning, false);
    }
  }

  Future<void> _clearPersistedState() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('nudge_timer_state', 'idle');
    await prefs.setBool(AppConstants.prefTimerIsRunning, false);
    await prefs.remove(AppConstants.prefTimerEndTime);
    await prefs.remove(AppConstants.prefTimerTotalDuration);
    await prefs.remove('nudge_timer_remaining_sec');
  }

  @override
  void dispose() {
    _disposed = true;
    _ticker?.cancel();
    super.dispose();
  }
}
