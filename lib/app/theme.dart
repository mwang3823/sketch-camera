import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Centralized application theme configuration.
/// Edit the constant values below to quickly customize the application's appearance.
class AppTheme {
  AppTheme._();

  // ==========================================
  // CUSTOMIZABLE DESIGN TOKENS
  // ==========================================
  static const Color primaryColor = Colors.blue;
  static const Color backgroundColor = Color(0xFF0C0C0E); // Near Black
  static const Color surfaceColor = Color(0xFF1E1E22);     // Dark Gray
  static const Color cardColor = Color(0xFF2A2A30);        // Lighter Gray for cards
  static const double borderRadiusValue = 16.0;            // Standard roundness (16px)

  /// Returns the customized dark theme containing Google Fonts Montserrat.
  static ThemeData get darkTheme {
    final baseTheme = ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
    );

    // Apply Montserrat to the base dark text theme
    final textTheme = GoogleFonts.montserratTextTheme(baseTheme.textTheme);

    return baseTheme.copyWith(
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        brightness: Brightness.dark,
        surface: surfaceColor,
      ),
      scaffoldBackgroundColor: backgroundColor,
      cardTheme: CardThemeData(
        color: cardColor,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadiusValue),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: surfaceColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadiusValue),
        ),
      ),
      sliderTheme: const SliderThemeData(
        activeTrackColor: primaryColor,
        thumbColor: primaryColor,
        showValueIndicator: ShowValueIndicator.onDrag,
      ),
      textTheme: textTheme,
    );
  }
}
