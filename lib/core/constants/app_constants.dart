class AppConstants {
  static const String appName = 'Nudge';
  static const String appVersion = '2.0.0';
  static const String appBuild = '1';
  static const String appTagline = 'Privacy-first offline reminder & habit system';

  // Limits & Defaults
  static const int maxSnoozeCount = 3;
  static const int defaultSnoozeMinutes = 10;
  static const int conflictWindowMinutes = 15;

  // Method Channels
  static const String alarmChannel = 'com.personal.nudge/alarm';
  static const String reliabilityChannel = 'com.personal.nudge/reliability';

  // Notification Channels
  static const String alarmChannelId = 'nudge_alarm_channel_final';
  static const String alarmChannelName = 'Nudge Alarms (Foreground)';
  static const String gentleChannelId = 'nudge_gentle_channel';
  static const String gentleChannelName = 'Nudge Gentle Reminders';

  // Intent Actions
  static const String actionStartAlarm = 'com.personal.nudge.ACTION_START_ALARM';
  static const String actionStopAlarm = 'com.personal.nudge.ACTION_STOP_ALARM';
  static const String alarmReceiverComponent = 'com.personal.nudge.nudge.AlarmReceiver';

  // Shared Preferences Keys
  static const String prefThemeMode = 'nudge_theme_mode';
  static const String prefDefaultSnooze = 'nudge_default_snooze';
  static const String prefSoundEnabled = 'nudge_sound_enabled';
  static const String prefCompanionName = 'nudge_companion_name';
  static const String prefCompanionCosmetic = 'nudge_companion_cosmetic';
  static const String prefCompanionStreak = 'nudge_companion_streak';
  static const String prefCompanionLifetime = 'nudge_companion_lifetime';
  static const String prefCompanionFreezes = 'nudge_companion_freezes';
  static const String prefCompanionLastActiveDate = 'nudge_companion_last_active_date';
  static const String prefTimerEndTime = 'nudge_timer_end_time';
  static const String prefTimerTotalDuration = 'nudge_timer_total_duration';
  static const String prefTimerIsRunning = 'nudge_timer_is_running';
  static const String prefInitialSetupComplete = 'nudge_setup_complete';

  // Default Folders
  static const String generalFolderId = 'folder_general';
  static const String workFolderId = 'folder_work';
  static const String personalFolderId = 'folder_personal';

  // Default Categories / Folders Seed
  static const List<Map<String, dynamic>> defaultFolders = [
    {
      'id': generalFolderId,
      'name': 'General',
      'iconId': 'folder',
      'colorTag': '#006A60',
    },
    {
      'id': workFolderId,
      'name': 'Work',
      'iconId': 'work',
      'colorTag': '#BA1A1A',
    },
    {
      'id': personalFolderId,
      'name': 'Personal',
      'iconId': 'home',
      'colorTag': '#6750A4',
    },
  ];

  // Mascot Milestones
  static const Map<int, String> cosmeticMilestones = {
    3: 'bandana',
    8: 'neon_shades',
    15: 'headphones',
    25: 'wizard_hat',
    40: 'ninja_band',
    60: 'astronaut_helmet',
    80: 'sparkle_aura',
    100: 'crown',
    150: 'flame_aura',
    200: 'golden_trophy',
  };
}
