import 'package:flutter/foundation.dart';
import '../../core/logging/app_logger.dart';
import '../../domain/entities/record.dart';
import '../../domain/enums/todo_enums.dart';
import '../../domain/repositories/i_record_repository.dart';

class RecordController with ChangeNotifier {
  static const String _subsystem = 'RecordController';
  final IRecordRepository _recordRepo;

  List<Record> _records = [];
  bool _isLoading = false;
  RecordFilter _activeFilter = RecordFilter.all;
  String? _selectedFolderId;
  String _searchQuery = '';

  RecordController({required IRecordRepository recordRepo}) : _recordRepo = recordRepo;

  List<Record> get records => _records;
  bool get isLoading => _isLoading;
  RecordFilter get activeFilter => _activeFilter;
  String? get selectedFolderId => _selectedFolderId;
  String get searchQuery => _searchQuery;

  int get totalActiveCount => _records.where((r) => !r.isDeleted && !r.isArchived).length;

  List<Record> get filteredRecords {
    return _records.where((r) {
      // Trash filter
      if (_activeFilter == RecordFilter.trash) {
        return r.isDeleted;
      }
      if (r.isDeleted) return false;

      // Archived filter
      if (_activeFilter == RecordFilter.archived) {
        return r.isArchived;
      }
      if (r.isArchived) return false;

      // Type filter
      switch (_activeFilter) {
        case RecordFilter.all:
          break;
        case RecordFilter.notes:
          if (r.recordType != RecordType.note) return false;
          break;
        case RecordFilter.ideas:
          if (r.recordType != RecordType.idea) return false;
          break;
        case RecordFilter.thoughts:
          if (r.recordType != RecordType.thought) return false;
          break;
        case RecordFilter.logs:
          if (r.recordType != RecordType.log) return false;
          break;
        case RecordFilter.snippets:
          if (r.recordType != RecordType.snippet) return false;
          break;
        case RecordFilter.decisions:
          if (r.recordType != RecordType.decision) return false;
          break;
        case RecordFilter.archived:
        case RecordFilter.trash:
          break;
      }

      // Folder filter
      if (_selectedFolderId != null && r.folderId != _selectedFolderId) {
        return false;
      }

      // Search query
      if (_searchQuery.isNotEmpty) {
        final query = _searchQuery.toLowerCase();
        final matchTitle = r.title.toLowerCase().contains(query);
        final matchContent = r.content.toLowerCase().contains(query);
        if (!matchTitle && !matchContent) return false;
      }

      return true;
    }).toList();
  }

  void setFilter(RecordFilter filter) {
    _activeFilter = filter;
    notifyListeners();
  }

  void setFolder(String? folderId) {
    _selectedFolderId = folderId;
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query.trim();
    notifyListeners();
  }

  Future<void> loadRecords() async {
    _isLoading = true;
    notifyListeners();
    try {
      _records = await _recordRepo.getAllRecords(includeDeleted: true);
      AppLogger.info(_subsystem, 'Loaded ${_records.length} records');
    } catch (e, st) {
      AppLogger.error(_subsystem, 'Failed to load records', error: e, stackTrace: st);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> createRecord(Record record) async {
    try {
      await _recordRepo.createRecord(record);
      _records.insert(0, record);
      notifyListeners();
    } catch (e, st) {
      AppLogger.error(_subsystem, 'Failed to create record', error: e, stackTrace: st);
    }
  }

  Future<Record> quickCapture(
    String text, {
    RecordType type = RecordType.note,
    String? folderId,
  }) async {
    final lines = text.trim().split('\n');
    final title = lines.first.trim();
    final content = lines.length > 1 ? lines.skip(1).join('\n').trim() : '';

    final record = Record(
      title: title.isEmpty ? 'Untitled Note' : title,
      content: content.isEmpty && lines.length == 1 ? title : content,
      recordType: type,
      folderId: folderId,
      occurredAt: DateTime.now(),
    );

    await createRecord(record);
    return record;
  }

  Future<void> updateRecord(Record record) async {
    try {
      final updated = record.copyWith(updatedAt: DateTime.now());
      await _recordRepo.updateRecord(updated);
      final index = _records.indexWhere((r) => r.id == record.id);
      if (index != -1) {
        _records[index] = updated;
        notifyListeners();
      }
    } catch (e, st) {
      AppLogger.error(_subsystem, 'Failed to update record', error: e, stackTrace: st);
    }
  }

  Future<void> togglePin(String id) async {
    try {
      final index = _records.indexWhere((r) => r.id == id);
      if (index == -1) return;

      final current = _records[index];
      final updated = current.copyWith(
        isPinned: !current.isPinned,
        updatedAt: DateTime.now(),
      );

      await _recordRepo.updateRecord(updated);
      _records[index] = updated;
      _records.sort((a, b) {
        if (a.isPinned != b.isPinned) {
          return b.isPinned ? 1 : -1;
        }
        return b.createdAt.compareTo(a.createdAt);
      });
      notifyListeners();
    } catch (e, st) {
      AppLogger.error(_subsystem, 'Failed to toggle pin on record', error: e, stackTrace: st);
    }
  }

  Future<void> toggleArchive(String id) async {
    try {
      final index = _records.indexWhere((r) => r.id == id);
      if (index == -1) return;

      final current = _records[index];
      final updated = current.copyWith(
        isArchived: !current.isArchived,
        updatedAt: DateTime.now(),
      );

      await _recordRepo.updateRecord(updated);
      _records[index] = updated;
      notifyListeners();
    } catch (e, st) {
      AppLogger.error(_subsystem, 'Failed to toggle archive on record', error: e, stackTrace: st);
    }
  }

  Future<void> softDeleteRecord(String id) async {
    try {
      await _recordRepo.deleteRecord(id, hardDelete: false);
      final index = _records.indexWhere((r) => r.id == id);
      if (index != -1) {
        _records[index] = _records[index].copyWith(isDeleted: true);
        notifyListeners();
      }
    } catch (e, st) {
      AppLogger.error(_subsystem, 'Failed to soft delete record', error: e, stackTrace: st);
    }
  }

  Future<void> restoreRecord(String id) async {
    try {
      await _recordRepo.restoreRecord(id);
      final index = _records.indexWhere((r) => r.id == id);
      if (index != -1) {
        _records[index] = _records[index].copyWith(isDeleted: false);
        notifyListeners();
      }
    } catch (e, st) {
      AppLogger.error(_subsystem, 'Failed to restore record', error: e, stackTrace: st);
    }
  }

  Future<void> hardDeleteRecord(String id) async {
    try {
      await _recordRepo.deleteRecord(id, hardDelete: true);
      _records.removeWhere((r) => r.id == id);
      notifyListeners();
    } catch (e, st) {
      AppLogger.error(_subsystem, 'Failed to hard delete record', error: e, stackTrace: st);
    }
  }

  Future<void> purgeTrash() async {
    try {
      await _recordRepo.purgeTrash();
      _records.removeWhere((r) => r.isDeleted);
      notifyListeners();
    } catch (e, st) {
      AppLogger.error(_subsystem, 'Failed to purge record trash', error: e, stackTrace: st);
    }
  }
}
