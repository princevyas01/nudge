import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entities/folder.dart';

class NudgeTheme {
  // Brand Colors
  static const Color primary = Color(0xFF002B26);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color primaryContainer = Color(0xFF16423C);
  static const Color onPrimaryContainer = Color(0xFF83AEA6);

  static const Color secondary = Color(0xFF006A60);
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color secondaryContainer = Color(0xFF79F4E2);
  static const Color onSecondaryContainer = Color(0xFF006F64);

  static const Color tertiary = Color(0xFF3E1C11);
  static const Color onTertiary = Color(0xFFFFFFFF);
  static const Color tertiaryContainer = Color(0xFF583125);
  static const Color onTertiaryContainer = Color(0xFFD09988);

  static const Color error = Color(0xFFBA1A1A);
  static const Color onError = Color(0xFFFFFFFF);
  static const Color errorContainer = Color(0xFFFFDAD6);
  static const Color onErrorContainer = Color(0xFF93000A);

  static const Color bgLight = Color(0xFFF9F9F8);
  static const Color onBgLight = Color(0xFF1A1C1B);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceContainerLight = Color(0xFFF0F1EF);
  static const Color cardBorderLight = Color(0xFFE2E3E1);

  static const Color bgDark = Color(0xFF121413);
  static const Color onBgDark = Color(0xFFE2E3E1);
  static const Color surfaceDark = Color(0xFF1A1C1B);
  static const Color surfaceContainerDark = Color(0xFF222524);
  static const Color cardBorderDark = Color(0xFF2D3130);

  // Radii
  static const double radiusS = 12.0;
  static const double radiusM = 16.0;
  static const double radiusL = 20.0;
  static const double radiusXL = 24.0;
  static const double radiusPill = 28.0;

  static ThemeData get lightTheme {
    final baseTextTheme = Typography.material2021().black;
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: bgLight,
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: primary,
        onPrimary: onPrimary,
        primaryContainer: primaryContainer,
        onPrimaryContainer: onPrimaryContainer,
        secondary: secondary,
        onSecondary: onSecondary,
        secondaryContainer: secondaryContainer,
        onSecondaryContainer: onSecondaryContainer,
        tertiary: tertiary,
        onTertiary: onTertiary,
        error: error,
        onError: onError,
        errorContainer: errorContainer,
        onErrorContainer: onErrorContainer,
        surface: surfaceLight,
        onSurface: onBgLight,
        surfaceContainer: surfaceContainerLight,
      ),
      textTheme: GoogleFonts.plusJakartaSansTextTheme(baseTextTheme),
      cardTheme: CardTheme(
        color: surfaceLight,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusL),
          side: const BorderSide(color: cardBorderLight, width: 1.0),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: bgLight,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
      ),
    );
  }

  static ThemeData get darkTheme {
    final baseTextTheme = Typography.material2021().white;
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: bgDark,
      colorScheme: const ColorScheme(
        brightness: Brightness.dark,
        primary: onPrimaryContainer,
        onPrimary: primary,
        primaryContainer: primaryContainer,
        onPrimaryContainer: onPrimaryContainer,
        secondary: secondaryContainer,
        onSecondary: onSecondaryContainer,
        tertiary: onTertiaryContainer,
        onTertiary: tertiary,
        error: errorContainer,
        onError: onErrorContainer,
        errorContainer: error,
        onErrorContainer: onError,
        surface: surfaceDark,
        onSurface: onBgDark,
        surfaceContainer: surfaceContainerDark,
      ),
      textTheme: GoogleFonts.plusJakartaSansTextTheme(baseTextTheme),
      cardTheme: CardTheme(
        color: surfaceDark,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusL),
          side: const BorderSide(color: cardBorderDark, width: 1.0),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: bgDark,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
      ),
    );
  }

  static Color getFolderColor(Folder? folder, bool isDark) {
    if (folder == null) {
      return isDark ? surfaceContainerDark : surfaceContainerLight;
    }
    try {
      final colorHex = folder.colorTag.replaceFirst('#', '0xFF');
      final baseColor = Color(int.parse(colorHex));
      if (isDark) {
        final hsl = HSLColor.fromColor(baseColor);
        return hsl
            .withLightness((hsl.lightness - 0.15).clamp(0.0, 1.0))
            .withSaturation((hsl.saturation + 0.1).clamp(0.0, 1.0))
            .toColor();
      }
      return baseColor;
    } catch (_) {
      return isDark ? surfaceContainerDark : surfaceContainerLight;
    }
  }

  static IconData getFolderIcon(Folder? folder) {
    if (folder == null) return Icons.folder_outlined;
    return getIconDataForId(folder.iconId);
  }

  static IconData getIconDataForId(String id) {
    switch (id) {
      case 'work': return Icons.work_outline;
      case 'home': return Icons.home_outlined;
      case 'school': return Icons.school_outlined;
      case 'shopping_cart': return Icons.shopping_cart_outlined;
      case 'local_hospital': return Icons.local_hospital_outlined;
      case 'receipt': return Icons.receipt_long_outlined;
      case 'flight': return Icons.flight_takeoff_outlined;
      case 'movie': return Icons.movie_outlined;
      case 'star': return Icons.star_outline;
      default: return Icons.folder_outlined;
    }
  }
}
