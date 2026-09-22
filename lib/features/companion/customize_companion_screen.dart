import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../application/controllers/companion_controller.dart';
import '../../core/constants/app_constants.dart';
import '../../presentation/components/mascot_widget.dart';
import '../../presentation/components/nudge_button.dart';
import '../../presentation/components/nudge_card.dart';
import '../../presentation/components/nudge_text_field.dart';

class CustomizeCompanionScreen extends StatefulWidget {
  const CustomizeCompanionScreen({super.key});

  @override
  State<CustomizeCompanionScreen> createState() => _CustomizeCompanionScreenState();
}

class _CustomizeCompanionScreenState extends State<CustomizeCompanionScreen> {
  late TextEditingController _nameController;
  bool _isEditingName = false;

  final Map<String, Map<String, dynamic>> _cosmeticDetails = {
    'bandana': {
      'name': 'Explorer Bandana',
      'description': 'A stylish red bandana for adventurous days.',
      'icon': Icons.bookmark,
      'requirement': 3,
    },
    'neon_shades': {
      'name': 'Cyber Neon Shades',
      'description': 'Futuristic cool sunglasses for maximum focus.',
      'icon': Icons.visibility,
      'requirement': 8,
    },
    'headphones': {
      'name': 'Lo-Fi Headset',
      'description': 'Premium noise-cancelling studio headphones.',
      'icon': Icons.headphones,
      'requirement': 15,
    },
    'wizard_hat': {
      'name': 'Arcane Wizard Hat',
      'description': 'Magical starry cone hat for productivity wizards.',
      'icon': Icons.auto_fix_high,
      'requirement': 25,
    },
    'ninja_band': {
      'name': 'Shadow Shinobi Band',
      'description': 'Stealth headband for slicing through distractions.',
      'icon': Icons.sports_martial_arts,
      'requirement': 40,
    },
    'astronaut_helmet': {
      'name': 'Cosmic Space Helmet',
      'description': 'Interstellar bubble helmet for reaching the stars.',
      'icon': Icons.rocket_launch,
      'requirement': 60,
    },
    'sparkle_aura': {
      'name': 'Celestial Aura',
      'description': 'A glittering field of sparkles acknowledging dedication.',
      'icon': Icons.auto_awesome,
      'requirement': 80,
    },
    'crown': {
      'name': 'Emperor Golden Crown',
      'description': 'Reserved for champions of relentless consistency.',
      'icon': Icons.military_tech,
      'requirement': 100,
    },
    'flame_aura': {
      'name': 'Phoenix Flame Aura',
      'description': 'An intense burning aura of pure unstoppable momentum.',
      'icon': Icons.local_fire_department,
      'requirement': 150,
    },
    'golden_trophy': {
      'name': 'Master Achiever Trophy',
      'description': 'The ultimate badge of the master achiever.',
      'icon': Icons.emoji_events,
      'requirement': 200,
    },
  };

