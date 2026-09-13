import 'package:uuid/uuid.dart';
import '../enums/enums.dart';
import 'checklist_item.dart';

class Reminder {
  final String id;
  final String message;
  final String? folderId;
  final DateTime scheduledAt;
  final RepeatRule repeatRule;
  final String? soundId;
  final bool vibrationEnabled;
  final bool isDone;
  final DateTime createdAt;
  final List<ChecklistItem> checklist;
  final String? photoPath;
  final PriorityLevel priority;
  final int? repeatEndOccurrences;
  final DateTime? repeatEndDate;
  final AlertStyle alertStyle;
  final int snoozeCount;
  final String? calendarEventId;
  final bool isPinned;
  final bool isArchived;
  final bool isAlarmSynced;
  final int? customRepeatInterval;
  final List<int>? customRepeatDays;
  final CustomRepeatType? customRepeatType;

  Reminder({
    String? id,
    required this.message,
    this.folderId,
    required this.scheduledAt,
    this.repeatRule = RepeatRule.none,
    this.soundId = 'alarm',
    this.vibrationEnabled = true,
    this.isDone = false,
    DateTime? createdAt,
    this.checklist = const [],
    this.photoPath,
    this.priority = PriorityLevel.normal,
    this.repeatEndOccurrences,
    this.repeatEndDate,
    this.alertStyle = AlertStyle.alarm,
    this.snoozeCount = 0,
    this.calendarEventId,
    this.isPinned = false,
    this.isArchived = false,
    this.isAlarmSynced = true,
    this.customRepeatInterval,
    this.customRepeatDays,
    this.customRepeatType,
  })  : id = id ?? const Uuid().v4(),
        createdAt = createdAt ?? DateTime.now();

  bool get isActive => !isDone && !isArchived;
  bool get isOverdue => !isDone && scheduledAt.isBefore(DateTime.now());
  bool get isRepeating => repeatRule != RepeatRule.none;
  bool get hasChecklist => checklist.isNotEmpty;
  int get checklistCompletedCount => checklist.where((item) => item.isDone).length;

