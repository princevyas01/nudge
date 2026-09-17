import '../../domain/entities/folder.dart';
import '../../domain/repositories/i_folder_repository.dart';
import '../../core/constants/app_constants.dart';
import '../database/app_database.dart';

class FolderRepositoryImpl implements IFolderRepository {
  @override
  Future<List<Folder>> getAllFolders() async {
    final db = await AppDatabase.database;
    final rows = await db.query('folders', orderBy: 'createdAt ASC');
    return rows.map((r) => Folder.fromJson(r)).toList();
  }

  @override
  Future<Folder?> getFolderById(String id) async {
    final db = await AppDatabase.database;
    final rows = await db.query('folders', where: 'id = ?', whereArgs: [id]);
    if (rows.isEmpty) return null;
    return Folder.fromJson(rows.first);
  }

  @override
  Future<void> saveFolder(Folder folder) async {
    final db = await AppDatabase.database;
    await db.insert('folders', folder.toJson());
  }

  @override
  Future<void> updateFolder(Folder folder) async {
    final db = await AppDatabase.database;
    await db.update('folders', folder.toJson(), where: 'id = ?', whereArgs: [folder.id]);
  }

  @override
  Future<void> deleteFolder(String id, {required bool deleteContainedReminders}) async {
    final db = await AppDatabase.database;
    await db.transaction((txn) async {
      if (deleteContainedReminders) {
        await txn.delete('reminders', where: 'folderId = ?', whereArgs: [id]);
      } else {
        // Move to General folder
        await txn.update(
          'reminders',
          {'folderId': AppConstants.generalFolderId},
          where: 'folderId = ?',
          whereArgs: [id],
        );
      }
      await txn.delete('folders', where: 'id = ?', whereArgs: [id]);
    });
  }

  @override
  Future<void> clearAllFolders() async {
    final db = await AppDatabase.database;
    await db.delete('folders');
  }
}
