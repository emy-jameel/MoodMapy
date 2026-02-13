import 'package:flutter/material.dart';
import 'text_styles.dart';
import 'package:mood_map/core/constants/colors.dart';

class MoodTheme {
  static ThemeData lightTheme(String lang) {
    final isArabic = lang == 'ar';
    final fontFamily = isArabic ? 'Zain' : 'Poppins';

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: MoodColors.primaryNormal,
      scaffoldBackgroundColor: MoodColors.scaffoldLight,
      fontFamily: fontFamily,

      // Color Scheme
      colorScheme: const ColorScheme.light(
        primary: MoodColors.primaryNormal,
        secondary: MoodColors.tSecondaryNormal,
        surface: MoodColors.surfaceLight,
        onPrimary: Colors.white,
        onSecondary: Colors.black,
        onSurface: Colors.black,
        outline: MoodColors.outlineLight,
      ),

      // Text Theme
      textTheme: _buildTextTheme(fontFamily, Colors.black),

      // Component Themes
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black87),
        titleTextStyle: MoodTextStyles.heading3.copyWith(
          fontFamily: fontFamily,
          color: Colors.black87,
        ),
      ),

      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 2,
        shadowColor: Colors.black12,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: MoodColors.primaryNormal,
          foregroundColor: Colors.white,
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: MoodTextStyles.button.copyWith(fontFamily: fontFamily),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: MoodColors.primaryNormal),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: MoodColors.primaryNormal),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: MoodColors.primaryDark, width: 2),
        ),
        hintStyle: MoodTextStyles.body1.copyWith(
          color: MoodColors.tSecondaryNormal,
          fontFamily: fontFamily,
        ),
      ),

      dividerTheme: const DividerThemeData(
        color: MoodColors.outlineLight,
        thickness: 1,
        space: 24,
      ),
    );
  }

  static ThemeData darkTheme(String lang) {
    final isArabic = lang == 'ar';
    final fontFamily = isArabic ? 'Zain' : 'Poppins';

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: MoodColors.primaryDark,
      scaffoldBackgroundColor: MoodColors.scaffoldDark,
      fontFamily: fontFamily,

      // Color Scheme
      colorScheme: const ColorScheme.dark(
        primary: MoodColors.primaryDark,
        secondary: MoodColors.tSecondaryDark,
        surface: MoodColors.surfaceDark,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: Colors.white,
        outline: MoodColors.outlineDark,
      ),

      // Text Theme
      textTheme: _buildTextTheme(fontFamily, Colors.white),

      // Component Themes
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: MoodTextStyles.heading3.copyWith(
          fontFamily: fontFamily,
          color: Colors.white,
        ),
      ),

      cardTheme: CardThemeData(
        color: MoodColors.surfaceDark,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: MoodColors.primaryDark,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: MoodTextStyles.button.copyWith(fontFamily: fontFamily),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF232B34),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.white24),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.white24),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: MoodColors.primaryDark, width: 2),
        ),
        hintStyle: MoodTextStyles.body1.copyWith(
          color: MoodColors.tSecondaryDark,
          fontFamily: fontFamily,
        ),
      ),

      dividerTheme: const DividerThemeData(
        color: Colors.white12,
        thickness: 1,
        space: 24,
      ),
    );
  }

  static TextTheme _buildTextTheme(String fontFamily, Color color) {
    return TextTheme(
      displayLarge: MoodTextStyles.heading1.copyWith(
        fontFamily: fontFamily,
        color: color,
      ),
      displayMedium: MoodTextStyles.heading2.copyWith(
        fontFamily: fontFamily,
        color: color,
      ),
      displaySmall: MoodTextStyles.heading3.copyWith(
        fontFamily: fontFamily,
        color: color,
      ),
      headlineMedium: MoodTextStyles.subtitle1.copyWith(
        fontFamily: fontFamily,
        color: color,
      ),
      bodyLarge: MoodTextStyles.body1.copyWith(
        fontFamily: fontFamily,
        color: color,
      ),
      bodyMedium: MoodTextStyles.body2.copyWith(
        fontFamily: fontFamily,
        color: color,
      ),
      bodySmall: MoodTextStyles.caption.copyWith(
        fontFamily: fontFamily,
        color: color.withAlpha(179),
      ), // ~70% opacity
      labelLarge: MoodTextStyles.button.copyWith(
        fontFamily: fontFamily,
        color: color,
      ),
    );
  }
}
