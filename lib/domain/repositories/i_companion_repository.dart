import '../entities/companion_profile.dart';

abstract class ICompanionRepository {
  Future<CompanionProfile> getProfile();
  Future<void> saveProfile(CompanionProfile profile);
  Future<void> resetProfile();
}
