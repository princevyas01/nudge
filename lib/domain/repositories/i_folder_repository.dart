import '../entities/folder.dart';

abstract class IFolderRepository {
  Future<List<Folder>> getAllFolders();
  Future<Folder?> getFolderById(String id);
  Future<void> saveFolder(Folder folder);
  Future<void> updateFolder(Folder folder);
  Future<void> deleteFolder(String id, {required bool deleteContainedReminders});
  Future<void> clearAllFolders();
}