  Reminder copyWith({
    String? id,
    String? message,
    String? folderId,
    DateTime? scheduledAt,
    RepeatRule? repeatRule,
    String? soundId,
    bool? vibrationEnabled,
    bool? isDone,
    DateTime? createdAt,
    List<ChecklistItem>? checklist,
    String? photoPath,
    PriorityLevel? priority,
    int? repeatEndOccurrences,
    DateTime? repeatEndDate,
    AlertStyle? alertStyle,
    int? snoozeCount,
    String? calendarEventId,
    bool? isPinned,
    bool? isArchived,
    bool? isAlarmSynced,
    int? customRepeatInterval,
    List<int>? customRepeatDays,
    CustomRepeatType? customRepeatType,
  }) {
    return Reminder(
      id: id ?? this.id,
      message: message ?? this.message,
      folderId: folderId ?? this.folderId,
      scheduledAt: scheduledAt ?? this.scheduledAt,
      repeatRule: repeatRule ?? this.repeatRule,
      soundId: soundId ?? this.soundId,
      vibrationEnabled: vibrationEnabled ?? this.vibrationEnabled,
      isDone: isDone ?? this.isDone,
      createdAt: createdAt ?? this.createdAt,
      checklist: checklist ?? this.checklist,
      photoPath: photoPath ?? this.photoPath,
      priority: priority ?? this.priority,
      repeatEndOccurrences: repeatEndOccurrences ?? this.repeatEndOccurrences,
      repeatEndDate: repeatEndDate ?? this.repeatEndDate,
      alertStyle: alertStyle ?? this.alertStyle,
      snoozeCount: snoozeCount ?? this.snoozeCount,
      calendarEventId: calendarEventId ?? this.calendarEventId,
      isPinned: isPinned ?? this.isPinned,
      isArchived: isArchived ?? this.isArchived,
      isAlarmSynced: isAlarmSynced ?? this.isAlarmSynced,
      customRepeatInterval: customRepeatInterval ?? this.customRepeatInterval,
      customRepeatDays: customRepeatDays ?? this.customRepeatDays,
      customRepeatType: customRepeatType ?? this.customRepeatType,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'message': message,
    'folderId': folderId,
    'scheduledAt': scheduledAt.toIso8601String(),
    'repeatRule': repeatRule.name,
    'soundId': soundId,
    'vibrationEnabled': vibrationEnabled ? 1 : 0,
    'isDone': isDone ? 1 : 0,
    'createdAt': createdAt.toIso8601String(),
    'checklist': checklist.map((e) => e.toJson()).toList(),
    'photoPath': photoPath,
    'priority': priority.name,
    'repeatEndOccurrences': repeatEndOccurrences,
    'repeatEndDate': repeatEndDate?.toIso8601String(),
    'alertStyle': alertStyle.name,
    'snoozeCount': snoozeCount,
    'calendarEventId': calendarEventId,
    'isPinned': isPinned ? 1 : 0,
    'isArchived': isArchived ? 1 : 0,
    'isAlarmSynced': isAlarmSynced ? 1 : 0,
    'customRepeatInterval': customRepeatInterval,
    'customRepeatDays': customRepeatDays?.join(','),
    'customRepeatType': customRepeatType?.name,
  };

  factory Reminder.fromJson(Map<String, dynamic> json) {
    return Reminder(
      id: json['id'] as String,
      message: json['message'] as String? ?? '',
      folderId: json['folderId'] as String?,
      scheduledAt: DateTime.parse(json['scheduledAt'] as String),
      repeatRule: RepeatRule.values.firstWhere(
        (e) => e.name == json['repeatRule'],
        orElse: () => RepeatRule.none,
      ),
      soundId: json['soundId'] as String? ?? 'alarm',
      vibrationEnabled: json['vibrationEnabled'] == 1 || json['vibrationEnabled'] == true,
      isDone: json['isDone'] == 1 || json['isDone'] == true,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : DateTime.now(),
      checklist: (json['checklist'] as List<dynamic>?)
              ?.map((e) => ChecklistItem.fromJson(Map<String, dynamic>.from(e as Map)))
              .toList() ??
          [],
      photoPath: json['photoPath'] as String?,
      priority: PriorityLevel.values.firstWhere(
        (e) => e.name == json['priority'],
        orElse: () => PriorityLevel.normal,
      ),
      repeatEndOccurrences: json['repeatEndOccurrences'] as int?,
      repeatEndDate: json['repeatEndDate'] != null
          ? DateTime.parse(json['repeatEndDate'] as String)
          : null,
      alertStyle: AlertStyle.values.firstWhere(
        (e) => e.name == json['alertStyle'],
        orElse: () => AlertStyle.alarm,
      ),
      snoozeCount: (json['snoozeCount'] as num?)?.toInt() ?? 0,
      calendarEventId: json['calendarEventId'] as String?,
      isPinned: json['isPinned'] == 1 || json['isPinned'] == true,
      isArchived: json['isArchived'] == 1 || json['isArchived'] == true,
      isAlarmSynced: json['isAlarmSynced'] == null ? true : (json['isAlarmSynced'] == 1 || json['isAlarmSynced'] == true),
      customRepeatInterval: (json['customRepeatInterval'] as num?)?.toInt(),
      customRepeatDays: json['customRepeatDays'] != null && (json['customRepeatDays'] as String).isNotEmpty
          ? (json['customRepeatDays'] as String).split(',').map((e) => int.parse(e.trim())).toList()
          : null,
      customRepeatType: json['customRepeatType'] != null
          ? CustomRepeatType.values.firstWhere(
              (e) => e.name == json['customRepeatType'],
              orElse: () => CustomRepeatType.days,
            )
          : null,
    );
  }
}
