import '../../domain/entities/reminder.dart';
import '../../domain/entities/checklist_item.dart';
import '../../domain/repositories/i_reminder_repository.dart';
import '../database/app_database.dart';

class ReminderRepositoryImpl implements IReminderRepository {
  @override
  Future<List<Reminder>> getAllReminders() async {
    final db = await AppDatabase.database;
    final reminderRows = await db.query('reminders', orderBy: 'scheduledAt ASC');
    if (reminderRows.isEmpty) return [];

    final checklistRows = await db.query('checklist_items');
    final checklistByReminder = <String, List<ChecklistItem>>{};
    for (final row in checklistRows) {
      final rId = row['reminderId'] as String;
      checklistByReminder.putIfAbsent(rId, () => []).add(
        ChecklistItem(
          id: row['id'] as String,
          text: row['text'] as String,
          isDone: (row['isDone'] as int) == 1,
        ),
      );
    }

    return reminderRows.map((row) {
      final rId = row['id'] as String;
      final map = Map<String, dynamic>.from(row);
      map['checklist'] = checklistByReminder[rId]?.map((c) => c.toJson()).toList() ?? [];
      return Reminder.fromJson(map);
    }).toList();
  }

  @override
  Future<Reminder?> getReminderById(String id) async {
    final db = await AppDatabase.database;
    final reminderRows = await db.query('reminders', where: 'id = ?', whereArgs: [id]);
    if (reminderRows.isEmpty) return null;

    final checklistRows = await db.query('checklist_items', where: 'reminderId = ?', whereArgs: [id]);
    final checklist = checklistRows.map((r) => ChecklistItem(
      id: r['id'] as String,
      text: r['text'] as String,
      isDone: (r['isDone'] as int) == 1,
    )).toList();

    final map = Map<String, dynamic>.from(reminderRows.first);
    map['checklist'] = checklist.map((c) => c.toJson()).toList();
    return Reminder.fromJson(map);
  }

  @override
  Future<void> saveReminder(Reminder reminder) async {
    final db = await AppDatabase.database;
    await db.transaction((txn) async {
      final reminderData = reminder.toJson();
      reminderData.remove('checklist'); // Handled separately in checklist_items table
      await txn.insert('reminders', reminderData);

      for (final item in reminder.checklist) {
        await txn.insert('checklist_items', {
          'id': item.id,
          'reminderId': reminder.id,
          'text': item.text,
          'isDone': item.isDone ? 1 : 0,
        });
      }
    });
  }

  @override
  Future<void> updateReminder(Reminder reminder) async {
    final db = await AppDatabase.database;
    await db.transaction((txn) async {
      final reminderData = reminder.toJson();
      reminderData.remove('checklist');
      await txn.update('reminders', reminderData, where: 'id = ?', whereArgs: [reminder.id]);

      // Re-sync checklist items
      await txn.delete('checklist_items', where: 'reminderId = ?', whereArgs: [reminder.id]);
      for (final item in reminder.checklist) {
        await txn.insert('checklist_items', {
          'id': item.id,
          'reminderId': reminder.id,
          'text': item.text,
          'isDone': item.isDone ? 1 : 0,
        });
      }
    });
  }

  @override
  Future<void> deleteReminder(String id) async {
    final db = await AppDatabase.database;
    await db.delete('reminders', where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<void> clearAllReminders() async {
    final db = await AppDatabase.database;
    await db.transaction((txn) async {
      await txn.delete('checklist_items');
      await txn.delete('reminders');
    });
  }
}
