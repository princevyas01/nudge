import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/constants/app_constants.dart';
import 'core/logging/app_logger.dart';
import 'data/database/app_database.dart';
import 'data/repositories/companion_repository_impl.dart';
import 'data/repositories/folder_repository_impl.dart';
import 'data/repositories/history_repository_impl.dart';
import 'data/repositories/occurrence_repository_impl.dart';
import 'data/repositories/reminder_repository_impl.dart';
import 'data/repositories/todo_repository_impl.dart';
import 'data/repositories/record_repository_impl.dart';

import 'application/controllers/companion_controller.dart';
import 'application/controllers/folder_controller.dart';
import 'application/controllers/reliability_controller.dart';
import 'application/controllers/reminder_controller.dart';
import 'application/controllers/settings_controller.dart';
import 'application/controllers/theme_controller.dart';
import 'application/controllers/timer_controller.dart';
import 'application/controllers/todo_controller.dart';
import 'application/controllers/record_controller.dart';

import 'presentation/theme/nudge_theme.dart';
import 'platform/alarms/alarm_platform_service.dart';
import 'platform/notifications/notification_platform_service.dart';
import 'platform/permissions/permission_manager.dart';

import 'features/home/home_screen.dart';
import 'features/alarms/ringing_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  AppLogger.info('Main', 'Launching Nudge 2.0...');

  // Initialize SQLite Database
  await AppDatabase.database;

  // Initialize Notification Channels
  await NotificationPlatformService.initialize();

  // Initialize Alarm Manager
  await AlarmPlatformService.initialize();

  // Repositories
  final reminderRepo = ReminderRepositoryImpl();
  final occurrenceRepo = OccurrenceRepositoryImpl();
  final folderRepo = FolderRepositoryImpl();
  final historyRepo = HistoryRepositoryImpl();
  final companionRepo = CompanionRepositoryImpl();
  final todoRepo = TodoRepositoryImpl();
  final recordRepo = RecordRepositoryImpl();

  // Controllers
  final themeController = ThemeController();
  final settingsController = SettingsController();
  final reliabilityController = ReliabilityController();
  final folderController = FolderController(folderRepo: folderRepo);
  final companionController = CompanionController(repository: companionRepo);
  final reminderController = ReminderController(
    reminderRepo: reminderRepo,
    occurrenceRepo: occurrenceRepo,
    historyRepo: historyRepo,
  );
  final timerController = TimerController();
  final todoController = TodoController(todoRepo: todoRepo);
  final recordController = RecordController(recordRepo: recordRepo);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: themeController),
        ChangeNotifierProvider.value(value: settingsController),
        ChangeNotifierProvider.value(value: reliabilityController),
        ChangeNotifierProvider.value(value: folderController),
        ChangeNotifierProvider.value(value: companionController),
        ChangeNotifierProvider.value(value: reminderController),
        ChangeNotifierProvider.value(value: timerController),
        ChangeNotifierProvider.value(value: todoController),
        ChangeNotifierProvider.value(value: recordController),
      ],
      child: const NudgeApp(),
    ),
  );
}

class NudgeApp extends StatelessWidget {
  const NudgeApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = context.watch<ThemeController>();

    return MaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: NudgeTheme.lightTheme,
      darkTheme: NudgeTheme.darkTheme,
      themeMode: themeController.themeMode,
      home: const NudgeAppRoot(),
    );
  }
}

class NudgeAppRoot extends StatefulWidget {
  const NudgeAppRoot({super.key});

  @override
  State<NudgeAppRoot> createState() => _NudgeAppRootState();
}

class _NudgeAppRootState extends State<NudgeAppRoot> with WidgetsBindingObserver {
  StreamSubscription<AlarmLaunchData>? _alarmSubscription;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    // Listen for alarms triggered while app is active or opened
    _alarmSubscription = AlarmPlatformService.onAlarmTriggered.listen((data) async {
      await _openRingingScreen(data);
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkLaunchAlarm();
      _initializeAlarmReliability();
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _checkLaunchAlarm();
      context.read<ReliabilityController>().refreshStatuses();
      context.read<ReminderController>().checkExactAlarmCapability();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _alarmSubscription?.cancel();
    super.dispose();
  }

  Future<void> _initializeAlarmReliability() async {
    final reliability = context.read<ReliabilityController>();
    await reliability.refreshStatuses();
    if (!mounted) return;

    if (!reliability.notificationsEnabled) {
      await PermissionManager.requestNotificationPermission();
    }
    await reliability.refreshStatuses();
    if (!mounted) return;

    if (!reliability.exactAlarmsEnabled) {
      await _showExactAlarmRequiredDialog();
    }
    await reliability.refreshStatuses();
    if (!mounted) return;

    if (!reliability.fullScreenIntentEnabled) {
      await _showFullScreenIntentDialog();
    }
    await reliability.refreshStatuses();
  }

  Future<void> _showExactAlarmRequiredDialog() async {
    final controller = context.read<ReliabilityController>();
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Allow setting alarms and reminders'),
          content: const Text(
            'Nudge needs exact alarm access so your reminders can ring at the scheduled time even when the app is closed or your phone is locked.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: const Text('Not now'),
            ),
            FilledButton(
              onPressed: () async {
                Navigator.of(dialogContext).pop();
                await controller.requestExactAlarmAccess();
              },
              child: const Text('Allow'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showFullScreenIntentDialog() async {
    final controller = context.read<ReliabilityController>();
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Allow full-screen alarms'),
          content: const Text(
            'Nudge can show a full-screen alarm screen directly when your phone is locked so you never miss an urgent reminder.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: const Text('Not now'),
            ),
            FilledButton(
              onPressed: () async {
                Navigator.of(dialogContext).pop();
                await controller.requestFullScreenIntent();
              },
              child: const Text('Allow'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _openRingingScreen(AlarmLaunchData data) async {
    if (!mounted) return;

    final reminderController = context.read<ReminderController>();
    await reminderController.loadReminders();

    String? reminderId = data.reminderId;

    if (reminderId == null && data.alarmId != null) {
      for (final reminder in reminderController.reminders) {
        if (AlarmPlatformService.alarmIdFor(reminder.id) == data.alarmId) {
          reminderId = reminder.id;
          break;
        }
      }
    }

    if (reminderId == null) return;
    if (!mounted) return;

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => RingingScreen(
          reminderId: reminderId!,
        ),
      ),
    );
  }

  Future<void> _checkLaunchAlarm() async {
    final launchData = await AlarmPlatformService.getLaunchAlarmData();
    if (launchData.alarmId != null || launchData.reminderId != null) {
      await _openRingingScreen(launchData);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const HomeScreen();
  }
}
