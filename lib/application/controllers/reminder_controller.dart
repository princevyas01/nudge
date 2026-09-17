import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

import '../../core/constants/app_constants.dart';
import '../../core/logging/app_logger.dart';
import '../../data/media/app_media_repository.dart';
import '../../domain/entities/reminder.dart';
import '../../domain/entities/reminder_occurrence.dart';
import '../../domain/entities/reminder_history.dart';
import '../../domain/enums/enums.dart';
import '../../domain/repositories/i_reminder_repository.dart';
import '../../domain/repositories/i_occurrence_repository.dart';
import '../../domain/repositories/i_history_repository.dart';
import '../../domain/services/recurrence_engine.dart';
import '../../domain/services/stats_calculator.dart';
import '../../platform/alarms/alarm_platform_service.dart';
import '../../platform/calendar/i_calendar_bridge.dart';
import '../../platform/calendar/device_calendar_bridge.dart';
import '../../platform/widgets/home_widget_bridge.dart';
import 'companion_controller.dart';

class ReminderController extends ChangeNotifier {
  static const String _subsystem = 'ReminderController';

  final IReminderRepository _reminderRepo;
  final IOccurrenceRepository _occurrenceRepo;
  final IHistoryRepository _historyRepo;
  final ICalendarBridge _calendarBridge;

  List<Reminder> _reminders = [];
  List<Reminder> get reminders => List.unmodifiable(_reminders);

  // Exact alarm capability state
  bool _exactAlarmsAllowed = true;
  bool get exactAlarmsAllowed => _exactAlarmsAllowed;

  // Filters & Sorting
  FilterType _activeFilter = FilterType.all;
  FilterType get activeFilter => _activeFilter;

  PriorityLevel? _priorityFilter;
  PriorityLevel? get priorityFilter => _priorityFilter;

  String? _folderFilter;
  String? get folderFilter => _folderFilter;

  SortOption _sortOption = SortOption.time;
  SortOption get sortOption => _sortOption;

  String _searchQuery = '';
  String get searchQuery => _searchQuery;

  // Undo Buffer
  Reminder? _lastDeletedReminder;
  Reminder? get lastDeletedReminder => _lastDeletedReminder;

  // In-progress action guard for idempotency
  final Set<String> _inProgressActions = {};

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  ReminderController({
    required IReminderRepository reminderRepo,
    required IOccurrenceRepository occurrenceRepo,
    required IHistoryRepository historyRepo,
    ICalendarBridge? calendarBridge,
  })  : _reminderRepo = reminderRepo,
        _occurrenceRepo = occurrenceRepo,
        _historyRepo = historyRepo,
        _calendarBridge = calendarBridge ?? DeviceCalendarBridge();

