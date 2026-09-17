import 'dart:convert';
import '../../domain/entities/companion_profile.dart';
import '../../domain/repositories/i_companion_repository.dart';
import 'package:sqflite/sqflite.dart';
import '../database/app_database.dart';

class CompanionRepositoryImpl implements ICompanionRepository {
  @override
  Future<CompanionProfile> getProfile() async {
    final db = await AppDatabase.database;
    final rows = await db.query('companion_profile', where: 'id = 1');
    if (rows.isEmpty) {
      return const CompanionProfile();
    }
    final row = rows.first;
    List<String> unlocked = [];
    try {
      final raw = row['unlockedCosmeticsJson'] as String?;
      if (raw != null) {
        unlocked = (jsonDecode(raw) as List).map((e) => e.toString()).toList();
      }
    } catch (_) {}

    return CompanionProfile(
      name: row['name'] as String? ?? 'Nudge',
      lifetimeCompletions: (row['lifetimeCompletions'] as int?) ?? 0,
      currentStreak: (row['currentStreak'] as int?) ?? 0,
      streakFreezes: (row['streakFreezes'] as int?) ?? 2,
      equippedCosmetic: row['equippedCosmetic'] as String?,
      unlockedCosmetics: unlocked,
      lastActiveDate: row['lastActiveDate'] != null ? DateTime.parse(row['lastActiveDate'] as String) : null,
    );
  }

  @override
  Future<void> saveProfile(CompanionProfile profile) async {
    final db = await AppDatabase.database;
    await db.insert(
      'companion_profile',
      {
        'id': 1,
        'name': profile.name,
        'lifetimeCompletions': profile.lifetimeCompletions,
        'currentStreak': profile.currentStreak,
        'streakFreezes': profile.streakFreezes,
        'equippedCosmetic': profile.equippedCosmetic,
        'unlockedCosmeticsJson': jsonEncode(profile.unlockedCosmetics),
        'lastActiveDate': profile.lastActiveDate?.toIso8601String(),
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> resetProfile() async {
    final db = await AppDatabase.database;
    await db.update(
      'companion_profile',
      {
        'name': 'Nudge',
        'lifetimeCompletions': 0,
        'currentStreak': 0,
        'streakFreezes': 2,
        'equippedCosmetic': null,
        'unlockedCosmeticsJson': '[]',
        'lastActiveDate': null,
      },
      where: 'id = 1',
    );
  }
}
