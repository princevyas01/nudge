import 'package:uuid/uuid.dart';

class TodoSubtask {
  final String id;
  final String todoId;
  final String text;
  final bool isDone;
  final int sortOrder;
  final DateTime createdAt;
  final DateTime? completedAt;

  TodoSubtask({
    String? id,
    required this.todoId,
    required this.text,
    this.isDone = false,
    this.sortOrder = 0,
    DateTime? createdAt,
    this.completedAt,
  })  : id = id ?? const Uuid().v4(),
        createdAt = createdAt ?? DateTime.now();

  TodoSubtask copyWith({
    String? id,
    String? todoId,
    String? text,
    bool? isDone,
    int? sortOrder,
    DateTime? createdAt,
    DateTime? completedAt,
  }) {
    return TodoSubtask(
      id: id ?? this.id,
      todoId: todoId ?? this.todoId,
      text: text ?? this.text,
      isDone: isDone ?? this.isDone,
      sortOrder: sortOrder ?? this.sortOrder,
      createdAt: createdAt ?? this.createdAt,
      completedAt: completedAt ?? this.completedAt,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'todoId': todoId,
    'text': text,
    'isDone': isDone ? 1 : 0,
    'sortOrder': sortOrder,
    'createdAt': createdAt.toIso8601String(),
    'completedAt': completedAt?.toIso8601String(),
  };

  factory TodoSubtask.fromJson(Map<String, dynamic> json) {
    return TodoSubtask(
      id: json['id'] as String,
      todoId: json['todoId'] as String,
      text: json['text'] as String,
      isDone: (json['isDone'] is int ? json['isDone'] == 1 : json['isDone'] == true),
      sortOrder: json['sortOrder'] as int? ?? 0,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : DateTime.now(),
      completedAt: json['completedAt'] != null
          ? DateTime.parse(json['completedAt'] as String)
          : null,
    );
  }
}
