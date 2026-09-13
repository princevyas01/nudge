class CompanionProfile {
  final String name;
  final int lifetimeCompletions;
  final int currentStreak;
  final int streakFreezes;
  final String? equippedCosmetic;
  final List<String> unlockedCosmetics;
  final DateTime? lastActiveDate;

  const CompanionProfile({
    this.name = 'Nudge',
    this.lifetimeCompletions = 0,
    this.currentStreak = 0,
    this.streakFreezes = 2,
    this.equippedCosmetic,
    this.unlockedCosmetics = const ['bandana'],
    this.lastActiveDate,
  });

  CompanionProfile copyWith({
    String? name,
    int? lifetimeCompletions,
    int? currentStreak,
    int? streakFreezes,
    String? equippedCosmetic,
    bool clearEquipped = false,
    List<String>? unlockedCosmetics,
    DateTime? lastActiveDate,
  }) {
    return CompanionProfile(
      name: name ?? this.name,
      lifetimeCompletions: lifetimeCompletions ?? this.lifetimeCompletions,
      currentStreak: currentStreak ?? this.currentStreak,
      streakFreezes: streakFreezes ?? this.streakFreezes,
      equippedCosmetic: clearEquipped ? null : (equippedCosmetic ?? this.equippedCosmetic),
      unlockedCosmetics: unlockedCosmetics ?? this.unlockedCosmetics,
      lastActiveDate: lastActiveDate ?? this.lastActiveDate,
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'lifetimeCompletions': lifetimeCompletions,
    'currentStreak': currentStreak,
    'streakFreezes': streakFreezes,
    'equippedCosmetic': equippedCosmetic,
    'unlockedCosmetics': unlockedCosmetics,
    'lastActiveDate': lastActiveDate?.toIso8601String(),
  };

  factory CompanionProfile.fromJson(Map<String, dynamic> json) {
    return CompanionProfile(
      name: json['name'] as String? ?? 'Nudge',
      lifetimeCompletions: (json['lifetimeCompletions'] as num?)?.toInt() ?? 0,
      currentStreak: (json['currentStreak'] as num?)?.toInt() ?? 0,
      streakFreezes: (json['streakFreezes'] as num?)?.toInt() ?? 2,
      equippedCosmetic: json['equippedCosmetic'] as String?,
      unlockedCosmetics: (json['unlockedCosmetics'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      lastActiveDate: json['lastActiveDate'] != null
          ? DateTime.parse(json['lastActiveDate'] as String)
          : null,
    );
  }
}
