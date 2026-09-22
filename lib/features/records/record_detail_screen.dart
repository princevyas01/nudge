import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../application/controllers/folder_controller.dart';
import '../../application/controllers/record_controller.dart';
import '../../domain/entities/record.dart';
import '../../domain/enums/todo_enums.dart';
import '../../presentation/components/nudge_card.dart';
import '../../presentation/theme/nudge_theme.dart';
import '../todos/todo_editor_screen.dart';
import 'record_editor_screen.dart';

class RecordDetailScreen extends StatelessWidget {
  final String recordId;

  const RecordDetailScreen({super.key, required this.recordId});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final recordCtrl = context.watch<RecordController>();
    final folderCtrl = context.watch<FolderController>();

    final record = recordCtrl.records.firstWhere(
      (r) => r.id == recordId,
      orElse: () => Record(id: recordId, title: 'Not found', content: ''),
    );

    if (record.title == 'Not found') {
      return Scaffold(
        appBar: AppBar(title: const Text('Record Detail')),
        body: const Center(child: Text('Record not found or was deleted.')),
      );
    }

    final folder = record.folderId != null ? folderCtrl.getFolderById(record.folderId) : null;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Record Details'),
        actions: [
          IconButton(
            icon: Icon(record.isPinned ? Icons.push_pin : Icons.push_pin_outlined),
            tooltip: record.isPinned ? 'Unpin' : 'Pin to top',
            onPressed: () => recordCtrl.togglePin(record.id),
          ),
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            tooltip: 'Edit Record',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => RecordEditorScreen(record: record),
                ),
              );
            },
          ),
          PopupMenuButton<String>(
            onSelected: (val) {
              if (val == 'archive') {
                recordCtrl.toggleArchive(record.id);
                Navigator.pop(context);
              } else if (val == 'delete') {
                recordCtrl.softDeleteRecord(record.id);
                Navigator.pop(context);
              }
            },
            itemBuilder: (ctx) => [
              PopupMenuItem(
                value: 'archive',
                child: Row(
                  children: [
                    Icon(record.isArchived ? Icons.unarchive_outlined : Icons.archive_outlined, size: 18),
                    const SizedBox(width: 8),
                    Text(record.isArchived ? 'Unarchive' : 'Archive'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'delete',
                child: Row(
                  children: [
                    Icon(Icons.delete_outline, size: 18, color: Colors.red),
                    SizedBox(width: 8),
                    Text('Delete Record', style: TextStyle(color: Colors.red)),
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
          // Header Card with Title and Badges
          NudgeCard(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _buildTypeBadge(context, record.recordType),
                      const SizedBox(width: 8),
                      if (folder != null)
                        Row(
                          children: [
                            Icon(NudgeTheme.getFolderIcon(folder), size: 14, color: theme.colorScheme.primary),
                            const SizedBox(width: 4),
                            Text(folder.name, style: theme.textTheme.labelMedium),
                          ],
                        ),
                      const Spacer(),
                      Text(
                        DateFormat('MMM d, yyyy · h:mm a').format(record.occurredAt ?? record.createdAt),
                        style: theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.outline),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  SelectableText(
                    record.title,
                    style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Content
          if (record.content.trim().isNotEmpty) ...[
            NudgeCard(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: SelectableText(
                  record.content.trim(),
                  style: theme.textTheme.bodyLarge?.copyWith(height: 1.6),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],

          // Turn into Todo Action Card
          NudgeCard(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => TodoEditorScreen(
                    initialTitle: record.title,
                    initialDescription: record.content,
                    initialFolderId: record.folderId,
                    initialSourceRecordId: record.id,
                  ),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(Icons.add_task, color: theme.colorScheme.onPrimaryContainer),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Turn into Task (Todo)', style: theme.textTheme.titleSmall),
                        const SizedBox(height: 2),
                        Text(
                          'Convert this note into an actionable task with due date & subtasks',
                          style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.outline),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.chevron_right),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypeBadge(BuildContext context, RecordType type) {
    Color color;
    String label;
    IconData icon;

    switch (type) {
      case RecordType.idea:
        color = Colors.amber.shade700;
        label = 'Idea';
        icon = Icons.lightbulb_outline;
        break;
      case RecordType.thought:
        color = Colors.purple;
        label = 'Thought';
        icon = Icons.psychology_outlined;
        break;
      case RecordType.log:
        color = Colors.teal;
        label = 'Log';
        icon = Icons.list_alt_outlined;
        break;
      case RecordType.snippet:
        color = Colors.blue;
        label = 'Snippet';
        icon = Icons.code;
        break;
      case RecordType.decision:
        color = Colors.deepOrange;
        label = 'Decision';
        icon = Icons.gavel_outlined;
        break;
      case RecordType.note:
      default:
        color = Colors.indigo;
        label = 'Note';
        icon = Icons.edit_note;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
