import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';
import '../../core/logging/app_logger.dart';
import '../../domain/entities/tag.dart';
import '../../domain/repositories/i_tag_repository.dart';
import '../database/app_database.dart';

class TagRepositoryImpl implements ITagRepository {
  static const String _subsystem = 'TagRepo';

  @override
  Future<List<Tag>> getAllTags() async {
    final db = await AppDatabase.database;
    final results = await db.query('tags', orderBy: 'name ASC');
    return results.map((row) => Tag.fromJson(Map<String, dynamic>.from(row))).toList();
  }

  @override
  Future<Tag?> getTagByName(String name) async {
    final db = await AppDatabase.database;
    final results = await db.query(
      'tags',
      where: 'LOWER(name) = ?',
      whereArgs: [name.trim().toLowerCase()],
      limit: 1,
    );
    if (results.isEmpty) return null;
    return Tag.fromJson(Map<String, dynamic>.from(results.first));
  }

  @override
  Future<void> createTag(Tag tag) async {
    final db = await AppDatabase.database;
    await db.insert('tags', tag.toJson(), conflictAlgorithm: ConflictAlgorithm.ignore);
    AppLogger.info(_subsystem, 'Created tag: ${tag.name}');
  }

  @override
  Future<void> deleteTag(String id) async {
    final db = await AppDatabase.database;
    await db.transaction((txn) async {
      await txn.delete('entity_tags', where: 'tagId = ?', whereArgs: [id]);
      await txn.delete('tags', where: 'id = ?', whereArgs: [id]);
    });
    AppLogger.info(_subsystem, 'Deleted tag: $id');
  }

  @override
  Future<List<String>> getTagsForEntity(String entityType, String entityId) async {
    final db = await AppDatabase.database;
    final results = await db.rawQuery('''
      SELECT t.name FROM tags t
      INNER JOIN entity_tags et ON t.id = et.tagId
      WHERE et.entityType = ? AND et.entityId = ?
      ORDER BY t.name ASC
    ''', [entityType, entityId]);
    return results.map((row) => row['name'] as String).toList();
  }

  @override
  Future<void> setTagsForEntity(String entityType, String entityId, List<String> tagIds) async {
    final db = await AppDatabase.database;
    await db.transaction((txn) async {
      await txn.delete(
        'entity_tags',
        where: 'entityType = ? AND entityId = ?',
        whereArgs: [entityType, entityId],
      );
      for (final tagId in tagIds) {
        await txn.insert('entity_tags', {
          'id': const Uuid().v4(),
          'tagId': tagId,
          'entityType': entityType,
          'entityId': entityId,
        });
      }
    });
  }
}
