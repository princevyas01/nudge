import 'package:uuid/uuid.dart';

class Tag {
  final String id;
  final String name;
  final String colorTag;
  final DateTime createdAt;

  Tag({
    String? id,
    required this.name,
    this.colorTag = '#006A60',
    DateTime? createdAt,
  })  : id = id ?? const Uuid().v4(),
        createdAt = createdAt ?? DateTime.now();

  Tag copyWith({
    String? id,
    String? name,
    String? colorTag,
    DateTime? createdAt,
  }) {
    return Tag(
      id: id ?? this.id,
      name: name ?? this.name,
      colorTag: colorTag ?? this.colorTag,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'colorTag': colorTag,
    'createdAt': createdAt.toIso8601String(),
  };

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(
      id: json['id'] as String,
      name: json['name'] as String,
      colorTag: json['colorTag'] as String? ?? '#006A60',
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : DateTime.now(),
    );
  }
}
