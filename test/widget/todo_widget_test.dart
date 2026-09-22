import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:nudge/application/controllers/folder_controller.dart';
import 'package:nudge/application/controllers/record_controller.dart';
import 'package:nudge/application/controllers/todo_controller.dart';
import 'package:nudge/domain/entities/folder.dart';
import 'package:nudge/domain/entities/record.dart';
import 'package:nudge/domain/entities/todo.dart';
import 'package:nudge/domain/entities/todo_subtask.dart';
import 'package:nudge/domain/enums/todo_enums.dart';
import 'package:nudge/domain/repositories/i_folder_repository.dart';
import 'package:nudge/domain/repositories/i_record_repository.dart';
import 'package:nudge/domain/repositories/i_todo_repository.dart';
import 'package:nudge/features/records/record_card.dart';
import 'package:nudge/features/todos/todo_card.dart';
import 'package:nudge/presentation/components/quick_add_sheet.dart';

class MockTodoRepo implements ITodoRepository {
  @override
  Future<void> addSubtask(TodoSubtask subtask) async {}
  @override
  Future<void> createTodo(Todo todo) async {}
  @override
  Future<void> deleteSubtask(String id) async {}
  @override
  Future<void> deleteTodo(String id, {bool hardDelete = false}) async {}
  @override
  Future<List<Todo>> getAllTodos({bool includeDeleted = false}) async => [];
  @override
  Future<List<TodoSubtask>> getSubtasksForTodo(String todoId) async => [];
  @override
  Future<Todo?> getTodoById(String id) async => null;
  @override
  Future<void> purgeTrash() async {}
  @override
  Future<void> restoreTodo(String id) async {}
  @override
  Future<void> updateSortOrders(List<String> todoIds) async {}
  @override
  Future<void> updateSubtask(TodoSubtask subtask) async {}
  @override
  Future<void> updateSubtaskSortOrders(List<String> subtaskIds) async {}
  @override
  Future<void> updateTodo(Todo todo) async {}
}

class MockRecordRepo implements IRecordRepository {
  @override
  Future<void> createRecord(Record record) async {}
  @override
  Future<void> deleteRecord(String id, {bool hardDelete = false}) async {}
  @override
  Future<List<Record>> getAllRecords({bool includeDeleted = false}) async => [];
  @override
  Future<Record?> getRecordById(String id) async => null;
  @override
  Future<void> purgeTrash() async {}
  @override
  Future<void> restoreRecord(String id) async {}
  @override
  Future<void> updateRecord(Record record) async {}
}

class MockFolderRepo implements IFolderRepository {
  @override
  Future<void> saveFolder(Folder folder) async {}
  @override
  Future<void> deleteFolder(String id, {required bool deleteContainedReminders}) async {}
  @override
  Future<List<Folder>> getAllFolders() async => [];
  @override
  Future<Folder?> getFolderById(String id) async => null;
  @override
  Future<void> updateFolder(Folder folder) async {}
  @override
  Future<void> clearAllFolders() async {}
}

void main() {
  testWidgets('TodoCard renders title, priority pill, and checkbox', (tester) async {
    final todo = Todo(
      id: 't_1',
      title: 'Finish client presentation',
      priority: TodoPriority.urgent,
      subtasks: [
        TodoSubtask(todoId: 't_1', text: 'Draft slides', isDone: true),
        TodoSubtask(todoId: 't_1', text: 'Rehearse speech', isDone: false),
      ],
    );

    final todoRepo = MockTodoRepo();
    final folderRepo = MockFolderRepo();
    final todoCtrl = TodoController(todoRepo: todoRepo);
    final folderCtrl = FolderController(folderRepo: folderRepo);

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: todoCtrl),
          ChangeNotifierProvider.value(value: folderCtrl),
        ],
        child: MaterialApp(
          home: Scaffold(
            body: TodoCard(todo: todo),
          ),
        ),
      ),
    );

    expect(find.text('Finish client presentation'), findsOneWidget);
    expect(find.text('Urgent'), findsOneWidget);
    expect(find.text('Subtasks: 1/2'), findsOneWidget);
    expect(find.byType(Checkbox), findsOneWidget);
  });

  testWidgets('RecordCard renders title, snippet, and type badge', (tester) async {
    final record = Record(
      id: 'r_1',
      title: 'App Architecture Thoughts',
      content: 'Using modular clean architecture with domain entities.',
      recordType: RecordType.idea,
    );

    final recordRepo = MockRecordRepo();
    final folderRepo = MockFolderRepo();
    final recordCtrl = RecordController(recordRepo: recordRepo);
    final folderCtrl = FolderController(folderRepo: folderRepo);

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: recordCtrl),
          ChangeNotifierProvider.value(value: folderCtrl),
        ],
        child: MaterialApp(
          home: Scaffold(
            body: RecordCard(record: record),
          ),
        ),
      ),
    );

    expect(find.text('App Architecture Thoughts'), findsOneWidget);
    expect(find.text('Idea'), findsOneWidget);
    expect(find.text('Using modular clean architecture with domain entities.'), findsOneWidget);
  });

  testWidgets('QuickAddSheet renders all four quick action options', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: QuickAddSheet(),
        ),
      ),
    );

    expect(find.text('Quick Add'), findsOneWidget);
    expect(find.text('Reminder Alarm'), findsOneWidget);
    expect(find.text('Task / Todo'), findsOneWidget);
    expect(find.text('Record / Note'), findsOneWidget);
    expect(find.text('Focus Timer'), findsOneWidget);
  });
}
