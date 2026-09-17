import 'package:flutter/foundation.dart';
import '../../core/logging/app_logger.dart';
import '../../domain/entities/todo.dart';
import '../../domain/entities/todo_subtask.dart';
import '../../domain/enums/todo_enums.dart';
import '../../domain/repositories/i_todo_repository.dart';

class TodoController with ChangeNotifier {
  static const String _subsystem = 'TodoController';
  final ITodoRepository _todoRepo;

  List<Todo> _todos = [];
  bool _isLoading = false;
  TodoFilter _activeFilter = TodoFilter.all;
  String? _selectedFolderId;
  String? _selectedTag;
  String _searchQuery = '';

  TodoController({required ITodoRepository todoRepo}) : _todoRepo = todoRepo;

  List<Todo> get todos => _todos;
  bool get isLoading => _isLoading;
  TodoFilter get activeFilter => _activeFilter;
  String? get selectedFolderId => _selectedFolderId;
  String? get selectedTag => _selectedTag;
  String get searchQuery => _searchQuery;

  int get activeCount => _todos.where((t) => !t.isDeleted && !t.isArchived && !t.isDone).length;
  int get todayCount => _todos.where((t) => !t.isDeleted && !t.isArchived && !t.isDone && t.isDueToday).length;
  int get overdueCount => _todos.where((t) => !t.isDeleted && !t.isArchived && !t.isDone && t.isOverdue).length;
  int get completedCount => _todos.where((t) => !t.isDeleted && t.isDone).length;

  List<Todo> get filteredTodos {
    return _todos.where((t) {
      // Trash filter
      if (_activeFilter == TodoFilter.trash) {
        return t.isDeleted;
      }
      if (t.isDeleted) return false;

      // Archived filter
      if (_activeFilter == TodoFilter.archived) {
        return t.isArchived;
      }
      if (t.isArchived) return false;

      // Active status filter
      switch (_activeFilter) {
        case TodoFilter.all:
          break;
        case TodoFilter.today:
          if (!t.isDueToday) return false;
          break;
        case TodoFilter.upcoming:
          if (t.dueAt == null || !t.dueAt!.isAfter(DateTime.now())) return false;
          break;
        case TodoFilter.highPriority:
          if (t.priority != TodoPriority.high && t.priority != TodoPriority.urgent) return false;
          break;
        case TodoFilter.completed:
          if (!t.isDone) return false;
          break;
        case TodoFilter.archived:
        case TodoFilter.trash:
          break;
      }

      // Folder filter
      if (_selectedFolderId != null && t.folderId != _selectedFolderId) {
        return false;
      }

      // Tag filter
      if (_selectedTag != null && !t.tags.contains(_selectedTag)) {
        return false;
      }

      // Search query
      if (_searchQuery.isNotEmpty) {
        final query = _searchQuery.toLowerCase();
        final matchTitle = t.title.toLowerCase().contains(query);
        final matchDesc = t.description?.toLowerCase().contains(query) ?? false;
        final matchTag = t.tags.any((tag) => tag.toLowerCase().contains(query));
        if (!matchTitle && !matchDesc && !matchTag) return false;
      }

      return true;
    }).toList();
  }

  void setFilter(TodoFilter filter) {
    _activeFilter = filter;
    notifyListeners();
  }

  void setFolder(String? folderId) {
    _selectedFolderId = folderId;
    notifyListeners();
  }

  void setTag(String? tag) {
    _selectedTag = tag;
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query.trim();
    notifyListeners();
  }

