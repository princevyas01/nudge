import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../application/controllers/companion_controller.dart';
import '../../application/controllers/folder_controller.dart';
import '../../application/controllers/reminder_controller.dart';
import '../../core/utils/date_utils.dart';
import '../../domain/entities/reminder.dart';
import '../../domain/enums/enums.dart';
import '../../presentation/theme/nudge_theme.dart';
import '../../features/reminders/reminder_editor_screen.dart';

class ReminderCard extends StatelessWidget {
  final Reminder reminder;

  const ReminderCard({super.key, required this.reminder});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final folderController = context.watch<FolderController>();
    final reminderController = context.read<ReminderController>();
    final companionController = context.read<CompanionController>();

    final folder = folderController.getFolderById(reminder.folderId);
    final isOverdue = reminder.isOverdue;

    Color priorityColor = Colors.grey;
    if (reminder.priority == PriorityLevel.high) priorityColor = NudgeTheme.error;
    if (reminder.priority == PriorityLevel.normal) priorityColor = NudgeTheme.secondary;

    return Dismissible(
      key: Key('dismiss_${reminder.id}'),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: NudgeTheme.error,
          borderRadius: BorderRadius.circular(NudgeTheme.radiusL),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(Icons.delete_outline, color: Colors.white, size: 24),
            SizedBox(width: 8),
            Text('Delete', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
      onDismissed: (_) {
        reminderController.deleteReminder(reminder.id);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Deleted "${reminder.message}"'),
            action: SnackBarAction(
              label: 'UNDO',
              onPressed: () => reminderController.undoDelete(),
            ),
            duration: const Duration(seconds: 4),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(NudgeTheme.radiusL),
          side: BorderSide(
            color: isOverdue ? NudgeTheme.error.withOpacity(0.5) : (isDark ? NudgeTheme.cardBorderDark : NudgeTheme.cardBorderLight),
            width: isOverdue ? 1.5 : 1.0,
          ),
        ),
        color: isDark ? NudgeTheme.surfaceDark : NudgeTheme.surfaceLight,
        child: InkWell(
          borderRadius: BorderRadius.circular(NudgeTheme.radiusL),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ReminderEditorScreen(initialReminder: reminder),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Row: Pin, Completion Circle, Message, Menu
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Completion Checkbox Circle
                    IconButton(
                      icon: Icon(
                        reminder.isDone ? Icons.check_circle : Icons.radio_button_unchecked,
                        color: reminder.isDone ? Colors.green : (isOverdue ? NudgeTheme.error : NudgeTheme.secondary),
                        size: 24,
                      ),
                      tooltip: reminder.isDone ? 'Completed' : 'Mark as done',
                      onPressed: () => reminderController.completeReminder(reminder.id, companionController),
                    ),
                    const SizedBox(width: 6),
                    // Message
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              if (reminder.isPinned)
                                const Padding(
                                  padding: EdgeInsets.only(right: 6.0),
                                  child: Icon(Icons.push_pin, size: 16, color: Colors.amber),
                                ),
                              Expanded(
                                child: Text(
                                  reminder.message,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    decoration: reminder.isDone ? TextDecoration.lineThrough : null,
                                    color: reminder.isDone
                                        ? Colors.grey
                                        : (isDark ? NudgeTheme.onBgDark : NudgeTheme.onBgLight),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          // Time and Date Row
                          Row(
                            children: [
                              Icon(
                                Icons.access_time,
                                size: 14,
                                color: isOverdue ? NudgeTheme.error : Colors.grey,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                NudgeDateUtils.formatDateTime(reminder.scheduledAt),
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: isOverdue ? FontWeight.bold : FontWeight.normal,
                                  color: isOverdue ? NudgeTheme.error : (isDark ? Colors.grey[400] : Colors.grey[600]),
                                ),
                              ),
                              if (reminder.isRepeating) ...[
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                                  decoration: BoxDecoration(
                                    color: isDark ? NudgeTheme.surfaceContainerDark : NudgeTheme.surfaceContainerLight,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(Icons.repeat, size: 11, color: Colors.grey),
                                      const SizedBox(width: 2),
                                      Text(
                                        reminder.repeatRule.name,
                                        style: const TextStyle(fontSize: 10, color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Card Menu
                    PopupMenuButton<String>(
                      icon: const Icon(Icons.more_vert, size: 20),
                      onSelected: (value) {
                        switch (value) {
                          case 'pin':
                            reminderController.togglePin(reminder.id);
                            break;
                          case 'archive':
                            reminderController.toggleArchive(reminder.id);
                            break;
                          case 'skip':
                            reminderController.skipOccurrence(reminder.id);
                            break;
                          case 'edit':
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ReminderEditorScreen(initialReminder: reminder),
                              ),
                            );
                            break;
                          case 'delete':
                            reminderController.deleteReminder(reminder.id);
                            break;
                        }
                      },
                      itemBuilder: (ctx) => [
                        PopupMenuItem(
                          value: 'pin',
                          child: Row(
                            children: [
                              Icon(reminder.isPinned ? Icons.push_pin_outlined : Icons.push_pin, size: 18),
                              const SizedBox(width: 10),
                              Text(reminder.isPinned ? 'Unpin' : 'Pin to top'),
                            ],
                          ),
                        ),
                        const PopupMenuItem(
                          value: 'edit',
                          child: Row(
                            children: [
                              Icon(Icons.edit_outlined, size: 18),
                              SizedBox(width: 10),
                              Text('Edit'),
                            ],
                          ),
                        ),
                        if (reminder.isRepeating)
                          const PopupMenuItem(
                            value: 'skip',
                            child: Row(
                              children: [
                                Icon(Icons.skip_next_outlined, size: 18),
                                SizedBox(width: 10),
                                Text('Skip occurrence'),
                              ],
                            ),
                          ),
                        PopupMenuItem(
                          value: 'archive',
                          child: Row(
                            children: [
                              Icon(reminder.isArchived ? Icons.unarchive_outlined : Icons.archive_outlined, size: 18),
                              const SizedBox(width: 10),
                              Text(reminder.isArchived ? 'Unarchive' : 'Archive'),
                            ],
                          ),
                        ),
                        const PopupMenuItem(
                          value: 'delete',
                          child: Row(
                            children: [
                              Icon(Icons.delete_outline, size: 18, color: NudgeTheme.error),
                              SizedBox(width: 10),
                              Text('Delete', style: TextStyle(color: NudgeTheme.error)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                // Metadata Row: Folder, Checklist Progress, Priority Badge, Photo indicator
                Padding(
                  padding: const EdgeInsets.only(left: 42.0, top: 8.0),
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      // Folder Chip
                      if (folder != null)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: NudgeTheme.getFolderColor(folder, isDark).withOpacity(0.15),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                NudgeTheme.getFolderIcon(folder),
                                size: 12,
                                color: NudgeTheme.getFolderColor(folder, isDark),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                folder.name,
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: NudgeTheme.getFolderColor(folder, isDark),
                                ),
                              ),
                            ],
                          ),
                        ),
                      // Priority Badge
                      if (reminder.priority != PriorityLevel.normal)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: priorityColor.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            reminder.priority.name.toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: priorityColor,
                            ),
                          ),
                        ),
                      // Checklist Progress
                      if (reminder.hasChecklist)
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.checklist, size: 14, color: Colors.grey),
                            const SizedBox(width: 3),
                            Text(
                              '${reminder.checklistCompletedCount}/${reminder.checklist.length}',
                              style: const TextStyle(fontSize: 11, color: Colors.grey),
                            ),
                          ],
                        ),
                      // Photo Indicator
                      if (reminder.photoPath != null && reminder.photoPath!.isNotEmpty)
                        const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.photo_outlined, size: 14, color: Colors.grey),
                          ],
                        ),
                      // Snooze Count badge
                      if (reminder.snoozeCount > 0)
                        Text(
                          'Snoozed ${reminder.snoozeCount}x',
                          style: const TextStyle(fontSize: 11, color: Colors.orange, fontWeight: FontWeight.bold),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
