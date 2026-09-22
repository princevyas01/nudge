import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../application/controllers/timer_controller.dart';
import '../../presentation/components/nudge_button.dart';
import '../../presentation/theme/nudge_theme.dart';

class TimerScreen extends StatelessWidget {
  const TimerScreen({super.key});

  String _formatDuration(Duration d) {
    final hours = d.inHours;
    final minutes = d.inMinutes.remainder(60);
    final seconds = d.inSeconds.remainder(60);

    if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    }
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  void _showCustomDurationDialog(BuildContext context, TimerController timer) {
    final minController = TextEditingController(text: '15');

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Custom Duration'),
        content: TextField(
          controller: minController,
          keyboardType: TextInputType.number,
          autofocus: true,
          decoration: const InputDecoration(
            labelText: 'Duration in Minutes',
            suffixText: 'mins',
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          FilledButton(
            onPressed: () {
              final mins = int.tryParse(minController.text.trim()) ?? 0;
              if (mins > 0) {
                timer.startTimer(Duration(minutes: mins));
                Navigator.pop(ctx);
              }
            },
            child: const Text('Start'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final timer = context.watch<TimerController>();

    final presets = [
      {'label': '5m', 'duration': const Duration(minutes: 5)},
      {'label': '10m', 'duration': const Duration(minutes: 10)},
      {'label': '25m', 'duration': const Duration(minutes: 25)},
      {'label': '1h', 'duration': const Duration(hours: 1)},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Timer'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              // Countdown Circle
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 240,
                    height: 240,
                    child: CircularProgressIndicator(
                      value: timer.progress,
                      strokeWidth: 10,
                      backgroundColor: isDark ? NudgeTheme.surfaceContainerDark : NudgeTheme.surfaceContainerLight,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        timer.isFinished
                            ? Colors.green
                            : (isDark ? NudgeTheme.secondaryContainer : NudgeTheme.secondary),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        timer.isFinished
                            ? '00:00'
                            : (timer.isRunning ? _formatDuration(timer.remainingTime) : '00:00'),
                        style: const TextStyle(
                          fontSize: 44,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 2,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        timer.isFinished
                            ? 'Timer Completed!'
                            : (timer.isRunning ? 'Remaining' : 'Ready to Start'),
                        style: TextStyle(
                          fontSize: 14,
                          color: timer.isFinished ? Colors.green : Colors.grey,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Spacer(),

              // Quick Presets
              if (!timer.isRunning) ...[
                const Text(
                  'Quick Presets',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: presets.map((p) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6.0),
                      child: ActionChip(
                        label: Text(p['label'] as String),
                        onPressed: () => timer.startTimer(p['duration'] as Duration),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 8),
                TextButton.icon(
                  icon: const Icon(Icons.tune),
                  label: const Text('Custom Duration'),
                  onPressed: () => _showCustomDurationDialog(context, timer),
                ),
              ],

              const SizedBox(height: 24),

              // Action Buttons
              if (timer.isRunning) ...[
                NudgeButton(
                  label: 'Cancel Timer',
                  icon: Icons.stop,
                  variant: ButtonVariant.danger,
                  width: double.infinity,
                  onPressed: () => timer.cancelTimer(),
                ),
              ] else if (timer.isFinished) ...[
                NudgeButton(
                  label: 'Dismiss & Reset',
                  icon: Icons.check,
                  variant: ButtonVariant.primary,
                  width: double.infinity,
                  onPressed: () => timer.cancelTimer(),
                ),
              ],
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
