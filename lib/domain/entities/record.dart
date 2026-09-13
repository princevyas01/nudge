import 'package:uuid/uuid.dart';
import '../enums/todo_enums.dart';

class Record {
  final String id;
  final String title;
  final String content;
  final RecordType recordType;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? occurredAt;
  final bool isPinned;
  final bool isArchived;
  final bool isDeleted;
  final String? folderId;
  final String? colorTag;
  final String? source;
  final String? linkedReminderId;
  final String? linkedTodoId;
  final String? attachmentPath;
  final String? metadataJson;

  Record({
    String? id,
    required this.title,
    required this.content,
    this.recordType = RecordType.note,
    DateTime? createdAt,
    DateTime? updatedAt,
    this.occurredAt,
    this.isPinned = false,
    this.isArchived = false,
    this.isDeleted = false,
    this.folderId,
    this.colorTag,
    this.source,
    this.linkedReminderId,
    this.linkedTodoId,
    this.attachmentPath,
    this.metadataJson,
  })  : id = id ?? const Uuid().v4(),
        createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  Record copyWith({
    String? id,
    String? title,
    String? content,
    RecordType? recordType,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? occurredAt,
    bool? isPinned,
    bool? isArchived,
    bool? isDeleted,
    String? folderId,
    String? colorTag,
    String? source,
    String? linkedReminderId,
    String? linkedTodoId,
    String? attachmentPath,
    String? metadataJson,
  }) {
    return Record(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      recordType: recordType ?? this.recordType,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? DateTime.now(),
      occurredAt: occurredAt ?? this.occurredAt,
      isPinned: isPinned ?? this.isPinned,
      isArchived: isArchived ?? this.isArchived,
      isDeleted: isDeleted ?? this.isDeleted,
      folderId: folderId ?? this.folderId,
      colorTag: colorTag ?? this.colorTag,
      source: source ?? this.source,
      linkedReminderId: linkedReminderId ?? this.linkedReminderId,
      linkedTodoId: linkedTodoId ?? this.linkedTodoId,
      attachmentPath: attachmentPath ?? this.attachmentPath,
      metadataJson: metadataJson ?? this.metadataJson,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'content': content,
    'recordType': recordType.name,
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
    'occurredAt': occurredAt?.toIso8601String(),
    'isPinned': isPinned ? 1 : 0,
    'isArchived': isArchived ? 1 : 0,
    'isDeleted': isDeleted ? 1 : 0,
    'folderId': folderId,
    'colorTag': colorTag,
    'source': source,
    'linkedReminderId': linkedReminderId,
    'linkedTodoId': linkedTodoId,
    'attachmentPath': attachmentPath,
    'metadataJson': metadataJson,
  };

  factory Record.fromJson(Map<String, dynamic> json) {
    return Record(
      id: json['id'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      recordType: RecordType.values.firstWhere(
        (e) => e.name == json['recordType'],
        orElse: () => RecordType.note,
      ),
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : DateTime.now(),
      occurredAt: json['occurredAt'] != null
          ? DateTime.parse(json['occurredAt'] as String)
          : null,
      isPinned: json['isPinned'] == 1 || json['isPinned'] == true,
      isArchived: json['isArchived'] == 1 || json['isArchived'] == true,
      isDeleted: json['isDeleted'] == 1 || json['isDeleted'] == true,
      folderId: json['folderId'] as String?,
      colorTag: json['colorTag'] as String?,
      source: json['source'] as String?,
      linkedReminderId: json['linkedReminderId'] as String?,
      linkedTodoId: json['linkedTodoId'] as String?,
      attachmentPath: json['attachmentPath'] as String?,
      metadataJson: json['metadataJson'] as String?,
    );
  }
}
