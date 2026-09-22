import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../application/controllers/folder_controller.dart';
import '../../application/controllers/record_controller.dart';
import '../../domain/entities/record.dart';
import '../../domain/enums/todo_enums.dart';
import '../../presentation/theme/nudge_theme.dart';
import '../todos/todo_editor_screen.dart';

class RecordEditorScreen extends StatefulWidget {
  final Record? record;
  final String? initialFolderId;
  final RecordType? initialType;

  const RecordEditorScreen({
    super.key,
    this.record,
    this.initialFolderId,
    this.initialType,
  });

  @override
  State<RecordEditorScreen> createState() => _RecordEditorScreenState();
}

class _RecordEditorScreenState extends State<RecordEditorScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _contentController;

  late RecordType _recordType;
  String? _selectedFolderId;

  @override
  void initState() {
    super.initState();
    final r = widget.record;
    _titleController = TextEditingController(text: r?.title ?? '');
    _contentController = TextEditingController(text: r?.content ?? '');
    _recordType = r?.recordType ?? widget.initialType ?? RecordType.note;
    _selectedFolderId = r?.folderId ?? widget.initialFolderId;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  Future<Record?> _saveRecord({bool closeOnSave = true}) async {
    if (!_formKey.currentState!.validate()) return null;

    final title = _titleController.text.trim();
    final content = _contentController.text.trim();
    final recordCtrl = context.read<RecordController>();

    Record result;
    if (widget.record != null) {
      result = widget.record!.copyWith(
        title: title,
        content: content,
        recordType: _recordType,
        folderId: _selectedFolderId,
      );
      await recordCtrl.updateRecord(result);
    } else {
      result = Record(
        title: title,
        content: content,
        recordType: _recordType,
        folderId: _selectedFolderId,
        occurredAt: DateTime.now(),
      );
      await recordCtrl.createRecord(result);
    }

    if (closeOnSave && mounted) {
      Navigator.pop(context);
    }
    return result;
  }

  Future<void> _saveAndTurnIntoTodo() async {
    final savedRecord = await _saveRecord(closeOnSave: false);
    if (savedRecord == null || !mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => TodoEditorScreen(
          initialTitle: savedRecord.title,
          initialDescription: savedRecord.content,
          initialFolderId: savedRecord.folderId,
          initialSourceRecordId: savedRecord.id,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final folderCtrl = context.watch<FolderController>();
    final isEditing = widget.record != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Record' : 'New Record'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: FilledButton.icon(
              onPressed: () => _saveRecord(closeOnSave: true),
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
            // Title
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title *',
                hintText: 'Idea, thought, note heading...',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.title),
              ),
              textCapitalization: TextCapitalization.sentences,
              validator: (v) => (v == null || v.trim().isEmpty) ? 'Title is required' : null,
            ),
            const SizedBox(height: 14),

            // Record Type Selector
            Text('Type', style: theme.textTheme.titleSmall),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: RecordType.values.map((type) {
                final isSelected = _recordType == type;
                return ChoiceChip(
                  label: Text(_getTypeLabel(type)),
                  selected: isSelected,
                  onSelected: (val) {
                    if (val) setState(() => _recordType = type);
                  },
                );
              }).toList(),
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
                  child: Text('No Folder (General)'),
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

            // Content / Freeform Body
            TextFormField(
              controller: _contentController,
              decoration: const InputDecoration(
                labelText: 'Content / Notes',
                hintText: 'Write down details, reflections, code, or logs...',
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
              maxLines: 10,
              textCapitalization: TextCapitalization.sentences,
            ),
            const SizedBox(height: 24),

            // Turn into Todo Action
            OutlinedButton.icon(
              onPressed: _saveAndTurnIntoTodo,
              icon: const Icon(Icons.add_task),
              label: const Text('Save & Turn into Task (Todo)'),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  String _getTypeLabel(RecordType type) {
    switch (type) {
      case RecordType.note:
        return '📝 Note';
      case RecordType.idea:
        return '💡 Idea';
      case RecordType.thought:
        return '🧠 Thought';
      case RecordType.log:
        return '📋 Log';
      case RecordType.snippet:
        return '💻 Snippet';
      case RecordType.decision:
        return '⚖️ Decision';
    }
  }
}
