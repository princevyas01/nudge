import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../application/controllers/reminder_controller.dart';
import '../../application/controllers/folder_controller.dart';
import '../../application/controllers/companion_controller.dart';
import '../../application/controllers/theme_controller.dart';
import '../../application/controllers/reliability_controller.dart';
import '../../application/controllers/todo_controller.dart';
import '../../application/controllers/record_controller.dart';
import '../../domain/enums/enums.dart';
import '../../presentation/components/mascot_widget.dart';
import '../../presentation/components/nudge_card.dart';
import '../../presentation/components/empty_state_widget.dart';
import '../../presentation/components/quick_add_sheet.dart';
import '../calendar/calendar_screen.dart';
import '../timer/timer_screen.dart';
import '../analytics/analytics_screen.dart';
import '../settings/settings_screen.dart';
import '../settings/custom_alarm_sound_screen.dart';
import '../folders/folders_screen.dart';
import '../search/search_screen.dart';
import '../companion/customize_companion_screen.dart';
import '../reliability/improve_reliability_screen.dart';
import '../todos/todos_screen.dart';
import '../records/records_screen.dart';
import '../records/record_editor_screen.dart';
import 'reminder_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  int _currentNavIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ReminderController>().loadReminders();
      context.read<FolderController>().loadFolders();
      context.read<ReliabilityController>().refreshStatuses();
      context.read<TodoController>().loadTodos();
      context.read<RecordController>().loadRecords();
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      context.read<ReliabilityController>().refreshStatuses();
      context.read<ReminderController>().checkExactAlarmCapability();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentNavIndex,
        children: [
          _buildHomeTab(context),
          const CalendarScreen(),
          const TimerScreen(),
          const CustomAlarmSoundScreen(),
          const AnalyticsScreen(),
          const SettingsScreen(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentNavIndex,
        onDestinationSelected: (index) {
          setState(() => _currentNavIndex = index);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.alarm_outlined),
            selectedIcon: Icon(Icons.alarm),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.calendar_month_outlined),
            selectedIcon: Icon(Icons.calendar_month),
            label: 'Calendar',
          ),
          NavigationDestination(
            icon: Icon(Icons.timer_outlined),
            selectedIcon: Icon(Icons.timer),
            label: 'Timer',
          ),
          NavigationDestination(
            icon: Icon(Icons.graphic_eq_outlined),
            selectedIcon: Icon(Icons.graphic_eq),
            label: 'Sound',
          ),
          NavigationDestination(
            icon: Icon(Icons.insights_outlined),
            selectedIcon: Icon(Icons.insights),
            label: 'Analytics',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
      floatingActionButton: _currentNavIndex == 0
          ? FloatingActionButton(
              onPressed: () {
                QuickAddSheet.show(
                  context,
                  onOpenTimer: () => setState(() => _currentNavIndex = 2),
                );
              },
              tooltip: 'Quick Add',
              child: const Icon(Icons.add),
            )
          : null,
    );
  }

  Widget _buildHomeTab(BuildContext context) {
    final theme = Theme.of(context);
    final reminderCtrl = context.watch<ReminderController>();
    final folderCtrl = context.watch<FolderController>();
    final companionCtrl = context.watch<CompanionController>();
    final todoCtrl = context.watch<TodoController>();
    final recordCtrl = context.watch<RecordController>();

    final allReminders = reminderCtrl.reminders;
    final overdueCount = allReminders.where((r) => r.isOverdue).length;
    final todayCount = allReminders.where((r) => !r.isArchived && _isToday(r.scheduledAt)).length;
    final todayDoneCount = allReminders.where((r) => _isToday(r.scheduledAt) && r.isDone).length;

    // Next Up Reminder
    final upcomingList = allReminders
        .where((r) => !r.isDone && !r.isArchived && r.scheduledAt.isAfter(DateTime.now()))
        .toList()
      ..sort((a, b) => a.scheduledAt.compareTo(b.scheduledAt));
    final nextUpReminder = upcomingList.isNotEmpty ? upcomingList.first : null;

    // Filtered list
    final filteredReminders = reminderCtrl.filteredReminders;

    return SafeArea(
      child: CustomScrollView(
        slivers: [
          // Header App Bar with Mascot, Greeting, and Action Icons
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      // Mascot Avatar
                      GestureDetector(
                        onTap: () {
                          companionCtrl.triggerTapReaction();
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('"${companionCtrl.currentDialogue}"'),
                              behavior: SnackBarBehavior.floating,
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        },
                        child: MascotWidget(
                          mood: companionCtrl.currentMood,
                          equippedCosmetic: companionCtrl.profile.equippedCosmetic,
                          size: 44,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _getGreeting(),
                              style: theme.textTheme.labelMedium?.copyWith(
                                color: theme.colorScheme.outline,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              companionCtrl.profile.name,
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      // Streak Pill
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const CustomizeCompanionScreen()),
                          );
                        },
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.errorContainer.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.local_fire_department, size: 16, color: theme.colorScheme.error),
                              const SizedBox(width: 3),
                              Text(
                                '${companionCtrl.profile.currentStreak}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: theme.colorScheme.error,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 2),
                      // Dark / Light Mode Toggle Logo Button
                      Consumer<ThemeController>(
                        builder: (context, themeCtrl, _) {
                          final isDark = themeCtrl.themeMode == ThemeMode.dark ||
                              (themeCtrl.themeMode == ThemeMode.system && theme.brightness == Brightness.dark);
                          return IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
                            visualDensity: VisualDensity.compact,
                            icon: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 300),
                              transitionBuilder: (child, anim) => RotationTransition(
                                turns: anim,
                                child: ScaleTransition(scale: anim, child: child),
                              ),
                              child: Icon(
                                isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                                key: ValueKey<bool>(isDark),
                                color: isDark ? Colors.amber : theme.colorScheme.primary,
                                size: 20,
                              ),
                            ),
                            tooltip: isDark ? 'Switch to Light Mode' : 'Switch to Dark Mode',
                            onPressed: () => themeCtrl.toggleTheme(),
                          );
                        },
                      ),
                      // Folder Screen
                      IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
                        visualDensity: VisualDensity.compact,
                        icon: const Icon(Icons.folder_outlined, size: 20),
                        tooltip: 'Folders',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const FoldersScreen()),
                          );
                        },
                      ),
                      // Search Screen
                      IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
                        visualDensity: VisualDensity.compact,
                        icon: const Icon(Icons.search, size: 20),
                        tooltip: 'Search',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const SearchScreen()),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Background & Alarm Permission Alert Banner
                  Consumer<ReliabilityController>(
                    builder: (context, rel, _) {
                      if (rel.notificationsEnabled &&
                          rel.exactAlarmsEnabled &&
                          rel.fullScreenIntentEnabled &&
                          rel.batteryOptimizationIgnored) {
                        return const SizedBox.shrink();
                      }
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => const ImproveReliabilityScreen()),
                            );
                          },
                          borderRadius: BorderRadius.circular(16),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                            decoration: BoxDecoration(
                              color: Colors.orange.withOpacity(0.12),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: Colors.orange.withOpacity(0.4)),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.shield_outlined, color: Colors.deepOrange, size: 24),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Allow Background & Alarm Access',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.deepOrange,
                                          fontSize: 13,
                                        ),
                                      ),
                                      Text(
                                        !rel.exactAlarmsEnabled
                                            ? 'Exact alarm permission needed to ring alarms on time.'
                                            : !rel.notificationsEnabled
                                                ? 'Notifications disabled. Tap to enable alarm alerts.'
                                                : !rel.fullScreenIntentEnabled
                                                    ? 'Full-screen alarm access needed for lock screen ringing.'
                                                    : 'Exempt Nudge from battery saver so it rings after close or reboot.',
                                        style: const TextStyle(fontSize: 11),
                                      ),
                                    ],
                                  ),
                                ),
                                const Icon(Icons.chevron_right, color: Colors.deepOrange, size: 20),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),

                  // Missed Reminders Recovery Banner
                  if (overdueCount > 0 && reminderCtrl.activeFilter != FilterType.overdue) ...[
                    InkWell(
                      onTap: () => reminderCtrl.setFilter(FilterType.overdue),
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.errorContainer.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: theme.colorScheme.error.withOpacity(0.3)),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.warning_amber_rounded, color: theme.colorScheme.error, size: 24),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '$overdueCount Overdue ${overdueCount == 1 ? "Reminder" : "Reminders"}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: theme.colorScheme.error,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const Text(
                                    'Tap to review, complete, or reschedule.',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                            Icon(Icons.chevron_right, color: theme.colorScheme.error),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],

                  // Overview Cards Row
                  Row(
                    children: [
                      Expanded(
                        child: NudgeCard(
                          padding: const EdgeInsets.all(14),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Today',
                                style: theme.textTheme.labelMedium?.copyWith(color: theme.colorScheme.outline),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '$todayDoneCount/$todayCount',
                                style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 6),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: LinearProgressIndicator(
                                  value: todayCount > 0 ? (todayDoneCount / todayCount) : 0,
                                  minHeight: 4,
                                  backgroundColor: theme.colorScheme.surfaceContainerHighest,
                                  valueColor: AlwaysStoppedAnimation(theme.colorScheme.primary),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: NudgeCard(
                          padding: const EdgeInsets.all(14),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Upcoming',
                                style: theme.textTheme.labelMedium?.copyWith(color: theme.colorScheme.outline),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${upcomingList.length}',
                                style: theme.textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: theme.colorScheme.primary,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Next scheduled',
                                style: theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.outline),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Next Up Hero Card
                  if (nextUpReminder != null) ...[
                    const SizedBox(height: 16),
                    NudgeCard(
                      color: theme.colorScheme.primaryContainer.withOpacity(0.3),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.access_time_filled, size: 16, color: theme.colorScheme.primary),
                                  const SizedBox(width: 6),
                                  Text(
                                    'NEXT UP • ${_formatNextUpTime(nextUpReminder.scheduledAt)}',
                                    style: TextStyle(
                                      color: theme.colorScheme.primary,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ],
                              ),
                              Chip(
                                label: Text(nextUpReminder.priority.name.toUpperCase()),
                                visualDensity: VisualDensity.compact,
                                padding: EdgeInsets.zero,
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            nextUpReminder.message,
                            style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              FilledButton.tonalIcon(
                                onPressed: () {
                                  reminderCtrl.completeReminder(nextUpReminder.id);
                                  companionCtrl.triggerCelebration();
                                },
                                icon: const Icon(Icons.check, size: 18),
                                label: const Text('Done'),
                              ),
                              const SizedBox(width: 8),
                              OutlinedButton.icon(
                                onPressed: nextUpReminder.snoozeCount < 3
                                    ? () => reminderCtrl.snoozeReminder(nextUpReminder.id)
                                    : null,
                                icon: const Icon(Icons.snooze, size: 18),
                                label: const Text('+10m'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],

                  const SizedBox(height: 16),

                  // Productivity Hub (Tasks & Records Cards)
                  _buildProductivityHub(context, todoCtrl, recordCtrl),

                  const SizedBox(height: 16),

                  // Filter Chips Carousel
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildFilterChip(context, FilterType.all, 'All'),
                        _buildFilterChip(context, FilterType.today, 'Today'),
                        _buildFilterChip(context, FilterType.upcoming, 'Upcoming'),
                        _buildFilterChip(context, FilterType.overdue, 'Overdue'),
                        _buildFilterChip(context, FilterType.completed, 'Completed'),
                        _buildFilterChip(context, FilterType.archived, 'Archived'),
                      ],
                    ),
                  ),

                  // Priority and Folder filter pills
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      // Folder filter popup
                      PopupMenuButton<String?>(
                        initialValue: reminderCtrl.folderFilter,
                        tooltip: 'Filter by folder',
                        child: Chip(
                          avatar: const Icon(Icons.folder_outlined, size: 16),
                          label: Text(
                            reminderCtrl.folderFilter == null
                                ? 'Folder: All'
                                : folderCtrl.folders
                                    .firstWhere(
                                      (f) => f.id == reminderCtrl.folderFilter,
                                      orElse: () => folderCtrl.folders.first,
                                    )
                                    .name,
                          ),
                          deleteIcon: reminderCtrl.folderFilter != null ? const Icon(Icons.close, size: 14) : null,
                          onDeleted: reminderCtrl.folderFilter != null
                              ? () => reminderCtrl.setFolderFilter(null)
                              : null,
                        ),
                        onSelected: (folderId) => reminderCtrl.setFolderFilter(folderId),
                        itemBuilder: (ctx) => [
                          const PopupMenuItem(value: null, child: Text('All Folders')),
                          ...folderCtrl.folders.map(
                            (f) => PopupMenuItem(value: f.id, child: Text(f.name)),
                          ),
                        ],
                      ),
                      const SizedBox(width: 8),

                      // Priority filter popup
                      PopupMenuButton<PriorityLevel?>(
                        initialValue: reminderCtrl.priorityFilter,
                        tooltip: 'Filter by priority',
                        child: Chip(
                          avatar: const Icon(Icons.flag_outlined, size: 16),
                          label: Text(
                            reminderCtrl.priorityFilter == null
                                ? 'Priority: All'
                                : reminderCtrl.priorityFilter!.name.toUpperCase(),
                          ),
                          deleteIcon: reminderCtrl.priorityFilter != null ? const Icon(Icons.close, size: 14) : null,
                          onDeleted: reminderCtrl.priorityFilter != null
                              ? () => reminderCtrl.setPriorityFilter(null)
                              : null,
                        ),
                        onSelected: (p) => reminderCtrl.setPriorityFilter(p),
                        itemBuilder: (ctx) => const [
                          PopupMenuItem(value: null, child: Text('All Priorities')),
                          PopupMenuItem(value: PriorityLevel.high, child: Text('High')),
                          PopupMenuItem(value: PriorityLevel.normal, child: Text('Normal')),
                          PopupMenuItem(value: PriorityLevel.low, child: Text('Low')),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Reminder List / Empty State
          if (filteredReminders.isEmpty)
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 80),
                child: Center(
                  child: EmptyStateWidget(
                    icon: _getEmptyIcon(reminderCtrl.activeFilter),
                    title: _getEmptyTitle(reminderCtrl.activeFilter),
                    description: _getEmptyDescription(reminderCtrl.activeFilter),
                  ),
                ),
              ),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 80),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final reminder = filteredReminders[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: ReminderCard(reminder: reminder),
                    );
                  },
                  childCount: filteredReminders.length,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(BuildContext context, FilterType type, String label) {
    final reminderCtrl = context.watch<ReminderController>();
    final isSelected = reminderCtrl.activeFilter == type;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (_) => reminderCtrl.setFilter(type),
      ),
    );
  }

  bool _isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year && date.month == now.month && date.day == now.day;
  }

  String _formatNextUpTime(DateTime date) {
    final now = DateTime.now();
    final diff = date.difference(now);
    if (diff.inMinutes < 60) {
      return 'in ${diff.inMinutes}m';
    } else if (diff.inHours < 24) {
      return DateFormat('h:mm a').format(date);
    } else {
      return DateFormat('MMM d, h:mm a').format(date);
    }
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning,';
    if (hour < 17) return 'Good afternoon,';
    return 'Good evening,';
  }

  IconData _getEmptyIcon(FilterType filter) {
    switch (filter) {
      case FilterType.overdue:
        return Icons.task_alt;
      case FilterType.completed:
        return Icons.checklist;
      case FilterType.archived:
        return Icons.archive_outlined;
      default:
        return Icons.notifications_none;
    }
  }

  String _getEmptyTitle(FilterType filter) {
    switch (filter) {
      case FilterType.overdue:
        return 'No Overdue Reminders';
      case FilterType.today:
        return 'All Done for Today!';
      case FilterType.upcoming:
        return 'No Upcoming Reminders';
      case FilterType.completed:
        return 'No Completed Reminders Yet';
      case FilterType.archived:
        return 'Archive is Empty';
      default:
        return 'No Reminders Found';
    }
  }

  String _getEmptyDescription(FilterType filter) {
    switch (filter) {
      case FilterType.overdue:
        return 'Awesome job! You are completely up to date.';
      case FilterType.today:
        return 'Take a breather or plan something new for tomorrow.';
      case FilterType.upcoming:
        return 'Tap the + button to schedule your next task.';
      case FilterType.completed:
        return 'Check off your active reminders to see them here.';
      case FilterType.archived:
        return 'Old reminders you archive will be stored safely here.';
      default:
        return 'Tap the + button below to add your first nudge.';
    }
  }

  Widget _buildProductivityHub(
    BuildContext context,
    TodoController todoCtrl,
    RecordController recordCtrl,
  ) {
    final theme = Theme.of(context);
    final topTodos = todoCtrl.todos
        .where((t) => !t.isDeleted && !t.isArchived && !t.isDone)
        .take(2)
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Productivity Hub',
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const TodosScreen()),
                );
              },
              child: const Text('View All Tasks'),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            // Tasks Card
            Expanded(
              child: NudgeCard(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const TodosScreen()),
                  );
                },
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Icon(Icons.check_circle_outline, size: 16, color: Colors.blue),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Tasks',
                            style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        if (todoCtrl.overdueCount > 0)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                            decoration: BoxDecoration(
                              color: Colors.red.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              '${todoCtrl.overdueCount}!',
                              style: const TextStyle(fontSize: 10, color: Colors.red, fontWeight: FontWeight.bold),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${todoCtrl.activeCount} active tasks',
                      style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      '${todoCtrl.todayCount} due today',
                      style: theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.outline),
                    ),
                    if (topTodos.isNotEmpty) ...[
                      const Divider(height: 12),
                      ...topTodos.map(
                        (t) => InkWell(
                          onTap: () => todoCtrl.toggleTodoStatus(t.id),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2),
                            child: Row(
                              children: [
                                Icon(Icons.circle_outlined, size: 14, color: theme.colorScheme.outline),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    t.title,
                                    style: theme.textTheme.labelSmall,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            const SizedBox(width: 10),
            // Records Card
            Expanded(
              child: NudgeCard(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const RecordsScreen()),
                  );
                },
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.amber.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Icon(Icons.lightbulb_outline, size: 16, color: Colors.amber),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Capture',
                            style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        const Icon(Icons.chevron_right, size: 16),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${recordCtrl.totalActiveCount} records',
                      style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      'Notes, ideas & thoughts',
                      style: theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.outline),
                    ),
                    const SizedBox(height: 6),
                    OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        visualDensity: VisualDensity.compact,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const RecordEditorScreen()),
                        );
                      },
                      icon: const Icon(Icons.add, size: 14),
                      label: const Text('New Note', style: TextStyle(fontSize: 11)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
