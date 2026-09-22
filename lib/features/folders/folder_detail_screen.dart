import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../application/controllers/folder_controller.dart';
import '../../application/controllers/reminder_controller.dart';
import '../../domain/entities/folder.dart';
import '../../domain/entities/reminder.dart';
import '../../presentation/components/empty_state_widget.dart';
import '../../presentation/theme/nudge_theme.dart';
import '../home/reminder_card.dart';
import '../reminders/reminder_editor_screen.dart';

class FolderDetailScreen extends StatefulWidget {
  final Folder folder;

  const FolderDetailScreen({super.key, required this.folder});

  @override
  State<FolderDetailScreen> createState() => _FolderDetailScreenState();
}

class _FolderDetailScreenState extends State<FolderDetailScreen> {
  int _tabIndex = 0; // 0: Active, 1: All, 2: Completed

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final folderController = context.watch<FolderController>();
    final reminderController = context.watch<ReminderController>();

    final currentFolder = folderController.folders.firstWhere(
      (f) => f.id == widget.folder.id,
      orElse: () => widget.folder,
    );

    final color = NudgeTheme.getFolderColor(currentFolder, isDark);

    final folderReminders = reminderController.reminders
        .where((r) => r.folderId == currentFolder.id && !r.isArchived)
        .toList();

    List<Reminder> displayList;
    if (_tabIndex == 0) {
      displayList = folderReminders.where((r) => !r.isDone).toList();
    } else if (_tabIndex == 2) {
      displayList = folderReminders.where((r) => r.isDone).toList();
    } else {
      displayList = folderReminders;
    }

    displayList.sort((a, b) => a.scheduledAt.compareTo(b.scheduledAt));

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(NudgeTheme.getFolderIcon(currentFolder), color: color, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    currentFolder.name,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    ' active •  total',
                    style: theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.outline),
                  ),
                ],
              ),
            ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            alignment: Alignment.centerLeft,
            child: SegmentedButton<int>(
              segments: const [
                ButtonSegment(value: 0, label: Text('Active')),
                ButtonSegment(value: 1, label: Text('All')),
                ButtonSegment(value: 2, label: Text('Done')),
              ],
              selected: {_tabIndex},
              onSelectionChanged: (set) {
                setState(() => _tabIndex = set.first);
              },
              showSelectedIcon: false,
              style: const ButtonStyle(
                visualDensity: VisualDensity.compact,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
          ),
        ),
      ),
      body: displayList.isEmpty
          ? EmptyStateWidget(
              icon: NudgeTheme.getFolderIcon(currentFolder),
              title: _tabIndex == 2
                  ? 'No Completed Reminders'
                  : 'No Reminders in ""',
              subtitle: _tabIndex == 2
                  ? 'Completed tasks will appear here'
                  : 'Tap below to add a reminder to this folder',
              actionLabel: _tabIndex != 2 ? 'Add Reminder' : null,
              onAction: _tabIndex != 2
                  ? () => _openEditorForFolder(context, currentFolder.id)
                  : null,
            )
          : ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
              itemCount: displayList.length,
              itemBuilder: (context, index) {
                final reminder = displayList[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: ReminderCard(
                    reminder: reminder,
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openEditorForFolder(context, currentFolder.id),
        icon: const Icon(Icons.add),
        label: const Text('Add Reminder'),
        backgroundColor: color,
        foregroundColor: Colors.white,
      ),
    );
  }

  void _openEditorForFolder(BuildContext context, String folderId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ReminderEditorScreen(
          initialReminder: Reminder(
            folderId: folderId,
            message: '',
            scheduledAt: DateTime.now().add(const Duration(hours: 1)),
          ),
        ),
      ),
    );
  }
}
