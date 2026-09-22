import 'package:flutter/material.dart';
import '../../features/records/record_editor_screen.dart';
import '../../features/reminders/reminder_editor_screen.dart';
import '../../features/todos/todo_editor_screen.dart';

class QuickAddSheet extends StatelessWidget {
  final VoidCallback? onOpenTimer;

  const QuickAddSheet({super.key, this.onOpenTimer});

  static Future<void> show(BuildContext context, {VoidCallback? onOpenTimer}) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => QuickAddSheet(onOpenTimer: onOpenTimer),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: theme.colorScheme.outlineVariant,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Quick Add',
            style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          // 1. New Reminder (Exact Alarm)
          ListTile(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            leading: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.teal.withOpacity(0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.alarm_add, color: Colors.teal),
            ),
            title: const Text('Reminder Alarm', style: TextStyle(fontWeight: FontWeight.w600)),
            subtitle: const Text('Exact time notification & native ringing alarm'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ReminderEditorScreen()),
              );
            },
          ),
          const SizedBox(height: 8),

          // 2. New Task / Todo
          ListTile(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            leading: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.check_circle_outline, color: Colors.blue),
            ),
            title: const Text('Task / Todo', style: TextStyle(fontWeight: FontWeight.w600)),
            subtitle: const Text('Action item with subtasks, priority, & due date'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const TodoEditorScreen()),
              );
            },
          ),
          const SizedBox(height: 8),

          // 3. New Record / Note
          ListTile(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            leading: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.amber.withOpacity(0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.edit_note, color: Colors.amber),
            ),
            title: const Text('Record / Note', style: TextStyle(fontWeight: FontWeight.w600)),
            subtitle: const Text('Freeform capture of thoughts, ideas, decisions, or logs'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const RecordEditorScreen()),
              );
            },
          ),
          const SizedBox(height: 8),

          // 4. Timer / Focus
          ListTile(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            leading: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.purple.withOpacity(0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.timer_outlined, color: Colors.purple),
            ),
            title: const Text('Focus Timer', style: TextStyle(fontWeight: FontWeight.w600)),
            subtitle: const Text('Countdown timer for deep work sessions'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.pop(context);
              onOpenTimer?.call();
            },
          ),
        ],
      ),
    );
  }
}
