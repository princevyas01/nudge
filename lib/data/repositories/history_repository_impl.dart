import '../../domain/entities/reminder_history.dart';
import '../../domain/repositories/i_history_repository.dart';
import '../database/app_database.dart';

class HistoryRepositoryImpl implements IHistoryRepository {
  @override
  Future<List<ReminderHistory>> getAllHistory() async {
    final db = await AppDatabase.database;
    final rows = await db.query('reminder_history', orderBy: 'timestamp DESC');
    return rows.map((r) => ReminderHistory.fromJson(r)).toList();
  }

  @override
  Future<List<ReminderHistory>> getHistoryForReminder(String reminderId) async {
    final db = await AppDatabase.database;
    final rows = await db.query(
      'reminder_history',
      where: 'reminderId = ?',
      whereArgs: [reminderId],
      orderBy: 'timestamp DESC',
    );
    return rows.map((r) => ReminderHistory.fromJson(r)).toList();
  }

  @override
  Future<void> logEvent(ReminderHistory event) async {
    final db = await AppDatabase.database;
    await db.insert('reminder_history', event.toJson());
  }

  @override
  Future<void> clearHistory() async {
    final db = await AppDatabase.database;
    await db.delete('reminder_history');
  }
}
