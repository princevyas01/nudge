import '../../domain/entities/pending_action.dart';
import '../../domain/repositories/i_pending_action_repository.dart';
import '../database/app_database.dart';

class PendingActionRepositoryImpl implements IPendingActionRepository {
  @override
  Future<List<PendingAction>> getAllPendingActions() async {
    final db = await AppDatabase.database;
    final rows = await db.query('pending_actions', orderBy: 'createdAt ASC');
    return rows.map((r) => PendingAction.fromJson(r)).toList();
  }

  @override
  Future<void> addPendingAction(PendingAction action) async {
    final db = await AppDatabase.database;
    await db.insert('pending_actions', action.toJson());
  }

  @override
  Future<void> removePendingAction(String id) async {
    final db = await AppDatabase.database;
    await db.delete('pending_actions', where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<void> clearPendingActions() async {
    final db = await AppDatabase.database;
    await db.delete('pending_actions');
  }
}
