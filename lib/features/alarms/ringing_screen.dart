import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../application/controllers/reminder_controller.dart';
import '../../application/controllers/folder_controller.dart';
import '../../core/constants/app_constants.dart';
import '../../domain/entities/reminder.dart';
import '../../platform/alarms/alarm_platform_service.dart';
import '../../presentation/components/nudge_button.dart';

class RingingScreen extends StatefulWidget {
  final String reminderId;

  const RingingScreen({super.key, required this.reminderId});

  @override
  State<RingingScreen> createState() => _RingingScreenState();
}

class _RingingScreenState extends State<RingingScreen> with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;
  StreamSubscription<void>? _dismissSubscription;
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.95, end: 1.08).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _dismissSubscription = AlarmPlatformService.onAlarmDismissed.listen((_) {
      if (mounted && !_isProcessing) {
        Navigator.of(context).pop();
        AlarmPlatformService.closeAlarmUi();
      }
    });
  }

  @override
  void dispose() {
    _dismissSubscription?.cancel();
    _pulseController.dispose();
    super.dispose();
  }

  Future<void> _handleSnooze(Reminder reminder, ReminderController reminderCtrl) async {
    if (_isProcessing) return;
    setState(() => _isProcessing = true);

    await AlarmPlatformService.dismissRingingAlarm();
    await reminderCtrl.snoozeReminder(reminder.id);

    if (mounted) {
      Navigator.of(context).pop();
    }
    await AlarmPlatformService.closeAlarmUi();
  }

  Future<void> _handleComplete(Reminder reminder, ReminderController reminderCtrl) async {
    if (_isProcessing) return;
    setState(() => _isProcessing = true);

    await AlarmPlatformService.dismissRingingAlarm();
    await reminderCtrl.completeReminder(reminder.id);

    if (mounted) {
      Navigator.of(context).pop();
    }
    await AlarmPlatformService.closeAlarmUi();
  }

  Future<void> _handleDismissOnly() async {
    if (_isProcessing) return;
    setState(() => _isProcessing = true);

    await AlarmPlatformService.dismissRingingAlarm();

    if (mounted) {
      Navigator.of(context).pop();
    }
    await AlarmPlatformService.closeAlarmUi();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final reminderCtrl = context.watch<ReminderController>();
    final folderCtrl = context.watch<FolderController>();

    final reminder = reminderCtrl.reminders.firstWhere(
      (r) => r.id == widget.reminderId,
      orElse: () => Reminder(
        id: widget.reminderId,
        message: 'Reminder Alarm',
        scheduledAt: DateTime.now(),
      ),
    );

    final folder = reminder.folderId != null
        ? folderCtrl.folders.firstWhere((f) => f.id == reminder.folderId, orElse: () => folderCtrl.folders.first)
        : null;

    final canSnooze = reminder.snoozeCount < AppConstants.maxSnoozeCount;
    final formattedTime = DateFormat('hh:mm a').format(DateTime.now());

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          _handleDismissOnly();
        }
      },
      child: Scaffold(
        backgroundColor: theme.colorScheme.surface,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Top Header
                Column(
                  children: [
                    Text(
                      formattedTime,
                      style: theme.textTheme.displaySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        letterSpacing: -1,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Alarm Ringing',
                      style: theme.textTheme.titleSmall?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),

                // Pulsing Icon & Reminder Information
                Column(
                  children: [
                    ScaleTransition(
                      scale: _pulseAnimation,
                      child: Container(
                        width: 110,
                        height: 110,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: theme.colorScheme.primaryContainer,
                          boxShadow: [
                            BoxShadow(
                              color: theme.colorScheme.primary.withOpacity(0.3),
                              blurRadius: 28,
                              spreadRadius: 6,
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.alarm,
                          size: 56,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    Text(
                      reminder.message,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (folder != null) ...[
                          Chip(
                            avatar: const Icon(Icons.folder, size: 16),
                            label: Text(folder.name),
                            visualDensity: VisualDensity.compact,
                          ),
                          const SizedBox(width: 8),
                        ],
                        Chip(
                          avatar: Icon(
                            Icons.flag,
                            size: 16,
                            color: reminder.priority.name == 'urgent'
                                ? theme.colorScheme.error
                                : reminder.priority.name == 'high'
                                    ? Colors.orange
                                    : theme.colorScheme.outline,
                          ),
                          label: Text(reminder.priority.name.toUpperCase()),
                          visualDensity: VisualDensity.compact,
                        ),
                      ],
                    ),
                    if (reminder.snoozeCount > 0) ...[
                      const SizedBox(height: 8),
                      Text(
                        'Snoozed ${reminder.snoozeCount}/${AppConstants.maxSnoozeCount} times',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: reminder.snoozeCount >= AppConstants.maxSnoozeCount
                              ? theme.colorScheme.error
                              : theme.colorScheme.outline,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ],
                ),

                // Action Buttons
                Column(
                  children: [
                    NudgeButton(
                      label: 'Mark as Completed',
                      icon: Icons.check_circle_outline,
                      isExpanded: true,
                      onPressed: _isProcessing ? null : () => _handleComplete(reminder, reminderCtrl),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                              minimumSize: const Size.fromHeight(52),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                            ),
                            icon: const Icon(Icons.snooze),
                            label: Text(canSnooze ? 'Snooze (10m)' : 'Snooze Maxed'),
                            onPressed: (canSnooze && !_isProcessing)
                                ? () => _handleSnooze(reminder, reminderCtrl)
                                : null,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                              minimumSize: const Size.fromHeight(52),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                            ),
                            icon: const Icon(Icons.close),
                            label: const Text('Dismiss'),
                            onPressed: _isProcessing ? null : _handleDismissOnly,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
