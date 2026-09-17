import '../entities/tag.dart';

abstract class ITagRepository {
  Future<List<Tag>> getAllTags();
  Future<Tag?> getTagByName(String name);
  Future<void> createTag(Tag tag);
  Future<void> deleteTag(String id);
  Future<List<String>> getTagsForEntity(String entityType, String entityId);
  Future<void> setTagsForEntity(String entityType, String entityId, List<String> tagIds);
}
