import 'dart:convert';
import 'package:uuid/uuid.dart';
import '../enums/todo_enums.dart';
import 'todo_subtask.dart';

class Todo {
  final String id;
  final String title;
  final String? description;
  final TodoStatus status;
  final TodoPriority priority;
  final String? folderId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? completedAt;
  final DateTime? dueAt;
  final bool isPinned;
  final bool isArchived;
  final bool isDeleted;
  final String? parentTodoId;
  final int sortOrder;
  final List<String> tags;
  final String? recurrenceRule;
  final bool reminderEnabled;
  final DateTime? reminderAt;
  final String? colorTag;
  final String? sourceRecordId;
  final String? metadataJson;
  final List<TodoSubtask> subtasks;

  Todo({
    String? id,
    required this.title,
    this.description,
    this.status = TodoStatus.pending,
    this.priority = TodoPriority.normal,
    this.folderId,
    DateTime? createdAt,
    DateTime? updatedAt,
    this.completedAt,
    this.dueAt,
    this.isPinned = false,
    this.isArchived = false,
    this.isDeleted = false,
    this.parentTodoId,
    this.sortOrder = 0,
    this.tags = const [],
    this.recurrenceRule,
    this.reminderEnabled = false,
    this.reminderAt,
    this.colorTag,
    this.sourceRecordId,
    this.metadataJson,
    this.subtasks = const [],
  })  : id = id ?? const Uuid().v4(),
        createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  bool get isDone => status == TodoStatus.completed;
  bool get isOverdue => !isDone && dueAt != null && dueAt!.isBefore(DateTime.now());
  bool get isDueToday {
    if (dueAt == null) return false;
    final now = DateTime.now();
    return dueAt!.year == now.year && dueAt!.month == now.month && dueAt!.day == now.day;
  }
  bool get hasSubtasks => subtasks.isNotEmpty;
  int get completedSubtasksCount => subtasks.where((s) => s.isDone).length;
  double get subtasksProgress => hasSubtasks ? completedSubtasksCount / subtasks.length : 0.0;

  Todo copyWith({
    String? id,
    String? title,
    String? description,
    TodoStatus? status,
    TodoPriority? priority,
    String? folderId,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? completedAt,
    DateTime? dueAt,
    bool? isPinned,
    bool? isArchived,
    bool? isDeleted,
    String? parentTodoId,
    int? sortOrder,
    List<String>? tags,
    String? recurrenceRule,
    bool? reminderEnabled,
    DateTime? reminderAt,
    String? colorTag,
    String? sourceRecordId,
    String? metadataJson,
    List<TodoSubtask>? subtasks,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      status: status ?? this.status,
      priority: priority ?? this.priority,
      folderId: folderId ?? this.folderId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? DateTime.now(),
      completedAt: completedAt ?? this.completedAt,
      dueAt: dueAt ?? this.dueAt,
      isPinned: isPinned ?? this.isPinned,
      isArchived: isArchived ?? this.isArchived,
      isDeleted: isDeleted ?? this.isDeleted,
      parentTodoId: parentTodoId ?? this.parentTodoId,
      sortOrder: sortOrder ?? this.sortOrder,
      tags: tags ?? this.tags,
      recurrenceRule: recurrenceRule ?? this.recurrenceRule,
      reminderEnabled: reminderEnabled ?? this.reminderEnabled,
      reminderAt: reminderAt ?? this.reminderAt,
      colorTag: colorTag ?? this.colorTag,
      sourceRecordId: sourceRecordId ?? this.sourceRecordId,
      metadataJson: metadataJson ?? this.metadataJson,
      subtasks: subtasks ?? this.subtasks,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'status': status.name,
    'priority': priority.name,
    'folderId': folderId,
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
    'completedAt': completedAt?.toIso8601String(),
    'dueAt': dueAt?.toIso8601String(),
    'isPinned': isPinned ? 1 : 0,
    'isArchived': isArchived ? 1 : 0,
    'isDeleted': isDeleted ? 1 : 0,
    'parentTodoId': parentTodoId,
    'sortOrder': sortOrder,
    'tagsJson': jsonEncode(tags),
    'recurrenceRule': recurrenceRule,
    'reminderEnabled': reminderEnabled ? 1 : 0,
    'reminderAt': reminderAt?.toIso8601String(),
    'colorTag': colorTag,
    'sourceRecordId': sourceRecordId,
    'metadataJson': metadataJson,
    'subtasks': subtasks.map((s) => s.toJson()).toList(),
  };

  factory Todo.fromJson(Map<String, dynamic> json) {
    List<String> parsedTags = [];
    if (json['tagsJson'] != null) {
      try {
        final decoded = jsonDecode(json['tagsJson'] as String);
        if (decoded is List) {
          parsedTags = decoded.map((e) => e.toString()).toList();
        }
      } catch (_) {}
    } else if (json['tags'] is List) {
      parsedTags = (json['tags'] as List).map((e) => e.toString()).toList();
    }

    List<TodoSubtask> parsedSubtasks = [];
    if (json['subtasks'] is List) {
      parsedSubtasks = (json['subtasks'] as List)
          .map((s) => TodoSubtask.fromJson(Map<String, dynamic>.from(s as Map)))
          .toList();
    }

    return Todo(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      status: TodoStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => TodoStatus.pending,
      ),
      priority: TodoPriority.values.firstWhere(
        (e) => e.name == json['priority'],
        orElse: () => TodoPriority.normal,
      ),
      folderId: json['folderId'] as String?,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : DateTime.now(),
      completedAt: json['completedAt'] != null
          ? DateTime.parse(json['completedAt'] as String)
          : null,
      dueAt: json['dueAt'] != null
          ? DateTime.parse(json['dueAt'] as String)
          : null,
      isPinned: json['isPinned'] == 1 || json['isPinned'] == true,
      isArchived: json['isArchived'] == 1 || json['isArchived'] == true,
      isDeleted: json['isDeleted'] == 1 || json['isDeleted'] == true,
      parentTodoId: json['parentTodoId'] as String?,
      sortOrder: json['sortOrder'] as int? ?? 0,
      tags: parsedTags,
      recurrenceRule: json['recurrenceRule'] as String?,
      reminderEnabled: json['reminderEnabled'] == 1 || json['reminderEnabled'] == true,
      reminderAt: json['reminderAt'] != null
          ? DateTime.parse(json['reminderAt'] as String)
          : null,
      colorTag: json['colorTag'] as String?,
      sourceRecordId: json['sourceRecordId'] as String?,
      metadataJson: json['metadataJson'] as String?,
      subtasks: parsedSubtasks,
    );
  }
}
