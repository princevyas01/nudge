import 'package:uuid/uuid.dart';

class PendingAction {
  final String id;
  final String action;
  final String reminderId;
  final DateTime occurrenceTimestamp;
  final DateTime createdAt;

  PendingAction({
    String? id,
    required this.action,
    required this.reminderId,
    required this.occurrenceTimestamp,
    DateTime? createdAt,
  })  : id = id ?? const Uuid().v4(),
        createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toJson() => {
    'id': id,
    'action': action,
    'reminderId': reminderId,
    'occurrenceTimestamp': occurrenceTimestamp.toIso8601String(),
    'createdAt': createdAt.toIso8601String(),
  };

  factory PendingAction.fromJson(Map<String, dynamic> json) {
    return PendingAction(
      id: json['id'] as String,
      action: json['action'] as String,
      reminderId: json['reminderId'] as String,
      occurrenceTimestamp: DateTime.parse(json['occurrenceTimestamp'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }
}
