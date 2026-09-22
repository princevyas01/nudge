import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../application/controllers/folder_controller.dart';
import '../../application/controllers/record_controller.dart';
import '../../application/controllers/reminder_controller.dart';
import '../../application/controllers/todo_controller.dart';
import '../../presentation/components/empty_state_widget.dart';
import '../../presentation/theme/nudge_theme.dart';
import '../home/reminder_card.dart';
import '../records/record_card.dart';
import '../todos/todo_card.dart';

enum SearchCategory {
  all,
  reminders,
  todos,
  records,
}

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String? _selectedFolderId;
  SearchCategory _selectedCategory = SearchCategory.all;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final reminderController = context.watch<ReminderController>();
    final todoController = context.watch<TodoController>();
    final recordController = context.watch<RecordController>();
    final folderController = context.watch<FolderController>();

    final query = _searchController.text.trim().toLowerCase();

    // 1. Matched Reminders
    final matchedReminders = reminderController.reminders.where((r) {
      if (r.isArchived) return false;
      if (_selectedFolderId != null && r.folderId != _selectedFolderId) return false;
      if (query.isEmpty) return true;

      final matchMsg = r.message.toLowerCase().contains(query);
      final folder = folderController.getFolderById(r.folderId);
      final matchFolder = folder?.name.toLowerCase().contains(query) ?? false;
      return matchMsg || matchFolder;
    }).toList();

    // 2. Matched Todos
    final matchedTodos = todoController.todos.where((t) {
      if (t.isDeleted || t.isArchived) return false;
      if (_selectedFolderId != null && t.folderId != _selectedFolderId) return false;
      if (query.isEmpty) return true;

      final matchTitle = t.title.toLowerCase().contains(query);
      final matchDesc = t.description?.toLowerCase().contains(query) ?? false;
      final matchTag = t.tags.any((tag) => tag.toLowerCase().contains(query));
      final folder = folderController.getFolderById(t.folderId);
      final matchFolder = folder?.name.toLowerCase().contains(query) ?? false;
      return matchTitle || matchDesc || matchTag || matchFolder;
    }).toList();

    // 3. Matched Records
    final matchedRecords = recordController.records.where((r) {
      if (r.isDeleted || r.isArchived) return false;
      if (_selectedFolderId != null && r.folderId != _selectedFolderId) return false;
      if (query.isEmpty) return true;

      final matchTitle = r.title.toLowerCase().contains(query);
      final matchContent = r.content.toLowerCase().contains(query);
      final folder = folderController.getFolderById(r.folderId);
      final matchFolder = folder?.name.toLowerCase().contains(query) ?? false;
      return matchTitle || matchContent || matchFolder;
    }).toList();

    final hasAnyResults = matchedReminders.isNotEmpty || matchedTodos.isNotEmpty || matchedRecords.isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          autofocus: true,
          style: TextStyle(color: isDark ? NudgeTheme.onBgDark : NudgeTheme.onBgLight),
          decoration: InputDecoration(
            hintText: 'Search reminders, tasks, & records...',
            hintStyle: TextStyle(color: Colors.grey[500]),
            border: InputBorder.none,
            prefixIcon: const Icon(Icons.search),
            suffixIcon: _searchController.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _searchController.clear();
                      setState(() {});
                    },
                  )
                : null,
          ),
          onChanged: (_) => setState(() {}),
        ),
      ),
      body: Column(
        children: [
          // Category Chips (All, Reminders, Tasks, Records)
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Row(
              children: [
                _buildCategoryChip('All (${matchedReminders.length + matchedTodos.length + matchedRecords.length})', SearchCategory.all),
                const SizedBox(width: 8),
                _buildCategoryChip('Reminders (${matchedReminders.length})', SearchCategory.reminders),
                const SizedBox(width: 8),
                _buildCategoryChip('Tasks (${matchedTodos.length})', SearchCategory.todos),
                const SizedBox(width: 8),
                _buildCategoryChip('Records (${matchedRecords.length})', SearchCategory.records),
              ],
            ),
          ),

          // Folder Filter Chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Row(
              children: [
                ChoiceChip(
                  label: const Text('All Folders'),
                  selected: _selectedFolderId == null,
                  onSelected: (selected) {
                    if (selected) setState(() => _selectedFolderId = null);
                  },
                ),
                const SizedBox(width: 8),
                ...folderController.folders.map((f) {
                  final isSelected = _selectedFolderId == f.id;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ChoiceChip(
                      avatar: Icon(NudgeTheme.getFolderIcon(f), size: 14),
                      label: Text(f.name),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() => _selectedFolderId = selected ? f.id : null);
                      },
                    ),
                  );
                }),
              ],
            ),
          ),
          const Divider(height: 1),

          // Results List
          Expanded(
            child: !hasAnyResults
                ? EmptyStateWidget(
                    icon: Icons.search_off,
                    title: 'No Matches Found',
                    subtitle: query.isEmpty
                        ? 'Type in the search bar above to look up items'
                        : 'No items found matching "$query"',
                  )
                : ListView(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    children: [
                      // Reminders Section
                      if ((_selectedCategory == SearchCategory.all || _selectedCategory == SearchCategory.reminders) &&
                          matchedReminders.isNotEmpty) ...[
                        _buildSectionHeader(context, 'Reminders', matchedReminders.length, Icons.alarm),
                        ...matchedReminders.map((r) => ReminderCard(reminder: r)),
                        const SizedBox(height: 12),
                      ],

                      // Todos Section
                      if ((_selectedCategory == SearchCategory.all || _selectedCategory == SearchCategory.todos) &&
                          matchedTodos.isNotEmpty) ...[
                        _buildSectionHeader(context, 'Tasks & Todos', matchedTodos.length, Icons.task_alt),
                        ...matchedTodos.map((t) => TodoCard(todo: t)),
                        const SizedBox(height: 12),
                      ],

                      // Records Section
                      if ((_selectedCategory == SearchCategory.all || _selectedCategory == SearchCategory.records) &&
                          matchedRecords.isNotEmpty) ...[
                        _buildSectionHeader(context, 'Records & Notes', matchedRecords.length, Icons.note_alt_outlined),
                        ...matchedRecords.map((r) => RecordCard(record: r)),
                        const SizedBox(height: 12),
                      ],
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(String label, SearchCategory category) {
    return ChoiceChip(
      label: Text(label),
      selected: _selectedCategory == category,
      onSelected: (selected) {
        if (selected) setState(() => _selectedCategory = category);
      },
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title, int count, IconData icon) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
      child: Row(
        children: [
          Icon(icon, size: 16, color: theme.colorScheme.primary),
          const SizedBox(width: 8),
          Text(
            '$title ($count)',
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
