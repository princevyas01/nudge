import 'package:sqflite/sqflite.dart';
import '../../core/logging/app_logger.dart';
import '../../domain/entities/record.dart';
import '../../domain/repositories/i_record_repository.dart';
import '../database/app_database.dart';

class RecordRepositoryImpl implements IRecordRepository {
  static const String _subsystem = 'RecordRepo';

  @override
  Future<List<Record>> getAllRecords({bool includeDeleted = false}) async {
    final db = await AppDatabase.database;
    final where = includeDeleted ? null : 'isDeleted = 0';
    final results = await db.query(
      'records',
      where: where,
      orderBy: 'isPinned DESC, occurredAt DESC, createdAt DESC',
    );
    return results.map((row) => Record.fromJson(Map<String, dynamic>.from(row))).toList();
  }

  @override
  Future<Record?> getRecordById(String id) async {
    final db = await AppDatabase.database;
    final results = await db.query('records', where: 'id = ?', whereArgs: [id], limit: 1);
    if (results.isEmpty) return null;
    return Record.fromJson(Map<String, dynamic>.from(results.first));
  }

  @override
  Future<void> createRecord(Record record) async {
    final db = await AppDatabase.database;
    await db.insert('records', record.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
    AppLogger.info(_subsystem, 'Created record: ${record.id}');
  }

  @override
  Future<void> updateRecord(Record record) async {
    final db = await AppDatabase.database;
    await db.update(
      'records',
      record.toJson(),
      where: 'id = ?',
      whereArgs: [record.id],
    );
    AppLogger.info(_subsystem, 'Updated record: ${record.id}');
  }

  @override
  Future<void> deleteRecord(String id, {bool hardDelete = false}) async {
    final db = await AppDatabase.database;
    if (hardDelete) {
      await db.delete('records', where: 'id = ?', whereArgs: [id]);
      AppLogger.info(_subsystem, 'Hard deleted record: $id');
    } else {
      await db.update(
        'records',
        {
          'isDeleted': 1,
          'updatedAt': DateTime.now().toIso8601String(),
        },
        where: 'id = ?',
        whereArgs: [id],
      );
      AppLogger.info(_subsystem, 'Soft deleted record: $id');
    }
  }

  @override
  Future<void> restoreRecord(String id) async {
    final db = await AppDatabase.database;
    await db.update(
      'records',
      {
        'isDeleted': 0,
        'updatedAt': DateTime.now().toIso8601String(),
      },
      where: 'id = ?',
      whereArgs: [id],
    );
    AppLogger.info(_subsystem, 'Restored record: $id');
  }

  @override
  Future<void> purgeTrash() async {
    final db = await AppDatabase.database;
    final count = await db.delete('records', where: 'isDeleted = 1');
    AppLogger.info(_subsystem, 'Purged $count records from trash');
  }
}
