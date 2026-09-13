import 'package:uuid/uuid.dart';

class ChecklistItem {
  final String id;
  final String text;
  final bool isDone;

  const ChecklistItem({
    required this.id,
    required this.text,
    this.isDone = false,
  });

  factory ChecklistItem.create({required String text, bool isDone = false}) {
    return ChecklistItem(
      id: const Uuid().v4(),
      text: text,
      isDone: isDone,
    );
  }

  ChecklistItem copyWith({
    String? id,
    String? text,
    bool? isDone,
  }) {
    return ChecklistItem(
      id: id ?? this.id,
      text: text ?? this.text,
      isDone: isDone ?? this.isDone,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'text': text,
    'isDone': isDone ? 1 : 0,
  };

  factory ChecklistItem.fromJson(Map<String, dynamic> json) {
    return ChecklistItem(
      id: json['id'] as String? ?? const Uuid().v4(),
      text: json['text'] as String? ?? '',
      isDone: json['isDone'] == 1 || json['isDone'] == true,
    );
  }
}
