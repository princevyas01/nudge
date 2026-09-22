import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../application/controllers/folder_controller.dart';
import '../../application/controllers/todo_controller.dart';
import '../../domain/entities/todo.dart';
import '../../domain/enums/todo_enums.dart';
import '../../presentation/components/nudge_card.dart';
import '../../presentation/theme/nudge_theme.dart';
import 'todo_detail_screen.dart';
import 'todo_editor_screen.dart';

class TodoCard extends StatelessWidget {
  final Todo todo;

  const TodoCard({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final todoCtrl = context.read<TodoController>();
    final folderCtrl = context.watch<FolderController>();
    final folder = todo.folderId != null ? folderCtrl.getFolderById(todo.folderId) : null;

    final isDone = todo.isDone;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: NudgeCard(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => TodoDetailScreen(todoId: todo.id),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Checkbox
                  Transform.scale(
                    scale: 1.1,
                    child: Checkbox(
                      value: isDone,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                      activeColor: theme.colorScheme.primary,
                      onChanged: (_) {
                        todoCtrl.toggleTodoStatus(todo.id);
                      },
                    ),
                  ),
                  const SizedBox(width: 4),
                  // Title and details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            if (todo.isPinned) ...[
                              Icon(Icons.push_pin, size: 14, color: theme.colorScheme.primary),
                              const SizedBox(width: 4),
                            ],
                            Expanded(
                              child: Text(
                                todo.title,
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  decoration: isDone ? TextDecoration.lineThrough : null,
                                  color: isDone
                                      ? theme.colorScheme.outline
                                      : theme.colorScheme.onSurface,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        if (todo.description != null && todo.description!.trim().isNotEmpty) ...[
                          const SizedBox(height: 4),
                          Text(
                            todo.description!.trim(),
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                              decoration: isDone ? TextDecoration.lineThrough : null,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ],
                    ),
                  ),
                  // Popup Menu
                  PopupMenuButton<String>(
                    icon: Icon(Icons.more_vert, size: 20, color: theme.colorScheme.outline),
                    onSelected: (val) {
                      switch (val) {
                        case 'pin':
                          todoCtrl.togglePin(todo.id);
                          break;
                        case 'edit':
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => TodoEditorScreen(todo: todo),
                            ),
                          );
                          break;
                        case 'archive':
                          todoCtrl.toggleArchive(todo.id);
                          break;
                        case 'delete':
                          todoCtrl.softDeleteTodo(todo.id);
                          break;
                      }
                    },
                    itemBuilder: (ctx) => [
                      PopupMenuItem(
                        value: 'pin',
                        child: Row(
                          children: [
                            Icon(todo.isPinned ? Icons.push_pin_outlined : Icons.push_pin, size: 18),
                            const SizedBox(width: 8),
                            Text(todo.isPinned ? 'Unpin' : 'Pin to top'),
                          ],
                        ),
                      ),
                      const PopupMenuItem(
                        value: 'edit',
                        child: Row(
                          children: [
                            Icon(Icons.edit_outlined, size: 18),
                            SizedBox(width: 8),
                            Text('Edit'),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: 'archive',
                        child: Row(
                          children: [
                            Icon(todo.isArchived ? Icons.unarchive_outlined : Icons.archive_outlined, size: 18),
                            const SizedBox(width: 8),
                            Text(todo.isArchived ? 'Unarchive' : 'Archive'),
                          ],
                        ),
                      ),
                      const PopupMenuItem(
                        value: 'delete',
                        child: Row(
                          children: [
                            Icon(Icons.delete_outline, size: 18, color: Colors.red),
                            SizedBox(width: 8),
                            Text('Delete', style: TextStyle(color: Colors.red)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              // Subtasks Progress
              if (todo.hasSubtasks) ...[
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.only(left: 44, right: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Subtasks: ${todo.completedSubtasksCount}/${todo.subtasks.length}',
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: theme.colorScheme.outline,
                            ),
                          ),
                          Text(
                            '${(todo.subtasksProgress * 100).toInt()}%',
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: theme.colorScheme.outline,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: todo.subtasksProgress,
                          minHeight: 4,
                          backgroundColor: theme.colorScheme.surfaceContainerHighest,
                          valueColor: AlwaysStoppedAnimation(
                            todo.subtasksProgress == 1.0
                                ? Colors.green
                                : theme.colorScheme.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              const SizedBox(height: 8),
              // Badges row: Priority, Due Date, Folder, Tags
              Padding(
                padding: const EdgeInsets.only(left: 44),
                child: Wrap(
                  spacing: 6,
                  runSpacing: 4,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    _buildPriorityBadge(context, todo.priority),
                    if (todo.dueAt != null) _buildDueDateBadge(context, todo),
                    if (folder != null)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surfaceContainerHighest.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(NudgeTheme.getFolderIcon(folder), size: 12, color: theme.colorScheme.primary),
                            const SizedBox(width: 4),
                            Text(folder.name, style: theme.textTheme.labelSmall),
                          ],
                        ),
                      ),
                    ...todo.tags.map(
                      (tag) => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.secondaryContainer.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          '#$tag',
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: theme.colorScheme.onSecondaryContainer,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPriorityBadge(BuildContext context, TodoPriority priority) {
    final theme = Theme.of(context);
    Color color;
    String label;
    IconData icon;

    switch (priority) {
      case TodoPriority.urgent:
        color = Colors.red;
        label = 'Urgent';
        icon = Icons.priority_high;
        break;
      case TodoPriority.high:
        color = Colors.orange;
        label = 'High';
        icon = Icons.flag;
        break;
      case TodoPriority.normal:
        color = theme.colorScheme.primary;
        label = 'Normal';
        icon = Icons.outlined_flag;
        break;
      case TodoPriority.low:
        color = theme.colorScheme.outline;
        label = 'Low';
        icon = Icons.flag_outlined;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withOpacity(0.3), width: 0.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 3),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDueDateBadge(BuildContext context, Todo todo) {
    final isOverdue = todo.isOverdue;
    final isDueToday = todo.isDueToday;
    final dueAt = todo.dueAt!;

    Color color;
    String label;

    if (isOverdue) {
      color = Colors.red;
      label = 'Overdue (${DateFormat('MMM d').format(dueAt)})';
    } else if (isDueToday) {
      color = Colors.orange;
      label = 'Today ${DateFormat('h:mm a').format(dueAt)}';
    } else {
      color = Theme.of(context).colorScheme.outline;
      label = DateFormat('MMM d, h:mm a').format(dueAt);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.event, size: 12, color: color),
          const SizedBox(width: 3),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
