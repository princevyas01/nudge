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
import 'record_detail_screen.dart';
import 'record_editor_screen.dart';

class RecordCard extends StatelessWidget {
  final Record record;

  const RecordCard({super.key, required this.record});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final recordCtrl = context.read<RecordController>();
    final folderCtrl = context.watch<FolderController>();
    final folder = record.folderId != null ? folderCtrl.getFolderById(record.folderId) : null;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: NudgeCard(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => RecordDetailScreen(recordId: record.id),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header: Type badge, pin, more menu
              Row(
                children: [
                  _buildTypeBadge(context, record.recordType),
                  const SizedBox(width: 8),
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
                  const Spacer(),
                  if (record.isPinned) ...[
                    Icon(Icons.push_pin, size: 14, color: theme.colorScheme.primary),
                    const SizedBox(width: 4),
                  ],
                  // Quick "Turn into Todo" button
                  IconButton(
                    icon: const Icon(Icons.add_task_outlined, size: 20),
                    tooltip: 'Turn into Task',
                    onPressed: () {
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
                  ),
                  PopupMenuButton<String>(
                    icon: Icon(Icons.more_vert, size: 20, color: theme.colorScheme.outline),
                    onSelected: (val) {
                      switch (val) {
                        case 'pin':
                          recordCtrl.togglePin(record.id);
                          break;
                        case 'edit':
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => RecordEditorScreen(record: record),
                            ),
                          );
                          break;
                        case 'archive':
                          recordCtrl.toggleArchive(record.id);
                          break;
                        case 'delete':
                          recordCtrl.softDeleteRecord(record.id);
                          break;
                      }
                    },
                    itemBuilder: (ctx) => [
                      PopupMenuItem(
                        value: 'pin',
                        child: Row(
                          children: [
                            Icon(record.isPinned ? Icons.push_pin_outlined : Icons.push_pin, size: 18),
                            const SizedBox(width: 8),
                            Text(record.isPinned ? 'Unpin' : 'Pin to top'),
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
                            Text('Delete', style: TextStyle(color: Colors.red)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Title
              Text(
                record.title,
                style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),

              // Content snippet
              if (record.content.trim().isNotEmpty && record.content.trim() != record.title.trim()) ...[
                const SizedBox(height: 4),
                Text(
                  record.content.trim(),
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    height: 1.4,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],

              const SizedBox(height: 8),
              // Footer: Date
              Text(
                DateFormat('MMM d, yyyy · h:mm a').format(record.occurredAt ?? record.createdAt),
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.outline,
                ),
              ),
            ],
          ),
        ),
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
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withOpacity(0.25), width: 0.5),
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
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
