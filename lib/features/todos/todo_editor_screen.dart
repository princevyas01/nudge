import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../application/controllers/folder_controller.dart';
import '../../application/controllers/todo_controller.dart';
import '../../domain/entities/todo.dart';
import '../../domain/entities/todo_subtask.dart';
import '../../domain/enums/todo_enums.dart';
import '../../presentation/theme/nudge_theme.dart';

class TodoEditorScreen extends StatefulWidget {
  final Todo? todo;
  final String? initialFolderId;
  final String? initialTitle;
  final String? initialDescription;
  final String? initialSourceRecordId;

  const TodoEditorScreen({
    super.key,
    this.todo,
    this.initialFolderId,
    this.initialTitle,
    this.initialDescription,
    this.initialSourceRecordId,
  });

  @override
  State<TodoEditorScreen> createState() => _TodoEditorScreenState();
}

class _TodoEditorScreenState extends State<TodoEditorScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descController;
  late TextEditingController _tagController;
  late TextEditingController _subtaskInputController;

  late TodoPriority _priority;
  String? _selectedFolderId;
  DateTime? _dueDate;
  TimeOfDay? _dueTime;
  bool _reminderEnabled = false;
  DateTime? _reminderDate;
  TimeOfDay? _reminderTime;

  List<TodoSubtask> _subtasks = [];
  List<String> _tags = [];

  @override
  void initState() {
    super.initState();
    final t = widget.todo;
    _titleController = TextEditingController(text: t?.title ?? widget.initialTitle ?? '');
    _descController = TextEditingController(text: t?.description ?? widget.initialDescription ?? '');
    _tagController = TextEditingController();
    _subtaskInputController = TextEditingController();

    _priority = t?.priority ?? TodoPriority.normal;
    _selectedFolderId = t?.folderId ?? widget.initialFolderId;
    if (t?.dueAt != null) {
      _dueDate = t!.dueAt;
      _dueTime = TimeOfDay.fromDateTime(t.dueAt!);
    }
    _reminderEnabled = t?.reminderEnabled ?? false;
    if (t?.reminderAt != null) {
      _reminderDate = t!.reminderAt;
      _reminderTime = TimeOfDay.fromDateTime(t.reminderAt!);
    }
    _subtasks = t != null ? List<TodoSubtask>.from(t.subtasks) : [];
    _tags = t != null ? List<String>.from(t.tags) : [];
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    _tagController.dispose();
    _subtaskInputController.dispose();
    super.dispose();
  }

  DateTime? _getCombinedDateTime(DateTime? date, TimeOfDay? time) {
    if (date == null) return null;
    final t = time ?? const TimeOfDay(hour: 9, minute: 0);
    return DateTime(date.year, date.month, date.day, t.hour, t.minute);
  }

  void _addSubtask() {
    final text = _subtaskInputController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _subtasks.add(
        TodoSubtask(
          todoId: widget.todo?.id ?? '',
          text: text,
          sortOrder: _subtasks.length,
        ),
      );
      _subtaskInputController.clear();
    });
  }

  void _addTag() {
    final tag = _tagController.text.trim().replaceAll('#', '');
    if (tag.isNotEmpty && !_tags.contains(tag)) {
      setState(() {
        _tags.add(tag);
        _tagController.clear();
      });
    }
  }

  Future<void> _pickDueDate() async {
    final now = DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _dueDate ?? now,
      firstDate: now.subtract(const Duration(days: 365)),
      lastDate: now.add(const Duration(days: 365 * 5)),
    );
    if (pickedDate != null) {
      if (!mounted) return;
      final pickedTime = await showTimePicker(
        context: context,
        initialTime: _dueTime ?? const TimeOfDay(hour: 12, minute: 0),
      );
      if (!mounted) return;
      setState(() {
        _dueDate = pickedDate;
        _dueTime = pickedTime ?? _dueTime ?? const TimeOfDay(hour: 12, minute: 0);
      });
    }
  }

  Future<void> _saveTodo() async {
    if (!_formKey.currentState!.validate()) return;

    final title = _titleController.text.trim();
    final desc = _descController.text.trim().isEmpty ? null : _descController.text.trim();
    final dueAt = _getCombinedDateTime(_dueDate, _dueTime);
    final reminderAt = _reminderEnabled ? _getCombinedDateTime(_reminderDate ?? _dueDate, _reminderTime ?? _dueTime) : null;

    final todoCtrl = context.read<TodoController>();

    if (widget.todo != null) {
      final updated = widget.todo!.copyWith(
        title: title,
        description: desc,
        priority: _priority,
        folderId: _selectedFolderId,
        dueAt: dueAt,
        tags: _tags,
        reminderEnabled: _reminderEnabled,
        reminderAt: reminderAt,
        subtasks: _subtasks,
      );
      await todoCtrl.updateTodo(updated);
    } else {
      final newTodo = Todo(
        title: title,
        description: desc,
        priority: _priority,
        folderId: _selectedFolderId,
        dueAt: dueAt,
        tags: _tags,
        reminderEnabled: _reminderEnabled,
        reminderAt: reminderAt,
        sourceRecordId: widget.initialSourceRecordId,
        subtasks: _subtasks,
      );
      await todoCtrl.createTodo(newTodo);
    }

    if (mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final folderCtrl = context.watch<FolderController>();
    final isEditing = widget.todo != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Task' : 'New Task'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: FilledButton.icon(
              onPressed: _saveTodo,
              icon: const Icon(Icons.check, size: 18),
              label: const Text('Save'),
            ),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Title Input
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Task Title *',
                hintText: 'What needs to be done?',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.check_box_outlined),
              ),
              textCapitalization: TextCapitalization.sentences,
              validator: (v) => (v == null || v.trim().isEmpty) ? 'Title is required' : null,
            ),
            const SizedBox(height: 14),

            // Description Input
            TextFormField(
              controller: _descController,
              decoration: const InputDecoration(
                labelText: 'Description / Notes',
                hintText: 'Add details, links, or context...',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.notes),
              ),
              maxLines: 3,
              textCapitalization: TextCapitalization.sentences,
            ),
            const SizedBox(height: 18),

            // Priority Selector
            Text('Priority', style: theme.textTheme.titleSmall),
            const SizedBox(height: 8),
            SegmentedButton<TodoPriority>(
              segments: const [
                ButtonSegment(value: TodoPriority.low, label: Text('Low')),
                ButtonSegment(value: TodoPriority.normal, label: Text('Normal')),
                ButtonSegment(value: TodoPriority.high, label: Text('High')),
                ButtonSegment(value: TodoPriority.urgent, label: Text('Urgent')),
              ],
              selected: {_priority},
              onSelectionChanged: (newSelection) {
                setState(() => _priority = newSelection.first);
              },
            ),
            const SizedBox(height: 18),

            // Folder Picker
            Text('Folder', style: theme.textTheme.titleSmall),
            const SizedBox(height: 8),
            DropdownButtonFormField<String?>(
              value: _selectedFolderId,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.folder_outlined),
              ),
              items: [
                const DropdownMenuItem<String?>(
                  value: null,
                  child: Text('No Folder (Inbox)'),
                ),
                ...folderCtrl.folders.map(
                  (f) => DropdownMenuItem<String?>(
                    value: f.id,
                    child: Row(
                      children: [
                        Icon(NudgeTheme.getFolderIcon(f), size: 16),
                        const SizedBox(width: 8),
                        Text(f.name),
                      ],
                    ),
                  ),
                ),
              ],
              onChanged: (val) => setState(() => _selectedFolderId = val),
            ),
            const SizedBox(height: 18),

            // Due Date & Time
            Text('Due Date', style: theme.textTheme.titleSmall),
            const SizedBox(height: 8),
            ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(color: theme.colorScheme.outlineVariant),
              ),
              leading: const Icon(Icons.calendar_today_outlined),
              title: Text(
                _dueDate != null
                    ? DateFormat('EEE, MMM d, yyyy').format(_dueDate!) +
                        (_dueTime != null ? ' at ${_dueTime!.format(context)}' : '')
                    : 'Set Due Date',
              ),
              trailing: _dueDate != null
                  ? IconButton(
                      icon: const Icon(Icons.clear, size: 20),
                      onPressed: () {
                        setState(() {
                          _dueDate = null;
                          _dueTime = null;
                        });
                      },
                    )
                  : const Icon(Icons.chevron_right),
              onTap: _pickDueDate,
            ),
            const SizedBox(height: 18),

            // Gentle Notification Switch
            SwitchListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(color: theme.colorScheme.outlineVariant),
              ),
              secondary: const Icon(Icons.notifications_active_outlined),
              title: const Text('Gentle Reminder Notification'),
              subtitle: const Text('Sends a quiet notification at due time without loud alarms'),
              value: _reminderEnabled,
              onChanged: (val) {
                setState(() => _reminderEnabled = val);
              },
            ),
            const SizedBox(height: 22),

            // Subtasks Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Subtasks (${_subtasks.where((s) => s.isDone).length}/${_subtasks.length})',
                  style: theme.textTheme.titleSmall,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _subtaskInputController,
                    decoration: const InputDecoration(
                      hintText: 'Add a subtask...',
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                    onSubmitted: (_) => _addSubtask(),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton.filled(
                  icon: const Icon(Icons.add),
                  onPressed: _addSubtask,
                ),
              ],
            ),
            if (_subtasks.isNotEmpty) ...[
              const SizedBox(height: 8),
              ..._subtasks.asMap().entries.map((entry) {
                final idx = entry.key;
                final subtask = entry.value;
                return ListTile(
                  dense: true,
                  leading: Checkbox(
                    value: subtask.isDone,
                    onChanged: (val) {
                      setState(() {
                        _subtasks[idx] = subtask.copyWith(isDone: val ?? false);
                      });
                    },
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
                    onPressed: () {
                      setState(() {
                        _subtasks.removeAt(idx);
                      });
                    },
                  ),
                );
              }),
            ],
            const SizedBox(height: 22),

            // Tags Section
            Text('Tags', style: theme.textTheme.titleSmall),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _tagController,
                    decoration: const InputDecoration(
                      hintText: 'Add tag (e.g. work, project)',
                      border: OutlineInputBorder(),
                      prefixText: '#',
                      isDense: true,
                    ),
                    onSubmitted: (_) => _addTag(),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton.filledTonal(
                  icon: const Icon(Icons.add),
                  onPressed: _addTag,
                ),
              ],
            ),
            if (_tags.isNotEmpty) ...[
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: _tags.map((tag) {
                  return Chip(
                    label: Text('#$tag'),
                    onDeleted: () {
                      setState(() {
                        _tags.remove(tag);
                      });
                    },
                  );
                }).toList(),
              ),
            ],
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
