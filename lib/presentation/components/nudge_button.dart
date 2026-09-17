import 'package:flutter/material.dart';
import '../theme/nudge_theme.dart';

enum ButtonVariant { primary, secondary, danger, outline }

class NudgeButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final ButtonVariant variant;
  final bool isLoading;
  final bool isExpanded;
  final double? width;
  final double height;

  const NudgeButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.variant = ButtonVariant.primary,
    this.isLoading = false,
    this.isExpanded = false,
    this.width,
    this.height = 50.0,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    Color bg;
    Color fg;
    BorderSide border = BorderSide.none;

    switch (variant) {
      case ButtonVariant.primary:
        bg = isDark ? NudgeTheme.secondaryContainer : NudgeTheme.primaryContainer;
        fg = isDark ? NudgeTheme.onSecondaryContainer : Colors.white;
        break;
      case ButtonVariant.secondary:
        bg = isDark ? NudgeTheme.surfaceContainerDark : NudgeTheme.surfaceContainerLight;
        fg = isDark ? NudgeTheme.onBgDark : NudgeTheme.onBgLight;
        break;
      case ButtonVariant.danger:
        bg = NudgeTheme.error;
        fg = Colors.white;
        break;
      case ButtonVariant.outline:
        bg = Colors.transparent;
        fg = isDark ? NudgeTheme.onBgDark : NudgeTheme.primary;
        border = BorderSide(color: isDark ? NudgeTheme.cardBorderDark : NudgeTheme.cardBorderLight, width: 1.5);
        break;
    }

    final child = isLoading
        ? SizedBox(
            width: 22,
            height: 22,
            child: CircularProgressIndicator(
              strokeWidth: 2.5,
              valueColor: AlwaysStoppedAnimation<Color>(fg),
            ),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 20, color: fg),
                const SizedBox(width: 8),
              ],
              Text(
                label,
                style: TextStyle(
                  color: fg,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
            ],
          );

    return SizedBox(
      width: isExpanded ? double.infinity : width,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: bg,
          foregroundColor: fg,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(NudgeTheme.radiusM),
            side: border,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20),
        ),
        onPressed: isLoading ? null : onPressed,
        child: child,
      ),
    );
  }
}
