import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../domain/entities/companion_profile.dart';
import '../../domain/enums/enums.dart';
import '../../domain/repositories/i_companion_repository.dart';

class CompanionController extends ChangeNotifier with WidgetsBindingObserver {
  final ICompanionRepository _repository;

  CompanionProfile _profile = const CompanionProfile();
  CompanionProfile get profile => _profile;

  CompanionMood _currentMood = CompanionMood.neutral;
  CompanionMood get currentMood => _currentMood;

  String _currentDialogue = "Ready to conquer your tasks?";
  String get currentDialogue => _currentDialogue;

  Timer? _idleTimer;
  bool _isAppInForeground = true;

  CompanionController({required ICompanionRepository repository}) : _repository = repository {
    WidgetsBinding.instance.addObserver(this);
    _loadProfile();
    _startIdleTimer();
  }

  Future<void> _loadProfile() async {
    _profile = await _repository.getProfile();
    _updateMoodFromState();
    _updateDialogue();
    notifyListeners();
  }

  void _updateMoodFromState() {
    if (_profile.currentStreak >= 5) {
      _currentMood = CompanionMood.happy;
    } else {
      _currentMood = CompanionMood.neutral;
    }
  }

  void _updateDialogue() {
    final hour = DateTime.now().hour;
    final name = _profile.name;

    if (_currentMood == CompanionMood.celebratory) {
      _currentDialogue = "Awesome job! You're making serious progress!";
      return;
    }

    if (hour < 12) {
      _currentDialogue = "Good morning! Let's get today's goals done, $name!";
    } else if (hour < 17) {
      _currentDialogue = "Keep the momentum going strong, $name!";
    } else if (hour < 21) {
      _currentDialogue = "Evening check-in! Any last tasks to knock out?";
    } else {
      _currentDialogue = "Wrapping up the day? Great effort!";
    }
  }

  void triggerCelebration() {
    _currentMood = CompanionMood.celebratory;
    final newLifetime = _profile.lifetimeCompletions + 1;
    final newStreak = _profile.currentStreak + 1;

    // Check unlocks
    final unlocked = List<String>.from(_profile.unlockedCosmetics);
    AppConstants.cosmeticMilestones.forEach((milestone, cosmeticId) {
      if (newLifetime >= milestone && !unlocked.contains(cosmeticId)) {
        unlocked.add(cosmeticId);
      }
    });

    _profile = _profile.copyWith(
      lifetimeCompletions: newLifetime,
      currentStreak: newStreak,
      unlockedCosmetics: unlocked,
      lastActiveDate: DateTime.now(),
    );

    _updateDialogue();
    notifyListeners();
    _repository.saveProfile(_profile);

    Future.delayed(const Duration(seconds: 4), () {
      if (_isAppInForeground) {
        _currentMood = CompanionMood.happy;
        _updateDialogue();
        notifyListeners();
      }
    });
  }

  void triggerTapReaction() {
    final quips = [
      "I'm keeping watch over your schedule!",
      "You've got this! One task at a time.",
      "Stay focused, great things take consistency!",
      "A quick nudge: check off your top priority today!",
    ];
    _currentDialogue = quips[Random().nextInt(quips.length)];
    _currentMood = CompanionMood.happy;
    notifyListeners();

    Future.delayed(const Duration(seconds: 3), () {
      _updateMoodFromState();
      _updateDialogue();
      notifyListeners();
    });
  }

  Future<void> updateName(String newName) async {
    final trimmed = newName.trim();
    if (trimmed.isEmpty) return;
    _profile = _profile.copyWith(name: trimmed);
    notifyListeners();
    await _repository.saveProfile(_profile);
  }

  Future<void> equipCosmetic(String? cosmeticId) async {
    if (cosmeticId == null) {
      _profile = _profile.copyWith(clearEquipped: true);
    } else {
      _profile = _profile.copyWith(equippedCosmetic: cosmeticId);
    }
    notifyListeners();
    await _repository.saveProfile(_profile);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _isAppInForeground = state == AppLifecycleState.resumed;
    if (_isAppInForeground) {
      _startIdleTimer();
      _updateDialogue();
    } else {
      _idleTimer?.cancel();
    }
  }

  void _startIdleTimer() {
    _idleTimer?.cancel();
    _idleTimer = Timer.periodic(const Duration(seconds: 15), (_) {
      if (_isAppInForeground && _currentMood != CompanionMood.celebratory) {
        notifyListeners();
      }
    });
  }

  @override
  void dispose() {
    _idleTimer?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
