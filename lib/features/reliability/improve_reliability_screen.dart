import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../application/controllers/reliability_controller.dart';
import '../../presentation/components/nudge_card.dart';
import '../../presentation/components/nudge_button.dart';
import '../../platform/alarms/alarm_platform_service.dart';
import '../../domain/entities/reminder.dart';
import '../../domain/enums/enums.dart';

class ImproveReliabilityScreen extends StatefulWidget {
  const ImproveReliabilityScreen({super.key});

  @override
  State<ImproveReliabilityScreen> createState() => _ImproveReliabilityScreenState();
}

class _ImproveReliabilityScreenState extends State<ImproveReliabilityScreen> with WidgetsBindingObserver {
  bool _testingAlarm = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ReliabilityController>().refreshStatuses();
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      context.read<ReliabilityController>().refreshStatuses();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Future<void> _triggerTestAlarm() async {
    final reminder = Reminder(
      message: 'Nudge Alarm Test',
      scheduledAt: DateTime.now().add(
        const Duration(
          seconds: 10,
        ),
      ),
      alertStyle: AlertStyle.alarm,
      folderId: 'general',
      priority: PriorityLevel.high,
    );

    final allowed = await AlarmPlatformService.canScheduleExactAlarms();

    if (!allowed) {
      await AlarmPlatformService.openExactAlarmSettings();
      return;
    }

    setState(() => _testingAlarm = true);

    try {
      await AlarmPlatformService.scheduleAlarm(
        reminder,
      );

      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Alarm scheduled for 10 seconds.',
          ),
        ),
      );
    } catch (e) {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Alarm scheduling failed: $e',
          ),
        ),
      );
    } finally {
      if (mounted) setState(() => _testingAlarm = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final reliability = context.watch<ReliabilityController>();

    final allPassed = reliability.notificationsEnabled &&
        reliability.exactAlarmsEnabled &&
        reliability.fullScreenIntentEnabled &&
        reliability.batteryOptimizationIgnored;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Alarm & Background Reliability'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => reliability.refreshStatuses(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Reliability Status Banner
            NudgeCard(
              color: allPassed
                  ? theme.colorScheme.primaryContainer.withOpacity(0.4)
                  : theme.colorScheme.errorContainer.withOpacity(0.3),
              child: Row(
                children: [
                  Icon(
                    allPassed ? Icons.verified_user : Icons.warning_amber_rounded,
                    size: 36,
                    color: allPassed ? theme.colorScheme.primary : theme.colorScheme.error,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          allPassed ? 'Fully Optimized' : 'Attention Needed',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: allPassed ? theme.colorScheme.primary : theme.colorScheme.error,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          allPassed
                              ? 'Nudge has all required permissions to ring exact alarms and wake your device.'
                              : 'Some permissions or OEM battery savers may prevent alarms from ringing on time.',
                          style: theme.textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // System Permissions Checklist
            Text(
              'System Settings & Permissions',
              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // Exact Alarms
            _buildChecklistTile(
              title: 'Schedule Exact Alarms',
              description: 'Required on Android 12+ to ring alarms at the exact minute without delay.',
              isGranted: reliability.exactAlarmsEnabled,
              onTap: () => reliability.requestExactAlarms(),
              buttonText: 'Grant Alarm Access',
            ),
            const SizedBox(height: 12),

            // Full-Screen Alarms
            _buildChecklistTile(
              title: 'Allow Full-Screen Alarms',
              description: 'Required on Android 14+ to display full-screen ringing screen when the phone is locked.',
              isGranted: reliability.fullScreenIntentEnabled,
              onTap: () => reliability.requestFullScreenIntent(),
              buttonText: 'Grant Full-Screen Access',
            ),
            const SizedBox(height: 12),

            // Notifications
            _buildChecklistTile(
              title: 'Post Notifications',
              description: 'Required to show gentle nudges, heads-up banners, and full-screen alarm controls.',
              isGranted: reliability.notificationsEnabled,
              onTap: () => reliability.requestNotifications(),
              buttonText: 'Enable Notifications',
            ),
            const SizedBox(height: 12),

            // Battery Optimization
            _buildChecklistTile(
              title: 'Ignore Battery Optimizations',
              description: 'Exempts Nudge from Android Doze mode so alarms ring even after hours of device inactivity.',
              isGranted: reliability.batteryOptimizationIgnored,
              onTap: () => reliability.requestBatteryOptimization(),
              buttonText: 'Disable Optimization',
            ),
            const SizedBox(height: 24),

            // Verify with Test Alarm
            Text(
              'Diagnostic Verification',
              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            NudgeCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Test Alarm Dispatch',
                    style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Schedule an instant 5-second test alarm. You can lock your device or switch apps to verify audio playback and full-screen ringing.',
                    style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.outline),
                  ),
                  const SizedBox(height: 14),
                  NudgeButton(
                    label: _testingAlarm ? 'Scheduling Test...' : 'Trigger 5-Second Test Alarm',
                    icon: Icons.alarm,
                    onPressed: _testingAlarm ? null : _triggerTestAlarm,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Manufacturer Specific Guides
            Text(
              'Manufacturer OEM Guides',
              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Aggressive battery killers in customized Android skins may terminate background services.',
              style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.outline),
            ),
            const SizedBox(height: 12),

            _buildOemGuideTile(
              brand: 'Samsung (One UI)',
              instructions: 'Settings > Apps > Nudge > Battery > Choose "Unrestricted". In Device Care > Battery > Background usage limits, ensure Nudge is not in "Sleeping apps".',
            ),
            const SizedBox(height: 8),
            _buildOemGuideTile(
              brand: 'Xiaomi / Redmi / POCO (MIUI / HyperOS)',
              instructions: 'Settings > Apps > Manage Apps > Nudge > Enable "Autostart". In Battery Saver, set to "No restrictions". Also lock Nudge in Recent Apps.',
            ),
            const SizedBox(height: 8),
            _buildOemGuideTile(
              brand: 'OnePlus / OPPO / Realme (OxygenOS / ColorOS)',
              instructions: 'Settings > Battery > More battery settings > App battery management > Nudge > Enable "Allow background activity" and "Allow auto-launch".',
            ),
            const SizedBox(height: 8),
            _buildOemGuideTile(
              brand: 'Huawei / Honor (EMUI / MagicOS)',
              instructions: 'Settings > Battery > App Launch > Nudge > Turn off "Manage automatically", and enable "Auto-launch", "Secondary launch", and "Run in background".',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChecklistTile({
    required String title,
    required String description,
    required bool isGranted,
    required VoidCallback onTap,
    required String buttonText,
  }) {
    final theme = Theme.of(context);
    return NudgeCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                isGranted ? Icons.check_circle : Icons.cancel,
                color: isGranted ? theme.colorScheme.primary : theme.colorScheme.error,
                size: 22,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              Chip(
                label: Text(isGranted ? 'Granted' : 'Missing'),
                backgroundColor: isGranted
                    ? theme.colorScheme.primaryContainer
                    : theme.colorScheme.errorContainer,
                labelStyle: TextStyle(
                  color: isGranted
                      ? theme.colorScheme.onPrimaryContainer
                      : theme.colorScheme.onErrorContainer,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.outline),
          ),
          if (!isGranted) ...[
            const SizedBox(height: 12),
            FilledButton.tonal(
              onPressed: onTap,
              child: Text(buttonText),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildOemGuideTile({required String brand, required String instructions}) {
    final theme = Theme.of(context);
    return ExpansionTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: theme.colorScheme.outlineVariant.withOpacity(0.5)),
      ),
      collapsedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: theme.colorScheme.outlineVariant.withOpacity(0.5)),
      ),
      leading: const Icon(Icons.phone_android),
      title: Text(brand, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
      childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      children: [
        Text(
          instructions,
          style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
        ),
      ],
    );
  }
}
