import 'package:flutter/material.dart';
import 'package:mood_map/core/theme/text_styles.dart';
import 'package:mood_map/core/constants/colors.dart';
import 'package:mood_map/l10n/app_localizations.dart';

class MoodTextField extends StatelessWidget {
  final TextEditingController controller;

  const MoodTextField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final lang = Localizations.localeOf(context).languageCode;
    final primaryColor =
        isDark ? MoodColors.primaryDark : MoodColors.primaryNormal;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF232B34) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: isDark ? Colors.black26 : Colors.grey.withAlpha(20),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        maxLength: 100,
        maxLines: 4,
        style: TextStyle(
          fontFamily: lang == 'ar' ? 'Zain' : 'Poppins',
          fontSize: 16,
          height: 1.5,
          color: isDark ? Colors.white : Colors.black87,
        ),
        decoration: InputDecoration(
          hintText: AppLocalizations.of(context)!.moodPlaceholder,
          hintStyle: MoodTextStyles.body1.copyWith(
            color: isDark ? Colors.white38 : Colors.black38,
            fontFamily: lang == 'ar' ? 'Zain' : 'Poppins',
          ),
          filled: true,
          fillColor: Colors.transparent, // Handled by Container
          contentPadding: const EdgeInsets.all(20),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          counterStyle: TextStyle(
            color: isDark ? Colors.white38 : Colors.black38,
            fontSize: 12,
            fontFamily: lang == 'ar' ? 'Zain' : 'Poppins',
          ),
        ),
        cursorColor: primaryColor,
      ),
    );
  }
}