  Future<void> loadTodos() async {
    _isLoading = true;
    notifyListeners();
    try {
      _todos = await _todoRepo.getAllTodos(includeDeleted: true);
      AppLogger.info(_subsystem, 'Loaded ${_todos.length} todos');
    } catch (e, st) {
      AppLogger.error(_subsystem, 'Failed to load todos', error: e, stackTrace: st);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> createTodo(Todo todo) async {
    try {
      await _todoRepo.createTodo(todo);
      _todos.insert(0, todo);
      notifyListeners();

      if (todo.reminderEnabled && todo.reminderAt != null) {
        _scheduleGentleTodoNotification(todo);
      }
    } catch (e, st) {
      AppLogger.error(_subsystem, 'Failed to create todo', error: e, stackTrace: st);
    }
  }

  Future<void> updateTodo(Todo todo) async {
    try {
      final updated = todo.copyWith(updatedAt: DateTime.now());
      await _todoRepo.updateTodo(updated);
      final index = _todos.indexWhere((t) => t.id == todo.id);
      if (index != -1) {
        _todos[index] = updated;
        notifyListeners();
      }
    } catch (e, st) {
      AppLogger.error(_subsystem, 'Failed to update todo', error: e, stackTrace: st);
    }
  }

  Future<void> toggleTodoStatus(String id) async {
    try {
      final index = _todos.indexWhere((t) => t.id == id);
      if (index == -1) return;

      final current = _todos[index];
      final newStatus = current.isDone ? TodoStatus.pending : TodoStatus.completed;
      final completedAt = newStatus == TodoStatus.completed ? DateTime.now() : null;

      final updated = current.copyWith(
        status: newStatus,
        completedAt: completedAt,
        updatedAt: DateTime.now(),
      );

      await _todoRepo.updateTodo(updated);
      _todos[index] = updated;
      notifyListeners();
    } catch (e, st) {
      AppLogger.error(_subsystem, 'Failed to toggle todo status', error: e, stackTrace: st);
    }
  }

  Future<void> togglePin(String id) async {
    try {
      final index = _todos.indexWhere((t) => t.id == id);
      if (index == -1) return;

      final current = _todos[index];
      final updated = current.copyWith(
        isPinned: !current.isPinned,
        updatedAt: DateTime.now(),
      );

      await _todoRepo.updateTodo(updated);
      _todos[index] = updated;
      _todos.sort((a, b) {
        if (a.isPinned != b.isPinned) {
          return b.isPinned ? 1 : -1;
        }
        return a.sortOrder.compareTo(b.sortOrder);
      });
      notifyListeners();
    } catch (e, st) {
      AppLogger.error(_subsystem, 'Failed to toggle pin', error: e, stackTrace: st);
    }
  }

  Future<void> toggleArchive(String id) async {
    try {
      final index = _todos.indexWhere((t) => t.id == id);
      if (index == -1) return;

      final current = _todos[index];
      final updated = current.copyWith(
        isArchived: !current.isArchived,
        updatedAt: DateTime.now(),
      );

      await _todoRepo.updateTodo(updated);
      _todos[index] = updated;
      notifyListeners();
    } catch (e, st) {
      AppLogger.error(_subsystem, 'Failed to toggle archive', error: e, stackTrace: st);
    }
  }

  Future<void> softDeleteTodo(String id) async {
    try {
      await _todoRepo.deleteTodo(id, hardDelete: false);
      final index = _todos.indexWhere((t) => t.id == id);
      if (index != -1) {
        _todos[index] = _todos[index].copyWith(isDeleted: true);
        notifyListeners();
      }
    } catch (e, st) {
      AppLogger.error(_subsystem, 'Failed to soft delete todo', error: e, stackTrace: st);
    }
  }

  Future<void> restoreTodo(String id) async {
    try {
      await _todoRepo.restoreTodo(id);
      final index = _todos.indexWhere((t) => t.id == id);
      if (index != -1) {
        _todos[index] = _todos[index].copyWith(isDeleted: false);
        notifyListeners();
      }
    } catch (e, st) {
      AppLogger.error(_subsystem, 'Failed to restore todo', error: e, stackTrace: st);
    }
  }

  Future<void> hardDeleteTodo(String id) async {
    try {
      await _todoRepo.deleteTodo(id, hardDelete: true);
      _todos.removeWhere((t) => t.id == id);
      notifyListeners();
    } catch (e, st) {
      AppLogger.error(_subsystem, 'Failed to hard delete todo', error: e, stackTrace: st);
    }
  }

  Future<void> purgeTrash() async {
    try {
      await _todoRepo.purgeTrash();
      _todos.removeWhere((t) => t.isDeleted);
      notifyListeners();
    } catch (e, st) {
      AppLogger.error(_subsystem, 'Failed to purge trash', error: e, stackTrace: st);
    }
  }

  // Subtask management
  Future<void> addSubtask(String todoId, String text) async {
    try {
      final index = _todos.indexWhere((t) => t.id == todoId);
      if (index == -1) return;

      final current = _todos[index];
      final newSubtask = TodoSubtask(
        todoId: todoId,
        text: text,
        sortOrder: current.subtasks.length,
      );

      await _todoRepo.addSubtask(newSubtask);
      final updatedSubtasks = List<TodoSubtask>.from(current.subtasks)..add(newSubtask);
      _todos[index] = current.copyWith(subtasks: updatedSubtasks);
      notifyListeners();
    } catch (e, st) {
      AppLogger.error(_subsystem, 'Failed to add subtask', error: e, stackTrace: st);
    }
  }

  Future<void> toggleSubtask(String todoId, String subtaskId) async {
    try {
      final index = _todos.indexWhere((t) => t.id == todoId);
      if (index == -1) return;

      final current = _todos[index];
      final subtaskIndex = current.subtasks.indexWhere((s) => s.id == subtaskId);
      if (subtaskIndex == -1) return;

      final s = current.subtasks[subtaskIndex];
      final updatedSubtask = s.copyWith(
        isDone: !s.isDone,
        completedAt: !s.isDone ? DateTime.now() : null,
      );

      await _todoRepo.updateSubtask(updatedSubtask);
      final updatedSubtasks = List<TodoSubtask>.from(current.subtasks);
      updatedSubtasks[subtaskIndex] = updatedSubtask;
      _todos[index] = current.copyWith(subtasks: updatedSubtasks);
      notifyListeners();
    } catch (e, st) {
      AppLogger.error(_subsystem, 'Failed to toggle subtask', error: e, stackTrace: st);
    }
  }

  Future<void> deleteSubtask(String todoId, String subtaskId) async {
    try {
      final index = _todos.indexWhere((t) => t.id == todoId);
      if (index == -1) return;

      await _todoRepo.deleteSubtask(subtaskId);
      final current = _todos[index];
      final updatedSubtasks = current.subtasks.where((s) => s.id != subtaskId).toList();
      _todos[index] = current.copyWith(subtasks: updatedSubtasks);
      notifyListeners();
    } catch (e, st) {
      AppLogger.error(_subsystem, 'Failed to delete subtask', error: e, stackTrace: st);
    }
  }

  void _scheduleGentleTodoNotification(Todo todo) {
    try {
      AppLogger.info(_subsystem, 'Gentle notification enabled for todo: ${todo.title}');
    } catch (e) {
      AppLogger.error(_subsystem, 'Could not configure notification', error: e);
    }
  }
}
