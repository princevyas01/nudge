import 'package:flutter_test/flutter_test.dart';
import 'package:nudge/domain/entities/todo.dart';
import 'package:nudge/domain/entities/todo_subtask.dart';
import 'package:nudge/domain/enums/todo_enums.dart';

void main() {
  group('Todo & TodoSubtask Unit Tests', () {
    test('Todo default values and copyWith', () {
      final todo = Todo(title: 'Write test suite');

      expect(todo.title, 'Write test suite');
      expect(todo.status, TodoStatus.pending);
      expect(todo.priority, TodoPriority.normal);
      expect(todo.isDone, false);
      expect(todo.isPinned, false);
      expect(todo.isArchived, false);
      expect(todo.isDeleted, false);
      expect(todo.hasSubtasks, false);
      expect(todo.subtasksProgress, 0.0);

      final updated = todo.copyWith(
        status: TodoStatus.completed,
        priority: TodoPriority.urgent,
        isPinned: true,
      );

      expect(updated.status, TodoStatus.completed);
      expect(updated.isDone, true);
      expect(updated.priority, TodoPriority.urgent);
      expect(updated.isPinned, true);
    });

    test('Subtask calculation and progress', () {
      final subtasks = [
        TodoSubtask(todoId: 't1', text: 'Step 1', isDone: true),
        TodoSubtask(todoId: 't1', text: 'Step 2', isDone: false),
        TodoSubtask(todoId: 't1', text: 'Step 3', isDone: true),
        TodoSubtask(todoId: 't1', text: 'Step 4', isDone: false),
      ];

      final todo = Todo(
        id: 't1',
        title: 'Project Setup',
        subtasks: subtasks,
      );

      expect(todo.hasSubtasks, true);
      expect(todo.completedSubtasksCount, 2);
      expect(todo.subtasksProgress, 0.5);
    });

    test('Due date and overdue detection', () {
      final now = DateTime.now();
      final pastDue = Todo(
        title: 'Past due task',
        dueAt: now.subtract(const Duration(hours: 2)),
      );
      expect(pastDue.isOverdue, true);

      final futureDue = Todo(
        title: 'Future task',
        dueAt: now.add(const Duration(days: 3)),
      );
      expect(futureDue.isOverdue, false);

      final todayDue = Todo(
        title: 'Today task',
        dueAt: DateTime(now.year, now.month, now.day, 23, 59),
      );
      expect(todayDue.isDueToday, true);
    });

    test('Serialization and deserialization roundtrip', () {
      final subtasks = [
        TodoSubtask(todoId: 'todo_123', text: 'Sub 1', isDone: true),
      ];

      final todo = Todo(
        id: 'todo_123',
        title: 'Complete Project',
        description: 'Detailed description here',
        status: TodoStatus.inProgress,
        priority: TodoPriority.high,
        folderId: 'folder_work',
        dueAt: DateTime(2026, 10, 15, 14, 30),
        tags: ['urgent', 'work'],
        subtasks: subtasks,
      );

      final json = todo.toJson();
      final restored = Todo.fromJson(json);

      expect(restored.id, todo.id);
      expect(restored.title, todo.title);
      expect(restored.description, todo.description);
      expect(restored.status, TodoStatus.inProgress);
      expect(restored.priority, TodoPriority.high);
      expect(restored.folderId, 'folder_work');
      expect(restored.tags, ['urgent', 'work']);
      expect(restored.subtasks.length, 1);
      expect(restored.subtasks.first.text, 'Sub 1');
      expect(restored.subtasks.first.isDone, true);
    });
  });
}
