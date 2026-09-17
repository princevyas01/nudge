import 'package:flutter/material.dart';
import '../theme/nudge_theme.dart';

class NudgeCard extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final Color? color;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final double borderRadius;
  final Border? border;

  const NudgeCard({
    super.key,
    required this.child,
    this.onTap,
    this.backgroundColor,
    this.color,
    this.padding = const EdgeInsets.all(16.0),
    this.margin = const EdgeInsets.symmetric(vertical: 6.0),
    this.borderRadius = NudgeTheme.radiusL,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final bg = color ?? backgroundColor ?? (isDark ? NudgeTheme.surfaceDark : NudgeTheme.surfaceLight);
    final defaultBorder = border ??
        Border.all(
          color: isDark ? NudgeTheme.cardBorderDark : NudgeTheme.cardBorderLight,
          width: 1.0,
        );

    Widget content = Container(
      padding: padding,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(borderRadius),
        border: defaultBorder,
      ),
      child: child,
    );

    if (onTap != null) {
      content = Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(borderRadius),
          onTap: onTap,
          child: content,
        ),
      );
    }

    return Padding(
      padding: margin,
      child: content,
    );
  }
}
