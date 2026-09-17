import 'package:sqflite/sqflite.dart';
import '../../domain/entities/reminder_occurrence.dart';
import '../../domain/repositories/i_occurrence_repository.dart';
import '../database/app_database.dart';

class OccurrenceRepositoryImpl implements IOccurrenceRepository {
  @override
  Future<List<ReminderOccurrence>> getAllOccurrences() async {
    final db = await AppDatabase.database;
    final maps = await db.query('reminder_occurrences', orderBy: 'scheduledAt ASC');
    return maps.map((m) => ReminderOccurrence.fromJson(m)).toList();
  }

  @override
  Future<List<ReminderOccurrence>> getOccurrencesForReminder(String reminderId) async {
    final db = await AppDatabase.database;
    final maps = await db.query(
      'reminder_occurrences',
      where: 'reminderId = ?',
      whereArgs: [reminderId],
      orderBy: 'scheduledAt ASC',
    );
    return maps.map((m) => ReminderOccurrence.fromJson(m)).toList();
  }

  @override
  Future<ReminderOccurrence?> getOccurrenceById(String id) async {
    final db = await AppDatabase.database;
    final maps = await db.query(
      'reminder_occurrences',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isEmpty) return null;
    return ReminderOccurrence.fromJson(maps.first);
  }

  @override
  Future<ReminderOccurrence?> getPendingOccurrence(String reminderId) async {
    final db = await AppDatabase.database;
    final maps = await db.query(
      'reminder_occurrences',
      where: 'reminderId = ? AND status = ?',
      whereArgs: [reminderId, 'pending'],
      orderBy: 'scheduledAt ASC',
      limit: 1,
    );
    if (maps.isEmpty) return null;
    return ReminderOccurrence.fromJson(maps.first);
  }

  @override
  Future<void> saveOccurrence(ReminderOccurrence occurrence) async {
    final db = await AppDatabase.database;
    await db.insert(
      'reminder_occurrences',
      occurrence.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> updateOccurrence(ReminderOccurrence occurrence) async {
    final db = await AppDatabase.database;
    await db.update(
      'reminder_occurrences',
      occurrence.toJson(),
      where: 'id = ?',
      whereArgs: [occurrence.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> deleteOccurrence(String id) async {
    final db = await AppDatabase.database;
    await db.delete(
      'reminder_occurrences',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<void> deleteOccurrencesForReminder(String reminderId) async {
    final db = await AppDatabase.database;
    await db.delete(
      'reminder_occurrences',
      where: 'reminderId = ?',
      whereArgs: [reminderId],
    );
  }
}
