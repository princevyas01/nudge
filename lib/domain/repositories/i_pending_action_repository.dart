import '../entities/pending_action.dart';

abstract class IPendingActionRepository {
  Future<List<PendingAction>> getAllPendingActions();
  Future<void> addPendingAction(PendingAction action);
  Future<void> removePendingAction(String id);
  Future<void> clearPendingActions();
}
