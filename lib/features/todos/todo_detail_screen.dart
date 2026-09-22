import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../application/controllers/folder_controller.dart';
import '../../application/controllers/todo_controller.dart';
import '../../domain/entities/reminder.dart';
import '../../domain/entities/todo.dart';
import '../../domain/enums/todo_enums.dart';
import '../../presentation/components/nudge_card.dart';
import '../../presentation/theme/nudge_theme.dart';
import '../reminders/reminder_editor_screen.dart';
import 'todo_editor_screen.dart';

class TodoDetailScreen extends StatefulWidget {
  final String todoId;

  const TodoDetailScreen({super.key, required this.todoId});

  @override
  State<TodoDetailScreen> createState() => _TodoDetailScreenState();
}

class _TodoDetailScreenState extends State<TodoDetailScreen> {
  final TextEditingController _subtaskController = TextEditingController();

  @override
  void dispose() {
    _subtaskController.dispose();
    super.dispose();
  }

  void _handleAddSubtask(TodoController todoCtrl) {
    final text = _subtaskController.text.trim();
    if (text.isEmpty) return;
    todoCtrl.addSubtask(widget.todoId, text);
    _subtaskController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final todoCtrl = context.watch<TodoController>();
    final folderCtrl = context.watch<FolderController>();

    final todo = todoCtrl.todos.firstWhere(
      (t) => t.id == widget.todoId,
      orElse: () => Todo(id: widget.todoId, title: 'Not found'),
    );

    if (todo.title == 'Not found') {
      return Scaffold(
        appBar: AppBar(title: const Text('Task Detail')),
        body: const Center(child: Text('Task not found or was deleted.')),
      );
    }

    final folder = todo.folderId != null ? folderCtrl.getFolderById(todo.folderId) : null;
    final isDone = todo.isDone;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Details'),
        actions: [
          IconButton(
            icon: Icon(todo.isPinned ? Icons.push_pin : Icons.push_pin_outlined),
            tooltip: todo.isPinned ? 'Unpin' : 'Pin to top',
            onPressed: () => todoCtrl.togglePin(todo.id),
          ),
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            tooltip: 'Edit Task',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => TodoEditorScreen(todo: todo),
                ),
              );
            },
          ),
          PopupMenuButton<String>(
            onSelected: (val) {
              if (val == 'reminder') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ReminderEditorScreen(
                      initialReminder: Reminder(
                        message: todo.title,
                        folderId: todo.folderId,
                        scheduledAt: todo.dueAt ?? DateTime.now().add(const Duration(hours: 1)),
                      ),
                    ),
                  ),
                );
              } else if (val == 'archive') {
                todoCtrl.toggleArchive(todo.id);
                Navigator.pop(context);
              } else if (val == 'delete') {
                todoCtrl.softDeleteTodo(todo.id);
                Navigator.pop(context);
              }
            },
            itemBuilder: (ctx) => [
              const PopupMenuItem(
                value: 'reminder',
                child: Row(
                  children: [
                    Icon(Icons.alarm_add_outlined, size: 18),
                    SizedBox(width: 8),
                    Text('Convert to Reminder Alarm'),
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
                    Text('Delete Task', style: TextStyle(color: Colors.red)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Header Card with Title and Toggle
          NudgeCard(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Transform.scale(
                    scale: 1.2,
                    child: Checkbox(
                      value: isDone,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                      onChanged: (_) => todoCtrl.toggleTodoStatus(todo.id),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          todo.title,
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            decoration: isDone ? TextDecoration.lineThrough : null,
                            color: isDone ? theme.colorScheme.outline : null,
                          ),
                        ),
                        if (todo.completedAt != null) ...[
                          const SizedBox(height: 4),
                          Text(
                            'Completed on ${DateFormat('MMM d, yyyy h:mm a').format(todo.completedAt!)}',
                            style: theme.textTheme.labelSmall?.copyWith(color: Colors.green),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Metadata Details: Priority, Due Date, Folder
          NudgeCard(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Priority
                  Row(
                    children: [
                      const Icon(Icons.flag_outlined, size: 20),
                      const SizedBox(width: 12),
                      Text('Priority', style: theme.textTheme.bodyMedium),
                      const Spacer(),
                      _buildPriorityPill(context, todo.priority),
                    ],
                  ),
                  const Divider(height: 24),

                  // Due Date
                  Row(
                    children: [
                      const Icon(Icons.calendar_today_outlined, size: 20),
                      const SizedBox(width: 12),
                      Text('Due Date', style: theme.textTheme.bodyMedium),
                      const Spacer(),
                      Text(
                        todo.dueAt != null
                            ? DateFormat('EEE, MMM d, yyyy · h:mm a').format(todo.dueAt!)
                            : 'None',
                        style: TextStyle(
                          color: todo.isOverdue ? Colors.red : null,
                          fontWeight: todo.isOverdue ? FontWeight.bold : null,
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 24),

                  // Folder
                  Row(
                    children: [
                      const Icon(Icons.folder_outlined, size: 20),
                      const SizedBox(width: 12),
                      Text('Folder', style: theme.textTheme.bodyMedium),
                      const Spacer(),
                      if (folder != null)
                        Row(
                          children: [
                            Icon(NudgeTheme.getFolderIcon(folder), size: 16, color: theme.colorScheme.primary),
                            const SizedBox(width: 6),
                            Text(folder.name, style: const TextStyle(fontWeight: FontWeight.w600)),
                          ],
                        )
                      else
                        const Text('Inbox / None'),
                    ],
                  ),

                  // Reminder Notification
                  if (todo.reminderEnabled) ...[
                    const Divider(height: 24),
                    Row(
                      children: [
                        const Icon(Icons.notifications_active_outlined, size: 20),
                        const SizedBox(width: 12),
                        Text('Gentle Reminder', style: theme.textTheme.bodyMedium),
                        const Spacer(),
                        Text(
                          todo.reminderAt != null
                              ? DateFormat('MMM d, h:mm a').format(todo.reminderAt!)
                              : 'Enabled',
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Description / Notes
          if (todo.description != null && todo.description!.trim().isNotEmpty) ...[
            Text('Notes', style: theme.textTheme.titleSmall),
            const SizedBox(height: 8),
            NudgeCard(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: SelectableText(
                  todo.description!.trim(),
                  style: theme.textTheme.bodyMedium?.copyWith(height: 1.5),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],

          // Subtasks Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Subtasks (${todo.completedSubtasksCount}/${todo.subtasks.length})',
                style: theme.textTheme.titleSmall,
              ),
              if (todo.hasSubtasks)
                Text(
                  '${(todo.subtasksProgress * 100).toInt()}% Done',
                  style: theme.textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          NudgeCard(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  // Add subtask input row
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _subtaskController,
                          decoration: const InputDecoration(
                            hintText: 'Add subtask...',
                            border: InputBorder.none,
                            isDense: true,
                          ),
                          onSubmitted: (_) => _handleAddSubtask(todoCtrl),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add_circle, color: Colors.teal),
                        onPressed: () => _handleAddSubtask(todoCtrl),
                      ),
                    ],
                  ),
                  if (todo.subtasks.isNotEmpty) const Divider(),
                  ...todo.subtasks.map((subtask) {
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Checkbox(
                        value: subtask.isDone,
                        onChanged: (_) => todoCtrl.toggleSubtask(todo.id, subtask.id),
                      ),
                      title: Text(
                        subtask.text,
                        style: TextStyle(
                          decoration: subtask.isDone ? TextDecoration.lineThrough : null,
                          color: subtask.isDone ? theme.colorScheme.outline : null,
                        ),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.close, size: 18),
                        onPressed: () => todoCtrl.deleteSubtask(todo.id, subtask.id),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Tags
          if (todo.tags.isNotEmpty) ...[
            Text('Tags', style: theme.textTheme.titleSmall),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: todo.tags.map((tag) {
                return Chip(
                  avatar: const Icon(Icons.tag, size: 14),
                  label: Text(tag),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
          ],
        ],
      ),
    );
  }

  Widget _buildPriorityPill(BuildContext context, TodoPriority priority) {
    Color color;
    String label;
    switch (priority) {
      case TodoPriority.urgent:
        color = Colors.red;
        label = 'Urgent';
        break;
      case TodoPriority.high:
        color = Colors.orange;
        label = 'High';
        break;
      case TodoPriority.normal:
        color = Theme.of(context).colorScheme.primary;
        label = 'Normal';
        break;
      case TodoPriority.low:
        color = Theme.of(context).colorScheme.outline;
        label = 'Low';
        break;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 12),
      ),
    );
  }
}
