import 'package:sqflite/sqflite.dart';
import '../../core/logging/app_logger.dart';
import '../../domain/entities/todo.dart';
import '../../domain/entities/todo_subtask.dart';
import '../../domain/repositories/i_todo_repository.dart';
import '../database/app_database.dart';

class TodoRepositoryImpl implements ITodoRepository {
  static const String _subsystem = 'TodoRepo';

  @override
  Future<List<Todo>> getAllTodos({bool includeDeleted = false}) async {
    final db = await AppDatabase.database;
    final where = includeDeleted ? null : 'isDeleted = 0';
    final results = await db.query(
      'todos',
      where: where,
      orderBy: 'isPinned DESC, sortOrder ASC, createdAt DESC',
    );

    final List<Todo> todos = [];
    for (final row in results) {
      final id = row['id'] as String;
      final subtasks = await getSubtasksForTodo(id);
      final jsonMap = Map<String, dynamic>.from(row);
      jsonMap['subtasks'] = subtasks.map((s) => s.toJson()).toList();
      todos.add(Todo.fromJson(jsonMap));
    }
    return todos;
  }

  @override
  Future<Todo?> getTodoById(String id) async {
    final db = await AppDatabase.database;
    final results = await db.query('todos', where: 'id = ?', whereArgs: [id], limit: 1);
    if (results.isEmpty) return null;

    final subtasks = await getSubtasksForTodo(id);
    final jsonMap = Map<String, dynamic>.from(results.first);
    jsonMap['subtasks'] = subtasks.map((s) => s.toJson()).toList();
    return Todo.fromJson(jsonMap);
  }

  @override
  Future<void> createTodo(Todo todo) async {
    final db = await AppDatabase.database;
    await db.transaction((txn) async {
      final data = todo.toJson();
      data.remove('subtasks');
      await txn.insert('todos', data, conflictAlgorithm: ConflictAlgorithm.replace);

      for (final subtask in todo.subtasks) {
        await txn.insert(
          'todo_subtasks',
          subtask.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    });
    AppLogger.info(_subsystem, 'Created todo: ${todo.id}');
  }

  @override
  Future<void> updateTodo(Todo todo) async {
    final db = await AppDatabase.database;
    final data = todo.toJson();
    data.remove('subtasks');
    await db.update('todos', data, where: 'id = ?', whereArgs: [todo.id]);
    AppLogger.info(_subsystem, 'Updated todo: ${todo.id}');
  }

  @override
  Future<void> deleteTodo(String id, {bool hardDelete = false}) async {
    final db = await AppDatabase.database;
    if (hardDelete) {
      await db.delete('todo_subtasks', where: 'todoId = ?', whereArgs: [id]);
      await db.delete('todos', where: 'id = ?', whereArgs: [id]);
      AppLogger.info(_subsystem, 'Hard deleted todo: $id');
    } else {
      await db.update(
        'todos',
        {
          'isDeleted': 1,
          'updatedAt': DateTime.now().toIso8601String(),
        },
        where: 'id = ?',
        whereArgs: [id],
      );
      AppLogger.info(_subsystem, 'Soft deleted todo: $id');
    }
  }

  @override
  Future<void> restoreTodo(String id) async {
    final db = await AppDatabase.database;
    await db.update(
      'todos',
      {
        'isDeleted': 0,
        'updatedAt': DateTime.now().toIso8601String(),
      },
      where: 'id = ?',
      whereArgs: [id],
    );
    AppLogger.info(_subsystem, 'Restored todo: $id');
  }

  @override
  Future<void> purgeTrash() async {
    final db = await AppDatabase.database;
    final deleted = await db.query('todos', columns: ['id'], where: 'isDeleted = 1');
    for (final row in deleted) {
      final id = row['id'] as String;
      await db.delete('todo_subtasks', where: 'todoId = ?', whereArgs: [id]);
    }
    final count = await db.delete('todos', where: 'isDeleted = 1');
    AppLogger.info(_subsystem, 'Purged $count todos from trash');
  }

  @override
  Future<void> updateSortOrders(List<String> todoIds) async {
    final db = await AppDatabase.database;
    final batch = db.batch();
    for (int i = 0; i < todoIds.length; i++) {
      batch.update(
        'todos',
        {'sortOrder': i},
        where: 'id = ?',
        whereArgs: [todoIds[i]],
      );
    }
    await batch.commit(noResult: true);
  }

  // Subtasks operations
  @override
  Future<List<TodoSubtask>> getSubtasksForTodo(String todoId) async {
    final db = await AppDatabase.database;
    final results = await db.query(
      'todo_subtasks',
      where: 'todoId = ?',
      whereArgs: [todoId],
      orderBy: 'sortOrder ASC, createdAt ASC',
    );
    return results.map((row) => TodoSubtask.fromJson(Map<String, dynamic>.from(row))).toList();
  }

  @override
  Future<void> addSubtask(TodoSubtask subtask) async {
    final db = await AppDatabase.database;
    await db.insert('todo_subtasks', subtask.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  @override
  Future<void> updateSubtask(TodoSubtask subtask) async {
    final db = await AppDatabase.database;
    await db.update(
      'todo_subtasks',
      subtask.toJson(),
      where: 'id = ?',
      whereArgs: [subtask.id],
    );
  }

  @override
  Future<void> deleteSubtask(String id) async {
    final db = await AppDatabase.database;
    await db.delete('todo_subtasks', where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<void> updateSubtaskSortOrders(List<String> subtaskIds) async {
    final db = await AppDatabase.database;
    final batch = db.batch();
    for (int i = 0; i < subtaskIds.length; i++) {
      batch.update(
        'todo_subtasks',
        {'sortOrder': i},
        where: 'id = ?',
        whereArgs: [subtaskIds[i]],
      );
    }
    await batch.commit(noResult: true);
  }
}
