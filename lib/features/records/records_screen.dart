import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../application/controllers/folder_controller.dart';
import '../../application/controllers/record_controller.dart';
import '../../domain/enums/todo_enums.dart';
import '../../presentation/components/empty_state_widget.dart';
import '../../presentation/theme/nudge_theme.dart';
import 'record_card.dart';
import 'record_editor_screen.dart';

class RecordsScreen extends StatefulWidget {
  final String? initialFolderId;

  const RecordsScreen({super.key, this.initialFolderId});

  @override
  State<RecordsScreen> createState() => _RecordsScreenState();
}

class _RecordsScreenState extends State<RecordsScreen> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _quickCaptureController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final ctrl = context.read<RecordController>();
      if (widget.initialFolderId != null) {
        ctrl.setFolder(widget.initialFolderId);
      }
      ctrl.loadRecords();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _quickCaptureController.dispose();
    super.dispose();
  }

  void _handleQuickCapture() {
    final text = _quickCaptureController.text.trim();
    if (text.isEmpty) return;

    final recordCtrl = context.read<RecordController>();
    recordCtrl.quickCapture(
      text,
      type: RecordType.note,
      folderId: recordCtrl.selectedFolderId ?? widget.initialFolderId,
    );
    _quickCaptureController.clear();
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final recordCtrl = context.watch<RecordController>();
    final folderCtrl = context.watch<FolderController>();

    final filteredRecords = recordCtrl.filteredRecords;
    final isTrash = recordCtrl.activeFilter == RecordFilter.trash;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Records & Capture'),
        actions: [
          if (isTrash)
            IconButton(
              icon: const Icon(Icons.delete_forever, color: Colors.red),
              tooltip: 'Empty Trash',
              onPressed: () async {
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Empty Trash?'),
                    content: const Text('This will permanently delete all records in the trash.'),
                    actions: [
                      TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
                      FilledButton(
                        style: FilledButton.styleFrom(backgroundColor: Colors.red),
                        onPressed: () => Navigator.pop(ctx, true),
                        child: const Text('Delete Permanently'),
                      ),
                    ],
                  ),
                );
                if (confirm == true) {
                  await recordCtrl.purgeTrash();
                }
              },
            ),
        ],
      ),
      body: Column(
        children: [
          // Quick Capture Box
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _quickCaptureController,
                    decoration: InputDecoration(
                      hintText: 'Quick capture a thought, idea, or note...',
                      prefixIcon: const Icon(Icons.flash_on, color: Colors.amber),
                      isDense: true,
                      filled: true,
                      fillColor: theme.colorScheme.surfaceContainerHighest.withOpacity(0.5),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onSubmitted: (_) => _handleQuickCapture(),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton.filledTonal(
                  icon: const Icon(Icons.send, size: 18),
                  tooltip: 'Save Record',
                  onPressed: _handleQuickCapture,
                ),
              ],
            ),
          ),

          // Search Filter Input
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search records...',
                prefixIcon: const Icon(Icons.search, size: 20),
                isDense: true,
                border: InputBorder.none,
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, size: 18),
                        onPressed: () {
                          _searchController.clear();
                          recordCtrl.setSearchQuery('');
                        },
                      )
                    : null,
              ),
              onChanged: (val) => recordCtrl.setSearchQuery(val),
            ),
          ),

          // Type Filter Chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Row(
              children: [
                _buildTypeChip('All (${recordCtrl.totalActiveCount})', RecordFilter.all, recordCtrl),
                const SizedBox(width: 8),
                _buildTypeChip('📝 Notes', RecordFilter.notes, recordCtrl),
                const SizedBox(width: 8),
                _buildTypeChip('💡 Ideas', RecordFilter.ideas, recordCtrl),
                const SizedBox(width: 8),
                _buildTypeChip('🧠 Thoughts', RecordFilter.thoughts, recordCtrl),
                const SizedBox(width: 8),
                _buildTypeChip('📋 Logs', RecordFilter.logs, recordCtrl),
                const SizedBox(width: 8),
                _buildTypeChip('💻 Snippets', RecordFilter.snippets, recordCtrl),
                const SizedBox(width: 8),
                _buildTypeChip('⚖️ Decisions', RecordFilter.decisions, recordCtrl),
                const SizedBox(width: 8),
                _buildTypeChip('Archived', RecordFilter.archived, recordCtrl),
                const SizedBox(width: 8),
                _buildTypeChip('Trash', RecordFilter.trash, recordCtrl),
              ],
            ),
          ),

          // Folder Filter Chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
            child: Row(
              children: [
                ChoiceChip(
                  label: const Text('All Folders'),
                  selected: recordCtrl.selectedFolderId == null,
                  onSelected: (selected) {
                    if (selected) recordCtrl.setFolder(null);
                  },
                ),
                const SizedBox(width: 8),
                ...folderCtrl.folders.map((f) {
                  final isSelected = recordCtrl.selectedFolderId == f.id;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      avatar: Icon(NudgeTheme.getFolderIcon(f), size: 14),
                      label: Text(f.name),
                      selected: isSelected,
                      onSelected: (selected) {
                        recordCtrl.setFolder(selected ? f.id : null);
                      },
                    ),
                  );
                }),
              ],
            ),
          ),

          const Divider(height: 12),

          // Record List
          Expanded(
            child: filteredRecords.isEmpty
                ? EmptyStateWidget(
                    icon: Icons.note_alt_outlined,
                    title: isTrash ? 'Trash is Empty' : 'No Records Found',
                    subtitle: isTrash
                        ? 'Deleted records will appear here'
                        : 'Capture thoughts, notes, or ideas quickly above',
                  )
                : ListView.builder(
                    padding: const EdgeInsets.only(bottom: 80, top: 4),
                    itemCount: filteredRecords.length,
                    itemBuilder: (ctx, index) {
                      return RecordCard(record: filteredRecords[index]);
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => RecordEditorScreen(
                initialFolderId: recordCtrl.selectedFolderId ?? widget.initialFolderId,
              ),
            ),
          );
        },
        icon: const Icon(Icons.edit_note),
        label: const Text('New Record'),
      ),
    );
  }

  Widget _buildTypeChip(String label, RecordFilter filter, RecordController ctrl) {
    final isSelected = ctrl.activeFilter == filter;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (val) {
        if (val) ctrl.setFilter(filter);
      },
    );
  }
}
