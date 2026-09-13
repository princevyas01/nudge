import 'package:uuid/uuid.dart';
import '../enums/enums.dart';
import 'checklist_item.dart';

class ReminderTemplate {
  final String id;
  final String title;
  final String message;
  final PriorityLevel priority;
  final AlertStyle alertStyle;
  final RepeatRule repeatRule;
  final List<ChecklistItem> checklist;

  ReminderTemplate({
    String? id,
    required this.title,
    required this.message,
    this.priority = PriorityLevel.normal,
    this.alertStyle = AlertStyle.alarm,
    this.repeatRule = RepeatRule.none,
    this.checklist = const [],
  }) : id = id ?? const Uuid().v4();

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'message': message,
    'priority': priority.name,
    'alertStyle': alertStyle.name,
    'repeatRule': repeatRule.name,
    'checklist': checklist.map((e) => e.toJson()).toList(),
  };

  factory ReminderTemplate.fromJson(Map<String, dynamic> json) {
    return ReminderTemplate(
      id: json['id'] as String,
      title: json['title'] as String,
      message: json['message'] as String,
      priority: PriorityLevel.values.firstWhere(
        (e) => e.name == json['priority'],
        orElse: () => PriorityLevel.normal,
      ),
      alertStyle: AlertStyle.values.firstWhere(
        (e) => e.name == json['alertStyle'],
        orElse: () => AlertStyle.alarm,
      ),
      repeatRule: RepeatRule.values.firstWhere(
        (e) => e.name == json['repeatRule'],
        orElse: () => RepeatRule.none,
      ),
      checklist: (json['checklist'] as List<dynamic>?)
              ?.map((e) => ChecklistItem.fromJson(Map<String, dynamic>.from(e as Map)))
              .toList() ??
          [],
    );
  }
}