  Future<void> loadReminders() async {
    _isLoading = true;
    notifyListeners();

    try {
      _reminders = await _reminderRepo.getAllReminders();
      await checkExactAlarmCapability();
      _syncProjections();
      AppLogger.info(_subsystem, 'Loaded ${_reminders.length} reminders');
    } catch (e, stack) {
      AppLogger.error(_subsystem, 'Failed to load reminders', error: e, stackTrace: stack);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> checkExactAlarmCapability() async {
    try {
      final isGranted = await AlarmPlatformService.canScheduleExactAlarms();
      final previous = _exactAlarmsAllowed;
      _exactAlarmsAllowed = isGranted;

      if (!previous && isGranted) {
        AppLogger.info(_subsystem, 'Exact alarm permission restored. Reconciling alarms...');
        await reconcileAlarms();
      } else if (!isGranted) {
        for (int i = 0; i < _reminders.length; i++) {
          if (!_reminders[i].isDone && !_reminders[i].isArchived && _reminders[i].isAlarmSynced) {
            final unsynced = _reminders[i].copyWith(isAlarmSynced: false);
            await _reminderRepo.updateReminder(unsynced);
            _reminders[i] = unsynced;
          }
        }
        notifyListeners();
      }
    } catch (e) {
      // Non-Android platforms or permission check error
    }
  }

  Future<void> reconcileAlarms() async {
    AppLogger.info(_subsystem, 'Reconciling active alarms...');
    final now = DateTime.now();

    for (int i = 0; i < _reminders.length; i++) {
      final r = _reminders[i];
      if (!r.isDone && !r.isArchived && r.scheduledAt.isAfter(now)) {
        bool scheduled = false;
        try {
          await AlarmPlatformService.scheduleAlarm(r);
          scheduled = true;
        } catch (e) {
          scheduled = false;
        }
        if (r.isAlarmSynced != scheduled) {
          final synced = r.copyWith(isAlarmSynced: scheduled);
          await _reminderRepo.updateReminder(synced);
          _reminders[i] = synced;
        }
      }
    }
    notifyListeners();
  }

  // Filter and Search
  void setFilter(FilterType filter) {
    _activeFilter = filter;
    notifyListeners();
  }

  void setPriorityFilter(PriorityLevel? priority) {
    _priorityFilter = priority;
    notifyListeners();
  }

  void setFolderFilter(String? folderId) {
    _folderFilter = folderId;
    notifyListeners();
  }

  void setSortOption(SortOption option) {
    _sortOption = option;
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  List<Reminder> get filteredReminders {
    List<Reminder> list = List.from(_reminders);

    // Apply main filter
    switch (_activeFilter) {
      case FilterType.all:
        list = list.where((r) => !r.isArchived).toList();
        break;
      case FilterType.today:
        final now = DateTime.now();
        list = list.where((r) {
          if (r.isArchived) return false;
          final d = r.scheduledAt;
          return d.year == now.year && d.month == now.month && d.day == now.day;
        }).toList();
        break;
      case FilterType.overdue:
        list = list.where((r) => r.isOverdue && !r.isArchived).toList();
        break;
      case FilterType.upcoming:
        final now = DateTime.now();
        list = list.where((r) => !r.isDone && !r.isArchived && r.scheduledAt.isAfter(now)).toList();
        break;
      case FilterType.pinned:
        list = list.where((r) => r.isPinned && !r.isArchived).toList();
        break;
      case FilterType.completed:
        list = list.where((r) => r.isDone && !r.isArchived).toList();
        break;
      case FilterType.archived:
        list = list.where((r) => r.isArchived).toList();
        break;
    }

    // Apply priority filter
    if (_priorityFilter != null) {
      list = list.where((r) => r.priority == _priorityFilter).toList();
    }

    // Apply folder filter
    if (_folderFilter != null) {
      list = list.where((r) => r.folderId == _folderFilter).toList();
    }

    // Apply search query
    if (_searchQuery.trim().isNotEmpty) {
      final q = _searchQuery.toLowerCase().trim();
      list = list.where((r) {
        final matchesMsg = r.message.toLowerCase().contains(q);
        final matchesChecklist = r.checklist.any((item) => item.text.toLowerCase().contains(q));
        return matchesMsg || matchesChecklist;
      }).toList();
    }

    // Apply sorting (pinned items stay pinned at the top unless in archived/completed)
    list.sort((a, b) {
      if (_activeFilter != FilterType.completed && _activeFilter != FilterType.archived) {
        if (a.isPinned && !b.isPinned) return -1;
        if (!a.isPinned && b.isPinned) return 1;
      }

      switch (_sortOption) {
        case SortOption.time:
          return a.scheduledAt.compareTo(b.scheduledAt);
        case SortOption.priority:
          return b.priority.index.compareTo(a.priority.index);
        case SortOption.created:
          return b.createdAt.compareTo(a.createdAt);
      }
    });

    return list;
  }

  // Reminder CRUD
  Future<void> createReminder(Reminder reminder, {bool syncCalendar = false}) =>
      saveReminder(reminder, syncCalendar: syncCalendar);

  Future<void> saveReminder(Reminder reminder, {bool syncCalendar = false}) async {
    AppLogger.info(_subsystem, 'Saving new reminder: ${reminder.id} - ${reminder.message}');

    var finalReminder = reminder;
    if (syncCalendar) {
      final calEventId = await _calendarBridge.syncReminderToCalendar(reminder);
      if (calEventId != null) {
        finalReminder = finalReminder.copyWith(calendarEventId: calEventId);
      }
    }

    bool alarmSynced = false;
    if (!finalReminder.isDone &&
        !finalReminder.isArchived &&
        finalReminder.scheduledAt.isAfter(DateTime.now())) {
      try {
        await AlarmPlatformService.scheduleAlarm(finalReminder);
        alarmSynced = true;
      } on AlarmPermissionRequiredException {
        alarmSynced = false;
      } catch (e, stack) {
        alarmSynced = false;
        AppLogger.error(
          _subsystem,
          'Alarm scheduling failed for ',
          error: e,
          stackTrace: stack,
        );
      }
    }
    finalReminder = finalReminder.copyWith(isAlarmSynced: alarmSynced);

    await _reminderRepo.saveReminder(finalReminder);
    _reminders.add(finalReminder);

    // Create and record initial occurrence
    final initialOccurrence = ReminderOccurrence(
      id: const Uuid().v4(),
      reminderId: finalReminder.id,
      scheduledAt: finalReminder.scheduledAt,
      status: OccurrenceStatus.pending,
    );
    await _occurrenceRepo.saveOccurrence(initialOccurrence);

    await _historyRepo.logEvent(ReminderHistory(
      reminderId: finalReminder.id,
      action: ActionType.created,
      details: 'Created with ${finalReminder.repeatRule.name} recurrence',
    ));

    _syncProjections();
    notifyListeners();
  }

  Future<void> updateReminder(Reminder updated, {bool syncCalendar = false}) async {
    AppLogger.info(_subsystem, 'Updating reminder: ${updated.id}');
    final idx = _reminders.indexWhere((r) => r.id == updated.id);
    if (idx == -1) return;

    final old = _reminders[idx];
    Reminder finalUpdated = updated;

    if (syncCalendar || updated.calendarEventId != null) {
      final calEventId = await _calendarBridge.syncReminderToCalendar(updated);
      if (calEventId != null) {
        finalUpdated = finalUpdated.copyWith(calendarEventId: calEventId);
      }
    }

    final scheduleChanged = old.scheduledAt != finalUpdated.scheduledAt ||
        old.isDone != finalUpdated.isDone ||
        old.isArchived != finalUpdated.isArchived ||
        old.soundId != finalUpdated.soundId ||
        old.vibrationEnabled != finalUpdated.vibrationEnabled;

    if (scheduleChanged) {
      await AlarmPlatformService.cancelAlarm(old.id);

      bool updateAlarmSynced = false;
      if (!finalUpdated.isDone &&
          !finalUpdated.isArchived &&
          finalUpdated.scheduledAt.isAfter(DateTime.now())) {
        try {
          await AlarmPlatformService.scheduleAlarm(finalUpdated);
          updateAlarmSynced = true;
        } catch (e) {
          updateAlarmSynced = false;
        }
      }
      finalUpdated = finalUpdated.copyWith(isAlarmSynced: updateAlarmSynced);

      // Update pending occurrence scheduled time if changed
      if (old.scheduledAt != finalUpdated.scheduledAt) {
        final pendingOcc = await _occurrenceRepo.getPendingOccurrence(finalUpdated.id);
        if (pendingOcc != null) {
          await _occurrenceRepo.updateOccurrence(
            pendingOcc.copyWith(scheduledAt: finalUpdated.scheduledAt),
          );
        }
      }
    }

    await _reminderRepo.updateReminder(finalUpdated);
    _reminders[idx] = finalUpdated;

    await _historyRepo.logEvent(ReminderHistory(
      reminderId: finalUpdated.id,
      action: ActionType.edited,
      details: 'Updated schedule or content',
    ));

    _syncProjections();
    notifyListeners();
  }

  Future<void> deleteReminder(String id) async {
    final idx = _reminders.indexWhere((r) => r.id == id);
    if (idx == -1) return;

    final target = _reminders[idx];
    _lastDeletedReminder = target;

    await _reminderRepo.deleteReminder(id);
    await _occurrenceRepo.deleteOccurrencesForReminder(id);
    _reminders.removeAt(idx);

    await AlarmPlatformService.cancelAlarm(id);
    if (target.calendarEventId != null) {
      await _calendarBridge.removeReminderFromCalendar(target.calendarEventId);
    }

    // Clean up sandboxed media if present
    if (target.photoPath != null) {
      await AppMediaRepository.deleteMedia(target.photoPath);
    }

    await _historyRepo.logEvent(ReminderHistory(
      reminderId: id,
      action: ActionType.deleted,
    ));

    _syncProjections();
    notifyListeners();
  }

  Future<void> undoDelete() async {
    if (_lastDeletedReminder == null) return;
    final restored = _lastDeletedReminder!;
    _lastDeletedReminder = null;

    await _reminderRepo.saveReminder(restored);
    _reminders.add(restored);

    final occ = ReminderOccurrence(
      id: const Uuid().v4(),
      reminderId: restored.id,
      scheduledAt: restored.scheduledAt,
      status: OccurrenceStatus.pending,
    );
    await _occurrenceRepo.saveOccurrence(occ);

    bool scheduled = false;
    if (!restored.isDone && !restored.isArchived && restored.scheduledAt.isAfter(DateTime.now())) {
      try {
        await AlarmPlatformService.scheduleAlarm(restored);
        scheduled = true;
      } catch (e) {
        scheduled = false;
      }
    }
    final finalRestored = restored.copyWith(isAlarmSynced: scheduled);
    await _reminderRepo.updateReminder(finalRestored);
    _reminders[_reminders.length - 1] = finalRestored;

    await _historyRepo.logEvent(ReminderHistory(
      reminderId: restored.id,
      action: ActionType.restored,
      details: 'Restored from undo',
    ));

    _syncProjections();
    notifyListeners();
  }

  Future<void> completeReminder(String id, [CompanionController? companionController]) async {
    if (_inProgressActions.contains(id)) return;
    _inProgressActions.add(id);

    try {
      final idx = _reminders.indexWhere((r) => r.id == id);
      if (idx == -1) return;

      final current = _reminders[idx];
      if (current.isDone) return; // Idempotency guard

      await AlarmPlatformService.cancelAlarm(id);
      await AlarmPlatformService.dismissRingingAlarm();

      // Record completion on occurrence
      final pendingOcc = await _occurrenceRepo.getPendingOccurrence(id);
      if (pendingOcc != null) {
        await _occurrenceRepo.updateOccurrence(pendingOcc.copyWith(
          status: OccurrenceStatus.completed,
          completedAt: DateTime.now(),
        ));
      } else {
        await _occurrenceRepo.saveOccurrence(ReminderOccurrence(
          id: const Uuid().v4(),
          reminderId: id,
          scheduledAt: current.scheduledAt,
          completedAt: DateTime.now(),
          status: OccurrenceStatus.completed,
        ));
      }

      if (current.repeatRule == RepeatRule.none) {
        // Non-recurring: mark done
        final done = current.copyWith(isDone: true);
        await _reminderRepo.updateReminder(done);
        _reminders[idx] = done;
      } else {
        // Recurring: advance occurrence
        final nextDate = RecurrenceEngine.calculateNextOccurrence(current);
        if (nextDate != null) {
          final advanced = current.copyWith(
            scheduledAt: nextDate,
            snoozeCount: 0,
            checklist: current.checklist.map((c) => c.copyWith(isDone: false)).toList(),
            repeatEndOccurrences: current.repeatEndOccurrences != null
                ? current.repeatEndOccurrences! - 1
                : null,
          );
          await _reminderRepo.updateReminder(advanced);
          _reminders[idx] = advanced;

          // Create next pending occurrence
          await _occurrenceRepo.saveOccurrence(ReminderOccurrence(
            id: const Uuid().v4(),
            reminderId: id,
            scheduledAt: nextDate,
            status: OccurrenceStatus.pending,
          ));

          bool scheduled = false;
          try {
            await AlarmPlatformService.scheduleAlarm(advanced);
            scheduled = true;
          } catch (e) {
            scheduled = false;
          }
          final finalAdvanced = advanced.copyWith(isAlarmSynced: scheduled);
          await _reminderRepo.updateReminder(finalAdvanced);
          _reminders[idx] = finalAdvanced;
        } else {
          // End limit reached
          final completed = current.copyWith(isDone: true);
          await _reminderRepo.updateReminder(completed);
          _reminders[idx] = completed;
        }
      }

      await _historyRepo.logEvent(ReminderHistory(
        reminderId: id,
        action: ActionType.completed,
      ));

      companionController?.triggerCelebration();

      _syncProjections();
      notifyListeners();
    } finally {
      _inProgressActions.remove(id);
    }
  }

  Future<bool> snoozeReminder(String id, [int? minutes]) async {
    final idx = _reminders.indexWhere((r) => r.id == id);
    if (idx == -1) return false;

    final current = _reminders[idx];
    if (current.snoozeCount >= AppConstants.maxSnoozeCount) {
      AppLogger.warning(_subsystem, 'Reminder $id has reached max snooze limit of ${AppConstants.maxSnoozeCount}');
      return false;
    }

    final snoozeMin = minutes ?? AppConstants.defaultSnoozeMinutes;
    final newTime = DateTime.now().add(Duration(minutes: snoozeMin));
    final updatedSnoozeCount = current.snoozeCount + 1;

    final snoozed = current.copyWith(
      scheduledAt: newTime,
      snoozeCount: updatedSnoozeCount,
    );

    await _reminderRepo.updateReminder(snoozed);
    _reminders[idx] = snoozed;

    // Update pending occurrence
    final pendingOcc = await _occurrenceRepo.getPendingOccurrence(id);
    if (pendingOcc != null) {
      await _occurrenceRepo.updateOccurrence(pendingOcc.copyWith(
        scheduledAt: newTime,
        snoozeCount: updatedSnoozeCount,
        status: OccurrenceStatus.snoozed,
      ));
    }

    await AlarmPlatformService.dismissRingingAlarm();
    await AlarmPlatformService.cancelAlarm(id);

    bool scheduled = false;
    try {
      await AlarmPlatformService.scheduleAlarm(snoozed);
      scheduled = true;
    } catch (e) {
      scheduled = false;
    }
    final finalSnoozed = snoozed.copyWith(isAlarmSynced: scheduled);
    await _reminderRepo.updateReminder(finalSnoozed);
    _reminders[idx] = finalSnoozed;

    await _historyRepo.logEvent(ReminderHistory(
      reminderId: id,
      action: ActionType.snoozed,
      details: 'Snoozed for $snoozeMin minutes (Snooze #$updatedSnoozeCount)',
    ));

    _syncProjections();
    notifyListeners();
    return true;
  }

  Future<void> skipOccurrence(String id) async {
    final idx = _reminders.indexWhere((r) => r.id == id);
    if (idx == -1) return;

    final current = _reminders[idx];
    if (current.repeatRule == RepeatRule.none) return;

    // Mark current occurrence as skipped
    final pendingOcc = await _occurrenceRepo.getPendingOccurrence(id);
    if (pendingOcc != null) {
      await _occurrenceRepo.updateOccurrence(pendingOcc.copyWith(status: OccurrenceStatus.skipped));
    }

    final nextDate = RecurrenceEngine.calculateNextOccurrence(current);
    if (nextDate != null) {
      final advanced = current.copyWith(
        scheduledAt: nextDate,
        snoozeCount: 0,
        checklist: current.checklist.map((c) => c.copyWith(isDone: false)).toList(),
      );
      await _reminderRepo.updateReminder(advanced);
      _reminders[idx] = advanced;

      await _occurrenceRepo.saveOccurrence(ReminderOccurrence(
        id: const Uuid().v4(),
        reminderId: id,
        scheduledAt: nextDate,
        status: OccurrenceStatus.pending,
      ));

      await AlarmPlatformService.cancelAlarm(id);
      bool scheduled = false;
      try {
        await AlarmPlatformService.scheduleAlarm(advanced);
        scheduled = true;
      } catch (e) {
        scheduled = false;
      }
      final finalAdvanced = advanced.copyWith(isAlarmSynced: scheduled);
      await _reminderRepo.updateReminder(finalAdvanced);
      _reminders[idx] = finalAdvanced;

      await _historyRepo.logEvent(ReminderHistory(
        reminderId: id,
        action: ActionType.skipped,
        details: 'Skipped occurrence to $nextDate',
      ));

      _syncProjections();
      notifyListeners();
    }
  }

  Future<void> togglePin(String id) async {
    final idx = _reminders.indexWhere((r) => r.id == id);
    if (idx == -1) return;

    final updated = _reminders[idx].copyWith(isPinned: !_reminders[idx].isPinned);
    await _reminderRepo.updateReminder(updated);
    _reminders[idx] = updated;
    notifyListeners();
  }

  Future<void> toggleArchive(String id) async {
    final idx = _reminders.indexWhere((r) => r.id == id);
    if (idx == -1) return;

    final target = _reminders[idx];
    final willArchive = !target.isArchived;
    final updated = target.copyWith(isArchived: willArchive);

    await _reminderRepo.updateReminder(updated);
    _reminders[idx] = updated;

    if (willArchive) {
      await AlarmPlatformService.cancelAlarm(id);
    } else {
      if (!updated.isDone && updated.scheduledAt.isAfter(DateTime.now())) {
        await AlarmPlatformService.scheduleAlarm(updated);
      }
    }

    await _historyRepo.logEvent(ReminderHistory(
      reminderId: id,
      action: willArchive ? ActionType.archived : ActionType.restored,
    ));

    _syncProjections();
    notifyListeners();
  }

  Future<void> toggleChecklistItem(String reminderId, String itemId) async {
    final idx = _reminders.indexWhere((r) => r.id == reminderId);
    if (idx == -1) return;

    final r = _reminders[idx];
    final updatedChecklist = r.checklist.map((c) {
      return c.id == itemId ? c.copyWith(isDone: !c.isDone) : c;
    }).toList();

    final updated = r.copyWith(checklist: updatedChecklist);
    await _reminderRepo.updateReminder(updated);
    _reminders[idx] = updated;
    notifyListeners();
  }

  void _syncProjections() {
    final upcoming = _reminders.where((r) => !r.isArchived && !r.isDone && r.scheduledAt.isAfter(DateTime.now())).toList();
    upcoming.sort((a, b) => a.scheduledAt.compareTo(b.scheduledAt));
    HomeWidgetBridge.updateWidget(upcoming.take(3).toList());
  }

  Future<StatsData> getStats() async {
    final occurrences = await _occurrenceRepo.getAllOccurrences();
    final history = await _historyRepo.getAllHistory();
    return StatsCalculator.calculate(
      reminders: _reminders,
      occurrences: occurrences,
      history: history,
    );
  }

  Future<List<ReminderHistory>> getHistoryForReminder(String reminderId) async {
    return _historyRepo.getHistoryForReminder(reminderId);
  }
}
