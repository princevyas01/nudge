import '../entities/todo.dart';
import '../entities/todo_subtask.dart';

abstract class ITodoRepository {
  Future<List<Todo>> getAllTodos({bool includeDeleted = false});
  Future<Todo?> getTodoById(String id);
  Future<void> createTodo(Todo todo);
  Future<void> updateTodo(Todo todo);
  Future<void> deleteTodo(String id, {bool hardDelete = false});
  Future<void> restoreTodo(String id);
  Future<void> purgeTrash();
  Future<void> updateSortOrders(List<String> todoIds);

  // Subtasks
  Future<List<TodoSubtask>> getSubtasksForTodo(String todoId);
  Future<void> addSubtask(TodoSubtask subtask);
  Future<void> updateSubtask(TodoSubtask subtask);
  Future<void> deleteSubtask(String id);
  Future<void> updateSubtaskSortOrders(List<String> subtaskIds);
}
