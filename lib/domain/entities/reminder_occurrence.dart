import '../enums/enums.dart';

class ReminderOccurrence {
  final String id;
  final String reminderId;
  final DateTime scheduledAt;
  final DateTime? completedAt;
  final OccurrenceStatus status;
  final int snoozeCount;
  final String? actionMetadata;

  const ReminderOccurrence({
    required this.id,
    required this.reminderId,
    required this.scheduledAt,
    this.completedAt,
    this.status = OccurrenceStatus.pending,
    this.snoozeCount = 0,
    this.actionMetadata,
  });

  bool get isDone => status == OccurrenceStatus.completed;
  bool get isCompleted => isDone;
  bool get canSnooze => snoozeCount < 3;
  bool get isOverdue =>
      status == OccurrenceStatus.pending && scheduledAt.isBefore(DateTime.now());

  ReminderOccurrence copyWith({
    String? id,
    String? reminderId,
    DateTime? scheduledAt,
    DateTime? completedAt,
    OccurrenceStatus? status,
    int? snoozeCount,
    String? actionMetadata,
  }) {
    return ReminderOccurrence(
      id: id ?? this.id,
      reminderId: reminderId ?? this.reminderId,
      scheduledAt: scheduledAt ?? this.scheduledAt,
      completedAt: completedAt ?? this.completedAt,
      status: status ?? this.status,
      snoozeCount: snoozeCount ?? this.snoozeCount,
      actionMetadata: actionMetadata ?? this.actionMetadata,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'reminderId': reminderId,
      'scheduledAt': scheduledAt.toIso8601String(),
      'completedAt': completedAt?.toIso8601String(),
      'status': status.name,
      'snoozeCount': snoozeCount,
      'actionMetadata': actionMetadata,
    };
  }

  factory ReminderOccurrence.fromJson(Map<String, dynamic> json) {
    return ReminderOccurrence(
      id: json['id'] as String,
      reminderId: json['reminderId'] as String,
      scheduledAt: DateTime.parse(json['scheduledAt'] as String),
      completedAt: json['completedAt'] != null
          ? DateTime.parse(json['completedAt'] as String)
          : null,
      status: OccurrenceStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => OccurrenceStatus.pending,
      ),
      snoozeCount: (json['snoozeCount'] as num?)?.toInt() ?? 0,
      actionMetadata: json['actionMetadata'] as String?,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ReminderOccurrence && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