  @override
  void initState() {
    super.initState();
    final companion = context.read<CompanionController>();
    _nameController = TextEditingController(text: companion.profile.name);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _saveName(CompanionController controller) async {
    final newName = _nameController.text.trim();
    if (newName.isNotEmpty) {
      await controller.updateName(newName);
      setState(() => _isEditingName = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Companion renamed to $newName!'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final companion = context.watch<CompanionController>();
    final profile = companion.profile;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mascot & Companion'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Mascot Interactive Preview Card
            NudgeCard(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              child: Column(
                children: [
                  MascotWidget(
                    mood: companion.currentMood,
                    equippedCosmetic: profile.equippedCosmetic,
                    size: 130,
                    onTap: () {
                      companion.triggerTapReaction();
                    },
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surfaceContainerHighest.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: theme.colorScheme.outlineVariant.withOpacity(0.5)),
                    ),
                    child: Text(
                      '"${companion.currentDialogue}"',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Tap ${profile.name} to interact!',
                    style: theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.outline),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Name Editing Card
            NudgeCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Companion Identity',
                        style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        icon: Icon(_isEditingName ? Icons.close : Icons.edit_outlined),
                        onPressed: () {
                          setState(() {
                            _isEditingName = !_isEditingName;
                            if (!_isEditingName) {
                              _nameController.text = profile.name;
                            }
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  if (_isEditingName) ...[
                    NudgeTextField(
                      controller: _nameController,
                      hintText: 'Enter name',
                      prefixIcon: const Icon(Icons.pets),
                    ),
                    const SizedBox(height: 12),
                    NudgeButton(
                      label: 'Save Name',
                      icon: Icons.check,
                      onPressed: () => _saveName(companion),
                    ),
                  ] else ...[
                    Text(
                      profile.name,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Your personal reminder companion and accountability buddy.',
                      style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Stats Matrix
            Row(
              children: [
                Expanded(
                  child: NudgeCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.local_fire_department, color: theme.colorScheme.error, size: 28),
                        const SizedBox(height: 8),
                        Text(
                          '${profile.currentStreak}',
                          style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Day Streak',
                          style: theme.textTheme.labelMedium?.copyWith(color: theme.colorScheme.outline),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: NudgeCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.ac_unit, color: theme.colorScheme.tertiary, size: 28),
                        const SizedBox(height: 8),
                        Text(
                          '${profile.streakFreezes}',
                          style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Freezes Left',
                          style: theme.textTheme.labelMedium?.copyWith(color: theme.colorScheme.outline),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: NudgeCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.check_circle_outline, color: theme.colorScheme.primary, size: 28),
                        const SizedBox(height: 8),
                        Text(
                          '${profile.lifetimeCompletions}',
                          style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Finished',
                          style: theme.textTheme.labelMedium?.copyWith(color: theme.colorScheme.outline),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Cosmetics Section
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Accessories & Milestones',
                style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 12),

            // None / Unequip Option
            NudgeCard(
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.block, size: 24),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Default Look', style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
                        Text('No accessories equipped', style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.outline)),
                      ],
                    ),
                  ),
                  if (profile.equippedCosmetic == null)
                    Chip(
                      label: const Text('Equipped'),
                      backgroundColor: theme.colorScheme.primaryContainer,
                      labelStyle: TextStyle(color: theme.colorScheme.onPrimaryContainer, fontWeight: FontWeight.bold),
                    )
                  else
                    OutlinedButton(
                      onPressed: () => companion.equipCosmetic(null),
                      child: const Text('Equip'),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // Cosmetics list
            ...AppConstants.cosmeticMilestones.entries.map((entry) {
              final requiredCount = entry.key;
              final cosmeticId = entry.value;
              final info = _cosmeticDetails[cosmeticId] ?? {
                'name': cosmeticId,
                'description': 'Milestone accessory',
                'icon': Icons.star,
                'requirement': requiredCount,
              };

              final isUnlocked = profile.unlockedCosmetics.contains(cosmeticId) || profile.lifetimeCompletions >= requiredCount;
              final isEquipped = profile.equippedCosmetic == cosmeticId;
              final progress = (profile.lifetimeCompletions / requiredCount).clamp(0.0, 1.0);

              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: NudgeCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: isUnlocked ? theme.colorScheme.primaryContainer : theme.colorScheme.surfaceContainerHighest,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              info['icon'] as IconData,
                              color: isUnlocked ? theme.colorScheme.primary : theme.colorScheme.outline,
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      info['name'] as String,
                                      style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                                    ),
                                    if (!isUnlocked) ...[
                                      const SizedBox(width: 6),
                                      Icon(Icons.lock, size: 14, color: theme.colorScheme.outline),
                                    ],
                                  ],
                                ),
                                Text(
                                  info['description'] as String,
                                  style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.outline),
                                ),
                              ],
                            ),
                          ),
                          if (isEquipped)
                            Chip(
                              label: const Text('Equipped'),
                              backgroundColor: theme.colorScheme.primaryContainer,
                              labelStyle: TextStyle(color: theme.colorScheme.onPrimaryContainer, fontWeight: FontWeight.bold),
                            )
                          else if (isUnlocked)
                            FilledButton.tonal(
                              onPressed: () => companion.equipCosmetic(cosmeticId),
                              child: const Text('Equip'),
                            )
                          else
                            Text(
                              '${profile.lifetimeCompletions}/$requiredCount',
                              style: theme.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.bold),
                            ),
                        ],
                      ),
                      if (!isUnlocked) ...[
                        const SizedBox(height: 12),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: progress,
                            minHeight: 6,
                            backgroundColor: theme.colorScheme.surfaceContainerHighest,
                            valueColor: AlwaysStoppedAnimation(theme.colorScheme.primary),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
