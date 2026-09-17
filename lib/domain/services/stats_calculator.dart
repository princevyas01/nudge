import '../entities/reminder.dart';
import '../entities/reminder_occurrence.dart';
import '../entities/reminder_history.dart';
import '../enums/enums.dart';

class StatsData {
  final int totalReminders;
  final int totalOccurrences;
  final int completedReminders;
  final int overdueReminders;
  final int archivedReminders;
  final double completionPercentage;
  final int totalSnoozes;
  final double averageSnoozeFrequency;
  final String? mostMissedFolderId;
  final String productiveTimeWindow;
  final List<int> sevenDayCompletionTrend; // [day-6, day-5, ... today]
  final List<int> hourlyDistribution; // 24 bins

  const StatsData({
    required this.totalReminders,
    required this.totalOccurrences,
    required this.completedReminders,
    required this.overdueReminders,
    required this.archivedReminders,
    required this.completionPercentage,
    required this.totalSnoozes,
    required this.averageSnoozeFrequency,
    this.mostMissedFolderId,
    required this.productiveTimeWindow,
    required this.sevenDayCompletionTrend,
    required this.hourlyDistribution,
  });
}

class StatsCalculator {
  static StatsData calculate({
    required List<Reminder> reminders,
    required List<ReminderOccurrence> occurrences,
    required List<ReminderHistory> history,
  }) {
    final totalReminders = reminders.length;
    final totalOccurrences = occurrences.isNotEmpty ? occurrences.length : totalReminders;

    final completed = occurrences.isNotEmpty
        ? occurrences.where((o) => o.status == OccurrenceStatus.completed).length
        : reminders.where((r) => r.isDone).length;

    final overdue = occurrences.isNotEmpty
        ? occurrences.where((o) => o.isOverdue).length
        : reminders.where((r) => r.isOverdue).length;

    final archived = reminders.where((r) => r.isArchived).length;

    final completionPct = totalOccurrences > 0 ? (completed / totalOccurrences) * 100.0 : 0.0;

    final totalSnoozes = occurrences.isNotEmpty
        ? occurrences.fold<int>(0, (sum, o) => sum + o.snoozeCount)
        : reminders.fold<int>(0, (sum, r) => sum + r.snoozeCount);

    final avgSnooze = totalOccurrences > 0 ? totalSnoozes / totalOccurrences : 0.0;

    // Most missed folder: count overdue reminders per folderId
    final missedFolderCounts = <String, int>{};
    for (final r in reminders.where((r) => r.isOverdue && r.folderId != null)) {
      missedFolderCounts[r.folderId!] = (missedFolderCounts[r.folderId!] ?? 0) + 1;
    }
    String? mostMissedFolder;
    int maxMissed = 0;
    missedFolderCounts.forEach((folderId, count) {
      if (count > maxMissed) {
        maxMissed = count;
        mostMissedFolder = folderId;
      }
    });

    // Productive Time Window from actual completion timestamps
    final completedOccurrences = occurrences.where((o) => o.completedAt != null).toList();
    final windowCounts = {'Morning': 0, 'Afternoon': 0, 'Evening': 0, 'Night': 0};
    final hourlyBins = List<int>.filled(24, 0);

    if (completedOccurrences.isNotEmpty) {
      for (final occ in completedOccurrences) {
        final h = occ.completedAt!.hour;
        hourlyBins[h]++;
        if (h >= 6 && h < 12) {
          windowCounts['Morning'] = windowCounts['Morning']! + 1;
        } else if (h >= 12 && h < 17) {
          windowCounts['Afternoon'] = windowCounts['Afternoon']! + 1;
        } else if (h >= 17 && h < 21) {
          windowCounts['Evening'] = windowCounts['Evening']! + 1;
        } else {
          windowCounts['Night'] = windowCounts['Night']! + 1;
        }
      }
    } else {
      // Fallback to completion history timestamps if occurrences table is empty
      final completionEvents = history.where((h) => h.action == ActionType.completed).toList();
      for (final event in completionEvents) {
        final h = event.timestamp.hour;
        hourlyBins[h]++;
        if (h >= 6 && h < 12) {
          windowCounts['Morning'] = windowCounts['Morning']! + 1;
        } else if (h >= 12 && h < 17) {
          windowCounts['Afternoon'] = windowCounts['Afternoon']! + 1;
        } else if (h >= 17 && h < 21) {
          windowCounts['Evening'] = windowCounts['Evening']! + 1;
        } else {
          windowCounts['Night'] = windowCounts['Night']! + 1;
        }
      }
    }

    String topWindow = 'Morning';
    int maxWindowCount = -1;
    windowCounts.forEach((win, count) {
      if (count > maxWindowCount) {
        maxWindowCount = count;
        topWindow = win;
      }
    });

    // 7-day completion trend based on actual completion dates
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final trend = List<int>.filled(7, 0);

    for (int i = 0; i < 7; i++) {
      final dayTarget = today.subtract(Duration(days: 6 - i));
      if (completedOccurrences.isNotEmpty) {
        trend[i] = completedOccurrences.where((o) {
          final d = o.completedAt!;
          return d.year == dayTarget.year && d.month == dayTarget.month && d.day == dayTarget.day;
        }).length;
      } else {
        final completionEvents = history.where((h) => h.action == ActionType.completed).toList();
        trend[i] = completionEvents.where((e) {
          final d = e.timestamp;
          return d.year == dayTarget.year && d.month == dayTarget.month && d.day == dayTarget.day;
        }).length;
      }
    }

    return StatsData(
      totalReminders: totalReminders,
      totalOccurrences: totalOccurrences,
      completedReminders: completed,
      overdueReminders: overdue,
      archivedReminders: archived,
      completionPercentage: completionPct,
      totalSnoozes: totalSnoozes,
      averageSnoozeFrequency: avgSnooze,
      mostMissedFolderId: mostMissedFolder,
      productiveTimeWindow: (completed == 0) ? 'Morning (9 AM - 12 PM)' : topWindow,
      sevenDayCompletionTrend: trend,
      hourlyDistribution: hourlyBins,
    );
  }
}
