import '../entities/reminder_template.dart';

abstract class ITemplateRepository {
  Future<List<ReminderTemplate>> getAllTemplates();
  Future<void> saveTemplate(ReminderTemplate template);
  Future<void> deleteTemplate(String id);
  Future<void> clearTemplates();
}
