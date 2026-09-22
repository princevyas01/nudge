import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../application/controllers/folder_controller.dart';
import '../../application/controllers/todo_controller.dart';
import '../../domain/enums/todo_enums.dart';
import '../../presentation/components/empty_state_widget.dart';
import '../../presentation/theme/nudge_theme.dart';
import 'todo_card.dart';
import 'todo_editor_screen.dart';

class TodosScreen extends StatefulWidget {
  final String? initialFolderId;

  const TodosScreen({super.key, this.initialFolderId});

  @override
  State<TodosScreen> createState() => _TodosScreenState();
}

class _TodosScreenState extends State<TodosScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final ctrl = context.read<TodoController>();
      if (widget.initialFolderId != null) {
        ctrl.setFolder(widget.initialFolderId);
      }
      ctrl.loadTodos();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final todoCtrl = context.watch<TodoController>();
    final folderCtrl = context.watch<FolderController>();

    final filteredTodos = todoCtrl.filteredTodos;
    final isTrash = todoCtrl.activeFilter == TodoFilter.trash;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks & Todos'),
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
                    content: const Text('This will permanently delete all tasks in the trash.'),
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
                  await todoCtrl.purgeTrash();
                }
              },
            ),
        ],
      ),
      body: Column(
        children: [
          // Search & Filter Bar
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search tasks...',
                prefixIcon: const Icon(Icons.search),
                isDense: true,
                filled: true,
                fillColor: theme.colorScheme.surfaceContainerHighest.withOpacity(0.5),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, size: 18),
                        onPressed: () {
                          _searchController.clear();
                          todoCtrl.setSearchQuery('');
                        },
                      )
                    : null,
              ),
              onChanged: (val) => todoCtrl.setSearchQuery(val),
            ),
          ),

          // Filter Chips (All, Today, Upcoming, High Priority, Completed, Archived, Trash)
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: Row(
              children: [
                _buildFilterChip('All (${todoCtrl.activeCount})', TodoFilter.all, todoCtrl),
                const SizedBox(width: 8),
                _buildFilterChip('Today (${todoCtrl.todayCount})', TodoFilter.today, todoCtrl),
                const SizedBox(width: 8),
                _buildFilterChip('Upcoming', TodoFilter.upcoming, todoCtrl),
                const SizedBox(width: 8),
                _buildFilterChip('High Priority', TodoFilter.highPriority, todoCtrl),
                const SizedBox(width: 8),
                _buildFilterChip('Completed (${todoCtrl.completedCount})', TodoFilter.completed, todoCtrl),
                const SizedBox(width: 8),
                _buildFilterChip('Archived', TodoFilter.archived, todoCtrl),
                const SizedBox(width: 8),
                _buildFilterChip('Trash', TodoFilter.trash, todoCtrl),
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
                  selected: todoCtrl.selectedFolderId == null,
                  onSelected: (selected) {
                    if (selected) todoCtrl.setFolder(null);
                  },
                ),
                const SizedBox(width: 8),
                ...folderCtrl.folders.map((f) {
                  final isSelected = todoCtrl.selectedFolderId == f.id;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      avatar: Icon(NudgeTheme.getFolderIcon(f), size: 14),
                      label: Text(f.name),
                      selected: isSelected,
                      onSelected: (selected) {
                        todoCtrl.setFolder(selected ? f.id : null);
                      },
                    ),
                  );
                }),
              ],
            ),
          ),

          const Divider(height: 12),

          // Task List
          Expanded(
            child: filteredTodos.isEmpty
                ? EmptyStateWidget(
                    icon: Icons.task_alt,
                    title: isTrash ? 'Trash is Empty' : 'No Tasks Found',
                    subtitle: isTrash
                        ? 'Deleted tasks will appear here'
                        : 'Tap the button below to add your first task',
                  )
                : ListView.builder(
                    padding: const EdgeInsets.only(bottom: 80, top: 4),
                    itemCount: filteredTodos.length,
                    itemBuilder: (ctx, index) {
                      return TodoCard(todo: filteredTodos[index]);
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
              builder: (_) => TodoEditorScreen(
                initialFolderId: todoCtrl.selectedFolderId ?? widget.initialFolderId,
              ),
            ),
          );
        },
        icon: const Icon(Icons.add_task),
        label: const Text('New Task'),
      ),
    );
  }

  Widget _buildFilterChip(String label, TodoFilter filter, TodoController ctrl) {
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
