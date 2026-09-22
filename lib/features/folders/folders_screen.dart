import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../application/controllers/folder_controller.dart';
import '../../application/controllers/reminder_controller.dart';
import '../../domain/entities/folder.dart';
import '../../presentation/components/empty_state_widget.dart';
import '../../presentation/theme/nudge_theme.dart';
import 'folder_detail_screen.dart';

class FoldersScreen extends StatelessWidget {
  const FoldersScreen({super.key});

  void _showFolderDialog(BuildContext context, {Folder? folderToEdit}) {
    final isEditing = folderToEdit != null;
    final nameController = TextEditingController(text: folderToEdit?.name ?? '');
    String selectedIcon = folderToEdit?.iconId ?? 'folder';
    String selectedColor = folderToEdit?.colorTag ?? '#006A60';

    final availableIcons = [
      'folder', 'work', 'home', 'school', 'shopping_cart',
      'local_hospital', 'receipt', 'flight', 'movie', 'star'
    ];

    final availableColors = [
      '#006A60', '#BA1A1A', '#6750A4', '#E28743',
      '#2E7D32', '#00796B', '#1976D2', '#C2185B'
    ];

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text(isEditing ? 'Edit Folder' : 'New Folder'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: nameController,
                  autofocus: true,
                  decoration: const InputDecoration(
                    labelText: 'Folder Name',
                    hintText: 'e.g. Health, Finance, University',
                  ),
                ),
                const SizedBox(height: 16),
                const Text('Choose Icon', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: availableIcons.map((iconId) {
                    final isSelected = selectedIcon == iconId;
                    return IconButton.filledTonal(
                      style: IconButton.styleFrom(
                        backgroundColor: isSelected ? NudgeTheme.primaryContainer : null,
                      ),
                      icon: Icon(
                        NudgeTheme.getIconDataForId(iconId),
                        color: isSelected ? Colors.white : null,
                      ),
                      onPressed: () => setDialogState(() => selectedIcon = iconId),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
                const Text('Choose Color', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: availableColors.map((hex) {
                    final color = Color(int.parse(hex.replaceFirst('#', '0xFF')));
                    final isSelected = selectedColor == hex;
                    return GestureDetector(
                      onTap: () => setDialogState(() => selectedColor = hex),
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle,
                          border: isSelected ? Border.all(color: Colors.white, width: 3) : null,
                          boxShadow: isSelected ? [const BoxShadow(color: Colors.black26, blurRadius: 4)] : null,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                final name = nameController.text.trim();
                if (name.isEmpty) return;

                final folderController = context.read<FolderController>();
                if (isEditing) {
                  folderController.updateFolder(folderToEdit.copyWith(
                    name: name,
                    iconId: selectedIcon,
                    colorTag: selectedColor,
                  ));
                } else {
                  folderController.createFolder(Folder(
                    name: name,
                    iconId: selectedIcon,
                    colorTag: selectedColor,
                  ));
                }
                Navigator.pop(ctx);
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteFolderDialog(BuildContext context, Folder folder) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Delete "${folder.name}"?'),
        content: const Text(
          'What would you like to do with the reminders in this folder?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context.read<FolderController>().deleteFolder(folder.id, deleteContainedReminders: false);
              context.read<ReminderController>().loadReminders();
              Navigator.pop(ctx);
            },
            child: const Text('Move to General'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: NudgeTheme.error),
            onPressed: () {
              context.read<FolderController>().deleteFolder(folder.id, deleteContainedReminders: true);
              context.read<ReminderController>().loadReminders();
              Navigator.pop(ctx);
            },
            child: const Text('Delete All Reminders'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final folderController = context.watch<FolderController>();
    final reminderController = context.watch<ReminderController>();

    final folders = folderController.folders;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Folders'),
      ),
      body: folders.isEmpty
          ? EmptyStateWidget(
              icon: Icons.folder_open,
              title: 'No Folders',
              subtitle: 'Organize your reminders into custom folders',
              actionLabel: 'Create Folder',
              onAction: () => _showFolderDialog(context),
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              itemCount: folders.length,
              itemBuilder: (context, index) {
                final folder = folders[index];
                final count = reminderController.reminders.where((r) => r.folderId == folder.id && !r.isArchived).length;
                final color = NudgeTheme.getFolderColor(folder, isDark);

                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(NudgeTheme.radiusL),
                    side: BorderSide(color: isDark ? NudgeTheme.cardBorderDark : NudgeTheme.cardBorderLight),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => FolderDetailScreen(folder: folder),
                        ),
                      );
                    },
                    leading: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(NudgeTheme.getFolderIcon(folder), color: color),
                    ),
                    title: Text(
                      folder.name,
                      style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                    ),
                    subtitle: Text('$count active reminders'),
                    trailing: PopupMenuButton<String>(
                      onSelected: (val) {
                        if (val == 'edit') {
                          _showFolderDialog(context, folderToEdit: folder);
                        } else if (val == 'delete') {
                          _showDeleteFolderDialog(context, folder);
                        }
                      },
                      itemBuilder: (ctx) => [
                        const PopupMenuItem(value: 'edit', child: Text('Edit')),
                        const PopupMenuItem(
                          value: 'delete',
                          child: Text('Delete', style: TextStyle(color: NudgeTheme.error)),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showFolderDialog(context),
        tooltip: 'Create new folder',
        child: const Icon(Icons.add),
      ),
    );
  }
}
