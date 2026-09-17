import '../entities/record.dart';

abstract class IRecordRepository {
  Future<List<Record>> getAllRecords({bool includeDeleted = false});
  Future<Record?> getRecordById(String id);
  Future<void> createRecord(Record record);
  Future<void> updateRecord(Record record);
  Future<void> deleteRecord(String id, {bool hardDelete = false});
  Future<void> restoreRecord(String id);
  Future<void> purgeTrash();
}
