import 'package:flutter/material.dart';
import 'text_styles.dart';
import 'package:mood_map/core/constants/colors.dart';

class MoodTheme {
  static ThemeData lightTheme(String lang) {
    final isArabic = lang == 'ar';
    return ThemeData(
      useMaterial3: true,
      primaryColor: MoodColors.primaryNormal,
      scaffoldBackgroundColor: Colors.white,
      fontFamily: isArabic ? 'Zain' : 'Poppins',
      textTheme: TextTheme(
        displayLarge: MoodTextStyles.bold4.copyWith(
          fontFamily: isArabic ? 'Zain' : 'Poppins',
        ),
        displayMedium: MoodTextStyles.bold3.copyWith(
          fontFamily: isArabic ? 'Zain' : 'Poppins',
        ),
        bodyLarge: MoodTextStyles.normal3.copyWith(
          fontFamily: isArabic ? 'Zain' : 'Poppins',
        ),
        bodyMedium: MoodTextStyles.normal1.copyWith(
          fontFamily: isArabic ? 'Zain' : 'Poppins',
        ),
        bodySmall: MoodTextStyles.smallText.copyWith(
          fontFamily: isArabic ? 'Zain' : 'Poppins',
        ),
      ),
      colorScheme: const ColorScheme.light(
        primary: MoodColors.primaryNormal,
        secondary: MoodColors.tSecondaryNormal,
        onPrimary: Colors.white,
        onSecondary: Colors.black,
        surface: Colors.white,
        onSurface: Colors.black,
      ),
    );
  }

  static ThemeData darkTheme(String lang) {
    final isArabic = lang == 'ar';
    return ThemeData(
      useMaterial3: true,
      primaryColor: MoodColors.primaryDark,
      scaffoldBackgroundColor: const Color(0xFF222C36),
      fontFamily: isArabic ? 'Zain' : 'Poppins',
      textTheme: TextTheme(
        displayLarge: MoodTextStyles.bold4.copyWith(
          fontFamily: isArabic ? 'Zain' : 'Poppins',
        ),
        displayMedium: MoodTextStyles.bold3.copyWith(
          fontFamily: isArabic ? 'Zain' : 'Poppins',
        ),
        bodyLarge: MoodTextStyles.normal3.copyWith(
          fontFamily: isArabic ? 'Zain' : 'Poppins',
        ),
        bodyMedium: MoodTextStyles.normal1.copyWith(
          fontFamily: isArabic ? 'Zain' : 'Poppins',
        ),
        bodySmall: MoodTextStyles.smallText.copyWith(
          fontFamily: isArabic ? 'Zain' : 'Poppins',
        ),
      ),
      colorScheme: const ColorScheme.dark(
        primary: MoodColors.primaryDark,
        secondary: MoodColors.tSecondaryDark,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        surface: Color(0xFF222C36),
        onSurface: Colors.white,
      ),
    );
  }
}
