import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../application/controllers/companion_controller.dart';
import '../../domain/enums/enums.dart';
import '../theme/nudge_theme.dart';

class MascotWidget extends StatefulWidget {
  final CompanionMood? mood;
  final String? equippedCosmetic;
  final double size;
  final VoidCallback? onTap;
  final bool showBubble;

  const MascotWidget({
    super.key,
    this.mood,
    this.equippedCosmetic,
    this.size = 56.0,
    this.onTap,
    this.showBubble = false,
  });

  @override
  State<MascotWidget> createState() => _MascotWidgetState();
}

class _MascotWidgetState extends State<MascotWidget> with TickerProviderStateMixin {
  late AnimationController _floatController;
  late Animation<double> _floatAnimation;

  late AnimationController _actionController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _tiltAnimation;

  late AnimationController _celebrationController;
  late Animation<double> _spinAnimation;

  bool _isTapped = false;

  @override
  void initState() {
    super.initState();

    // Idle floating/breathing animation
    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    )..repeat(reverse: true);

    _floatAnimation = Tween<double>(begin: -3.0, end: 3.0).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOutSine),
    );

    // Tap action: squash and stretch bounce + tilt wiggle
    _actionController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.84), weight: 30),
      TweenSequenceItem(tween: Tween(begin: 0.84, end: 1.15), weight: 40),
      TweenSequenceItem(tween: Tween(begin: 1.15, end: 1.0), weight: 30),
    ]).animate(CurvedAnimation(parent: _actionController, curve: Curves.easeOut));

    _tiltAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: -0.12), weight: 25),
      TweenSequenceItem(tween: Tween(begin: -0.12, end: 0.12), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 0.12, end: 0.0), weight: 25),
    ]).animate(CurvedAnimation(parent: _actionController, curve: Curves.easeInOut));

    // Celebration 360 spin
    _celebrationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _spinAnimation = Tween<double>(begin: 0.0, end: 2 * math.pi).animate(
      CurvedAnimation(parent: _celebrationController, curve: Curves.easeInOutBack),
    );
  }

  @override
  void dispose() {
    _floatController.dispose();
    _actionController.dispose();
    _celebrationController.dispose();
    super.dispose();
  }

  void _handleTap(CompanionController controller) {
    _actionController.forward(from: 0.0);
    setState(() => _isTapped = true);

    if (widget.mood == CompanionMood.celebratory || controller.currentMood == CompanionMood.celebratory) {
      _celebrationController.forward(from: 0.0);
    }

    if (widget.onTap != null) {
      widget.onTap!();
    } else {
      controller.triggerTapReaction();
    }

    Future.delayed(const Duration(milliseconds: 1400), () {
      if (mounted) setState(() => _isTapped = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<CompanionController>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final effectiveMood = widget.mood ?? controller.currentMood;
    final effectiveCosmetic = widget.equippedCosmetic ?? controller.profile.equippedCosmetic;

    // Trigger celebration spin if mood transitions to celebratory
    if (effectiveMood == CompanionMood.celebratory && !_celebrationController.isAnimating) {
      _celebrationController.forward(from: 0.0);
    }

    // Dynamic Face expressions
    String moodFace = '( •_• )';
    if (_isTapped) {
      moodFace = '( ^_~ )';
    } else if (effectiveMood == CompanionMood.happy) {
      moodFace = '( ^‿^ )';
    } else if (effectiveMood == CompanionMood.celebratory) {
      moodFace = '＼(★^∀^★)／';
    } else if (effectiveMood == CompanionMood.sleepy) {
      moodFace = '( -_- )zzZ';
    } else if (controller.profile.currentStreak >= 5) {
      moodFace = '(ง •̀_•́)ง';
    }

    final avatarWidget = GestureDetector(
      onTap: () => _handleTap(controller),
      child: AnimatedBuilder(
        animation: Listenable.merge([_floatAnimation, _scaleAnimation, _tiltAnimation, _spinAnimation]),
        builder: (context, child) {
          final floatOffset = _floatAnimation.value;
          final scale = _scaleAnimation.value;
          final tilt = _tiltAnimation.value + _spinAnimation.value;
          final cosmetic = effectiveCosmetic;

          return Transform.translate(
            offset: Offset(0, floatOffset),
            child: Transform.rotate(
              angle: tilt,
              child: Transform.scale(
                scale: scale,
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    // Aura Glow Effect if special aura is equipped
                    if (cosmetic == 'sparkle_aura' || cosmetic == 'flame_aura')
                      _buildAuraEffect(cosmetic!, widget.size),

                    // Mascot Base Circle
                    Container(
                      width: widget.size,
                      height: widget.size,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: isDark
                              ? [NudgeTheme.primaryContainer, NudgeTheme.surfaceDark]
                              : [NudgeTheme.secondaryContainer, Colors.teal.shade100],
                        ),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: (isDark ? Colors.tealAccent : Colors.teal).withOpacity(0.2),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                        border: Border.all(
                          color: (isDark ? Colors.tealAccent : Colors.teal).withOpacity(0.3),
                          width: 1.5,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        moodFace,
                        style: TextStyle(
                          fontSize: widget.size * 0.23,
                          fontWeight: FontWeight.bold,
                          color: isDark ? NudgeTheme.onPrimaryContainer : NudgeTheme.onSecondaryContainer,
                        ),
                      ),
                    ),

                    // Detailed Cosmetic Overlay
                    if (cosmetic != null)
                      _buildCosmeticOverlay(cosmetic, widget.size),

                    // Tap Sparkle Particle Burst
                    if (_isTapped)
                      Positioned(
                        top: -widget.size * 0.15,
                        right: -widget.size * 0.1,
                        child: const Icon(Icons.auto_awesome, color: Colors.amber, size: 18),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );

    if (!widget.showBubble) {
      return avatarWidget;
    }

    return GestureDetector(
      onTap: () => _handleTap(controller),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: isDark ? NudgeTheme.surfaceDark : NudgeTheme.surfaceLight,
          borderRadius: BorderRadius.circular(NudgeTheme.radiusXL),
          border: Border.all(
            color: isDark ? NudgeTheme.cardBorderDark : NudgeTheme.cardBorderLight,
            width: 1.0,
          ),
        ),
        child: Row(
          children: [
            avatarWidget,
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        controller.profile.name,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: isDark ? NudgeTheme.onPrimaryContainer : NudgeTheme.secondary,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.orange.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.local_fire_department, size: 14, color: Colors.orange),
                            const SizedBox(width: 4),
                            Text(
                              '${controller.profile.currentStreak}d',
                              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.orange),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    controller.currentDialogue,
                    style: TextStyle(
                      fontSize: 13,
                      height: 1.3,
                      color: isDark ? NudgeTheme.onBgDark : NudgeTheme.onBgLight,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAuraEffect(String auraType, double s) {
    if (auraType == 'flame_aura') {
      return Container(
        width: s * 1.25,
        height: s * 1.25,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [
              Colors.orange.withOpacity(0.45),
              Colors.deepOrange.withOpacity(0.2),
              Colors.transparent,
            ],
          ),
        ),
      );
    }
    // sparkle_aura
    return Container(
      width: s * 1.28,
      height: s * 1.28,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            Colors.amber.withOpacity(0.4),
            Colors.yellow.withOpacity(0.15),
            Colors.transparent,
          ],
        ),
      ),
    );
  }

  Widget _buildCosmeticOverlay(String cosmeticId, double s) {
    switch (cosmeticId) {
      case 'crown':
        return Positioned(
          top: -s * 0.28,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: s * 0.08, vertical: s * 0.04),
            decoration: BoxDecoration(
              color: Colors.amber.shade400,
              borderRadius: BorderRadius.circular(8),
              boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 4)],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.military_tech, size: s * 0.32, color: Colors.amber.shade900),
              ],
            ),
          ),
        );

      case 'neon_shades':
        return Positioned(
          top: s * 0.32,
          child: Container(
            width: s * 0.72,
            height: s * 0.22,
            decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: Colors.cyanAccent, width: 1.5),
              boxShadow: [
                BoxShadow(color: Colors.cyan.withOpacity(0.5), blurRadius: 6),
              ],
            ),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(width: s * 0.26, height: s * 0.12, color: Colors.cyanAccent.withOpacity(0.7)),
                Container(width: s * 0.26, height: s * 0.12, color: Colors.purpleAccent.withOpacity(0.7)),
              ],
            ),
          ),
        );

      case 'headphones':
        return Positioned(
          top: -s * 0.08,
          child: SizedBox(
            width: s * 1.15,
            height: s * 0.7,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: s * 0.2,
                  height: s * 0.32,
                  decoration: BoxDecoration(
                    color: Colors.indigoAccent,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                Container(
                  width: s * 0.2,
                  height: s * 0.32,
                  decoration: BoxDecoration(
                    color: Colors.indigoAccent,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ],
            ),
          ),
        );

      case 'wizard_hat':
        return Positioned(
          top: -s * 0.32,
          child: Icon(Icons.auto_fix_high, size: s * 0.36, color: Colors.deepPurpleAccent),
        );

      case 'ninja_band':
        return Positioned(
          top: s * 0.12,
          child: Container(
            width: s * 0.85,
            height: s * 0.12,
            decoration: BoxDecoration(
              color: Colors.red.shade900,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: Colors.white70, width: 1),
            ),
          ),
        );

      case 'astronaut_helmet':
        return Positioned(
          top: -s * 0.08,
          child: Container(
            width: s * 1.12,
            height: s * 1.12,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.lightBlueAccent.withOpacity(0.8), width: 2.5),
            ),
          ),
        );

      case 'golden_trophy':
        return Positioned(
          top: -s * 0.25,
          right: -s * 0.15,
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: const BoxDecoration(
              color: Colors.amber,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.emoji_events, size: s * 0.28, color: Colors.brown.shade900),
          ),
        );

      case 'bandana':
        return Positioned(
          top: s * 0.1,
          child: Container(
            width: s * 0.78,
            height: s * 0.12,
            decoration: BoxDecoration(
              color: Colors.redAccent,
              borderRadius: BorderRadius.circular(6),
            ),
          ),
        );

      case 'flame_aura':
        return Positioned(
          top: -s * 0.22,
          child: const Icon(Icons.local_fire_department, color: Colors.deepOrange, size: 24),
        );

      case 'sparkle_aura':
      default:
        return Positioned(
          top: -s * 0.12,
          right: -s * 0.1,
          child: const Icon(Icons.auto_awesome, color: Colors.amber, size: 22),
        );
    }
  }
}

