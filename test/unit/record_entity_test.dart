import 'package:flutter_test/flutter_test.dart';
import 'package:nudge/domain/entities/record.dart';
import 'package:nudge/domain/enums/todo_enums.dart';

void main() {
  group('Record Entity Unit Tests', () {
    test('Record defaults and copyWith', () {
      final record = Record(
        title: 'Meeting Notes',
        content: 'Discussed roadmap and milestones.',
      );

      expect(record.title, 'Meeting Notes');
      expect(record.content, 'Discussed roadmap and milestones.');
      expect(record.recordType, RecordType.note);
      expect(record.isPinned, false);
      expect(record.isArchived, false);
      expect(record.isDeleted, false);

      final updated = record.copyWith(
        recordType: RecordType.decision,
        isPinned: true,
      );

      expect(updated.recordType, RecordType.decision);
      expect(updated.isPinned, true);
    });

    test('Serialization and deserialization roundtrip', () {
      final record = Record(
        id: 'rec_456',
        title: 'System Architecture',
        content: 'Use SQLite offline-first database with clean layers.',
        recordType: RecordType.idea,
        folderId: 'folder_general',
        occurredAt: DateTime(2026, 9, 12, 10, 0),
        isPinned: true,
      );

      final json = record.toJson();
      final restored = Record.fromJson(json);

      expect(restored.id, 'rec_456');
      expect(restored.title, record.title);
      expect(restored.content, record.content);
      expect(restored.recordType, RecordType.idea);
      expect(restored.folderId, 'folder_general');
      expect(restored.isPinned, true);
    });
  });
}
