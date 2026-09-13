import 'package:uuid/uuid.dart';
import '../enums/enums.dart';

class ReminderHistory {
  final String id;
  final String reminderId;
  final ActionType action;
  final DateTime timestamp;
  final String? details;

  ReminderHistory({
    String? id,
    required this.reminderId,
    required this.action,
    DateTime? timestamp,
    this.details,
  })  : id = id ?? const Uuid().v4(),
        timestamp = timestamp ?? DateTime.now();

  Map<String, dynamic> toJson() => {
    'id': id,
    'reminderId': reminderId,
    'action': action.name,
    'timestamp': timestamp.toIso8601String(),
    'details': details,
  };

  factory ReminderHistory.fromJson(Map<String, dynamic> json) {
    return ReminderHistory(
      id: json['id'] as String,
      reminderId: json['reminderId'] as String,
      action: ActionType.values.firstWhere(
        (e) => e.name == json['action'],
        orElse: () => ActionType.created,
      ),
      timestamp: DateTime.parse(json['timestamp'] as String),
      details: json['details'] as String?,
    );
  }
}
