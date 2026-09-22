import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../application/controllers/settings_controller.dart';
import '../../application/controllers/theme_controller.dart';
import '../../application/controllers/reminder_controller.dart';
import '../../application/controllers/folder_controller.dart';
import '../../application/controllers/todo_controller.dart';
import '../../application/controllers/record_controller.dart';
import '../../core/constants/app_constants.dart';
import '../../presentation/components/nudge_card.dart';
import '../backup/backup_screen.dart';
import '../reliability/improve_reliability_screen.dart';
import '../companion/customize_companion_screen.dart';
import '../todos/todos_screen.dart';
import '../records/records_screen.dart';
import 'custom_alarm_sound_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  void _showResetConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Row(
          children: [
            Icon(Icons.warning_rounded, color: Colors.red),
            SizedBox(width: 8),
            Text('Reset All Data?'),
          ],
        ),
        content: const Text(
          'This action will permanently delete all reminders, folders, history, and mascot achievements. It will also cancel all scheduled alarms.\n\nThis cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.error),
            onPressed: () async {
              Navigator.pop(ctx);
              final settings = context.read<SettingsController>();
              final reminders = context.read<ReminderController>();
              final folders = context.read<FolderController>();

              await settings.resetAppData(
                reminderController: reminders,
                folderController: folders,
              );

              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('App data has been completely reset to factory defaults.'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
            },
            child: const Text('Reset Everything'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeCtrl = context.watch<ThemeController>();
    final settingsCtrl = context.watch<SettingsController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        children: [
          // Appearance Section
          _buildSectionHeader(context, 'Appearance'),
          const SizedBox(height: 8),
          NudgeCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Theme Mode',
                  style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                SegmentedButton<ThemeMode>(
                  segments: const [
                    ButtonSegment(
                      value: ThemeMode.system,
                      label: Text('System'),
                      icon: Icon(Icons.brightness_auto),
                    ),
                    ButtonSegment(
                      value: ThemeMode.light,
                      label: Text('Light'),
                      icon: Icon(Icons.light_mode),
                    ),
                    ButtonSegment(
                      value: ThemeMode.dark,
                      label: Text('Dark'),
                      icon: Icon(Icons.dark_mode),
                    ),
                  ],
                  selected: {themeCtrl.themeMode},
                  onSelectionChanged: (Set<ThemeMode> selection) {
                    themeCtrl.setThemeMode(selection.first);
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Alarm & Reminders Section
          _buildSectionHeader(context, 'Alarms & Timing'),
          const SizedBox(height: 8),
          NudgeCard(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Default Snooze',
                          style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Duration added when snoozing',
                          style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.outline),
                        ),
                      ],
                    ),
                    DropdownButton<int>(
                      value: settingsCtrl.defaultSnoozeMinutes,
                      borderRadius: BorderRadius.circular(16),
                      items: const [
                        DropdownMenuItem(value: 5, child: Text('5 minutes')),
                        DropdownMenuItem(value: 10, child: Text('10 minutes')),
                        DropdownMenuItem(value: 15, child: Text('15 minutes')),
                        DropdownMenuItem(value: 30, child: Text('30 minutes')),
                      ],
                      onChanged: (val) {
                        if (val != null) {
                          settingsCtrl.setDefaultSnoozeMinutes(val);
                        }
                      },
                    ),
                  ],
                ),
                const Divider(height: 24),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    'Alarm Audio Playback',
                    style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    'Enable sound effects and looping alarm tones',
                    style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.outline),
                  ),
                  value: settingsCtrl.soundEnabled,
                  onChanged: (val) {
                    settingsCtrl.setSoundEnabled(val);
                  },
                ),
                const Divider(height: 24),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.music_note),
                  title: Text(
                    'Custom Alarm Sound',
                    style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    settingsCtrl.hasCustomSound
                        ? (settingsCtrl.customSoundTitle ?? 'Custom Song Segment')
                        : 'System Default (Tap to select & trim song)',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: settingsCtrl.hasCustomSound ? theme.colorScheme.primary : theme.colorScheme.outline,
                    ),
                  ),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const CustomAlarmSoundScreen()),
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // System Reliability & Companion Navigation
          _buildSectionHeader(context, 'Features & Reliability'),
          const SizedBox(height: 8),
          NudgeCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.bolt),
                  title: const Text('Alarm & Background Reliability'),
                  subtitle: const Text('Permissions, exact alarms, battery guides'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const ImproveReliabilityScreen()),
                    );
                  },
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.pets),
                  title: const Text('Mascot & Accountability Companion'),
                  subtitle: const Text('Customize avatar, milestones, cosmetics'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const CustomizeCompanionScreen()),
                    );
                  },
                ),
              ],
            ),
          ),
          // Tasks & Productivity
          _buildSectionHeader(context, 'Tasks & Productivity'),
          const SizedBox(height: 8),
          NudgeCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.task_alt, color: Colors.blue),
                  title: const Text('Manage Tasks & Todos'),
                  subtitle: Consumer<TodoController>(
                    builder: (_, todoCtrl, __) => Text('${todoCtrl.activeCount} active tasks, ${todoCtrl.completedCount} completed'),
                  ),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const TodosScreen()),
                    );
                  },
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.note_alt_outlined, color: Colors.amber),
                  title: const Text('Records & Capture'),
                  subtitle: Consumer<RecordController>(
                    builder: (_, recordCtrl, __) => Text('${recordCtrl.totalActiveCount} saved notes & records'),
                  ),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const RecordsScreen()),
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Data Management Section
          _buildSectionHeader(context, 'Data & Backup'),
          const SizedBox(height: 8),
          NudgeCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.shield_outlined),
                  title: const Text('Encrypted Backup & Restore'),
                  subtitle: const Text('Export or import AES-256 authenticated data'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const BackupScreen()),
                    );
                  },
                ),
                const Divider(height: 1),
                ListTile(
                  leading: Icon(Icons.delete_forever, color: theme.colorScheme.error),
                  title: Text(
                    'Reset App Data',
                    style: TextStyle(color: theme.colorScheme.error, fontWeight: FontWeight.bold),
                  ),
                  subtitle: const Text('Wipe all reminders, database, and scheduled alarms'),
                  onTap: () => _showResetConfirmationDialog(context),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // About & Privacy
          _buildSectionHeader(context, 'About Nudge'),
          const SizedBox(height: 8),
          NudgeCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(Icons.notifications_active, color: theme.colorScheme.primary),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppConstants.appName,
                          style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Version ${AppConstants.appVersion} (Build ${AppConstants.appBuild})',
                          style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.outline),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  AppConstants.appTagline,
                  style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.lock_outline, size: 16, color: theme.colorScheme.primary),
                    const SizedBox(width: 6),
                    Text(
                      '100% Offline • Zero Analytics • Zero Tracking',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleSmall?.copyWith(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
    );
  }
}
