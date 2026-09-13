import 'package:uuid/uuid.dart';

class Folder {
  final String id;
  final String name;
  final String iconId;
  final String colorTag;
  final DateTime createdAt;

  Folder({
    String? id,
    required this.name,
    required this.iconId,
    required this.colorTag,
    DateTime? createdAt,
  })  : id = id ?? const Uuid().v4(),
        createdAt = createdAt ?? DateTime.now();

  Folder copyWith({
    String? id,
    String? name,
    String? iconId,
    String? colorTag,
    DateTime? createdAt,
  }) {
    return Folder(
      id: id ?? this.id,
      name: name ?? this.name,
      iconId: iconId ?? this.iconId,
      colorTag: colorTag ?? this.colorTag,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'iconId': iconId,
    'colorTag': colorTag,
    'createdAt': createdAt.toIso8601String(),
  };

  factory Folder.fromJson(Map<String, dynamic> json) {
    return Folder(
      id: json['id'] as String,
      name: json['name'] as String,
      iconId: json['iconId'] as String? ?? 'folder',
      colorTag: json['colorTag'] as String? ?? '#006A60',
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : DateTime.now(),
    );
  }
}
