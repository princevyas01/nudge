import 'package:flutter/foundation.dart';
import '../../domain/entities/folder.dart';
import '../../domain/repositories/i_folder_repository.dart';
import '../../core/logging/app_logger.dart';

class FolderController extends ChangeNotifier {
  static const String _subsystem = 'FolderController';
  final IFolderRepository _folderRepo;

  List<Folder> _folders = [];
  List<Folder> get folders => List.unmodifiable(_folders);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  FolderController({required IFolderRepository folderRepo}) : _folderRepo = folderRepo;

  Future<void> loadFolders() async {
    _isLoading = true;
    notifyListeners();
    try {
      _folders = await _folderRepo.getAllFolders();
      AppLogger.info(_subsystem, 'Loaded ${_folders.length} folders');
    } catch (e, stack) {
      AppLogger.error(_subsystem, 'Failed to load folders', error: e, stackTrace: stack);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Folder? getFolderById(String? id) {
    if (id == null) return null;
    try {
      return _folders.firstWhere((f) => f.id == id);
    } catch (_) {
      return null;
    }
  }

  Future<void> createFolder(Folder folder) async {
    await _folderRepo.saveFolder(folder);
    _folders.add(folder);
    notifyListeners();
  }

  Future<void> updateFolder(Folder folder) async {
    final idx = _folders.indexWhere((f) => f.id == folder.id);
    if (idx == -1) return;
    await _folderRepo.updateFolder(folder);
    _folders[idx] = folder;
    notifyListeners();
  }

  Future<void> deleteFolder(String id, {required bool deleteContainedReminders}) async {
    await _folderRepo.deleteFolder(id, deleteContainedReminders: deleteContainedReminders);
    _folders.removeWhere((f) => f.id == id);
    notifyListeners();
  }
}
