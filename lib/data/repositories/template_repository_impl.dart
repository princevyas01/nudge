import 'dart:convert';
import '../../domain/entities/reminder_template.dart';
import '../../domain/entities/checklist_item.dart';
import '../../domain/enums/enums.dart';
import '../../domain/repositories/i_template_repository.dart';
import '../database/app_database.dart';

class TemplateRepositoryImpl implements ITemplateRepository {
  @override
  Future<List<ReminderTemplate>> getAllTemplates() async {
    final db = await AppDatabase.database;
    final rows = await db.query('reminder_templates');
    return rows.map((row) {
      final checklistRaw = row['checklistJson'] as String?;
      List<ChecklistItem> checklist = [];
      if (checklistRaw != null && checklistRaw.isNotEmpty) {
        try {
          final list = jsonDecode(checklistRaw) as List;
          checklist = list.map((e) => ChecklistItem.fromJson(Map<String, dynamic>.from(e as Map))).toList();
        } catch (_) {}
      }

      return ReminderTemplate(
        id: row['id'] as String,
        title: row['title'] as String,
        message: row['message'] as String,
        priority: PriorityLevel.values.firstWhere(
          (e) => e.name == row['priority'],
          orElse: () => PriorityLevel.normal,
        ),
        alertStyle: AlertStyle.values.firstWhere(
          (e) => e.name == row['alertStyle'],
          orElse: () => AlertStyle.alarm,
        ),
        repeatRule: RepeatRule.values.firstWhere(
          (e) => e.name == row['repeatRule'],
          orElse: () => RepeatRule.none,
        ),
        checklist: checklist,
      );
    }).toList();
  }

  @override
  Future<void> saveTemplate(ReminderTemplate template) async {
    final db = await AppDatabase.database;
    await db.insert('reminder_templates', {
      'id': template.id,
      'title': template.title,
      'message': template.message,
      'priority': template.priority.name,
      'alertStyle': template.alertStyle.name,
      'repeatRule': template.repeatRule.name,
      'checklistJson': jsonEncode(template.checklist.map((e) => e.toJson()).toList()),
    });
  }

  @override
  Future<void> deleteTemplate(String id) async {
    final db = await AppDatabase.database;
    await db.delete('reminder_templates', where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<void> clearTemplates() async {
    final db = await AppDatabase.database;
    await db.delete('reminder_templates');
  }
}
