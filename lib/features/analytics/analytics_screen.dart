import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../application/controllers/reminder_controller.dart';
import '../../application/controllers/folder_controller.dart';
import '../../domain/services/stats_calculator.dart';
import '../../domain/services/smart_suggestion_engine.dart';
import '../../domain/entities/smart_suggestion.dart';
import '../../presentation/components/nudge_card.dart';
import '../../presentation/components/empty_state_widget.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  StatsData? _stats;
  List<SmartSuggestion> _suggestions = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    final reminderCtrl = context.read<ReminderController>();
    final stats = await reminderCtrl.getStats();
    final suggestions = SmartSuggestionEngine.generateSuggestions(reminderCtrl.reminders);

    if (mounted) {
      setState(() {
        _stats = stats;
        _suggestions = suggestions;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final folderCtrl = context.watch<FolderController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Productivity Analytics'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadData,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _stats == null || _stats!.totalReminders == 0
              ? const EmptyStateWidget(
                  icon: Icons.bar_chart_outlined,
                  title: 'No Data Yet',
                  description: 'Create and complete reminders to unlock insights into your productive rhythm.',
                )
              : RefreshIndicator(
                  onRefresh: _loadData,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Completion Rate Hero Card
                        NudgeCard(
                          color: theme.colorScheme.primaryContainer.withOpacity(0.4),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Completion Rate',
                                    style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '${_stats!.completionPercentage.toStringAsFixed(1)}%',
                                    style: theme.textTheme.headlineMedium?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: theme.colorScheme.primary,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: LinearProgressIndicator(
                                  value: _stats!.completionPercentage / 100.0,
                                  minHeight: 10,
                                  backgroundColor: theme.colorScheme.surfaceContainerHighest,
                                  valueColor: AlwaysStoppedAnimation(theme.colorScheme.primary),
                                ),
                              ),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  _buildStatItem('Completed', '${_stats!.completedReminders}', theme.colorScheme.primary),
                                  _buildStatItem('Overdue', '${_stats!.overdueReminders}', theme.colorScheme.error),
                                  _buildStatItem('Archived', '${_stats!.archivedReminders}', theme.colorScheme.outline),
                                  _buildStatItem('Total', '${_stats!.totalReminders}', theme.colorScheme.onSurface),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Insights Grid
                        Row(
                          children: [
                            Expanded(
                              child: NudgeCard(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(Icons.wb_sunny_outlined, color: theme.colorScheme.secondary, size: 24),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Peak Window',
                                      style: theme.textTheme.labelMedium?.copyWith(color: theme.colorScheme.outline),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      _stats!.productiveTimeWindow,
                                      style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: NudgeCard(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(Icons.snooze_outlined, color: theme.colorScheme.tertiary, size: 24),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Avg Snoozes',
                                      style: theme.textTheme.labelMedium?.copyWith(color: theme.colorScheme.outline),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '${_stats!.averageSnoozeFrequency.toStringAsFixed(1)} / task',
                                      style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // 7-Day Completion Trend
                        Text(
                          '7-Day Completion Trend',
                          style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        NudgeCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Tasks checked off over the past week',
                                style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.outline),
                              ),
                              const SizedBox(height: 20),
                              SizedBox(
                                height: 140,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: List.generate(7, (index) {
                                    final count = _stats!.sevenDayCompletionTrend[index];
                                    final maxTrend = _stats!.sevenDayCompletionTrend.reduce((a, b) => a > b ? a : b);
                                    final normalizedHeight = maxTrend > 0 ? (count / maxTrend) * 90 : 4.0;
                                    final dayLabel = DateFormat('E').format(
                                      DateTime.now().subtract(Duration(days: 6 - index)),
                                    );

                                    return Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          '$count',
                                          style: theme.textTheme.labelSmall?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: count > 0 ? theme.colorScheme.primary : theme.colorScheme.outline,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Container(
                                          width: 22,
                                          height: normalizedHeight.clamp(6.0, 90.0),
                                          decoration: BoxDecoration(
                                            color: count > 0 ? theme.colorScheme.primary : theme.colorScheme.surfaceContainerHighest,
                                            borderRadius: BorderRadius.circular(6),
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          dayLabel,
                                          style: theme.textTheme.labelSmall?.copyWith(
                                            color: theme.colorScheme.outline,
                                          ),
                                        ),
                                      ],
                                    );
                                  }),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Most Missed Category Warning if exists
                        if (_stats!.mostMissedFolderId != null) ...[
                          Builder(builder: (context) {
                            final folder = folderCtrl.folders.firstWhere(
                              (f) => f.id == _stats!.mostMissedFolderId,
                              orElse: () => folderCtrl.folders.first,
                            );
                            return NudgeCard(
                              color: theme.colorScheme.errorContainer.withOpacity(0.3),
                              child: Row(
                                children: [
                                  Icon(Icons.warning_amber_rounded, color: theme.colorScheme.error, size: 28),
                                  const SizedBox(width: 14),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Attention Area',
                                          style: theme.textTheme.titleSmall?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: theme.colorScheme.error,
                                          ),
                                        ),
                                        Text(
                                          'Reminders in "${folder.name}" have the highest overdue rate. Consider adjusting their timings or batching them together.',
                                          style: theme.textTheme.bodySmall,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                          const SizedBox(height: 20),
                        ],

                        // Smart Suggestions
                        if (_suggestions.isNotEmpty) ...[
                          Text(
                            'Smart Suggestions',
                            style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          ..._suggestions.map((suggestion) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: NudgeCard(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(Icons.lightbulb_outline, color: theme.colorScheme.primary, size: 24),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            suggestion.title,
                                            style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            suggestion.description,
                                            style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                        ],
                      ],
                    ),
                  ),
                ),
    );
  }

  Widget _buildStatItem(String label, String value, Color valueColor) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: valueColor,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: Theme.of(context).colorScheme.outline,
          ),
        ),
      ],
    );
  }
}
