import 'package:flutter/material.dart';
import 'package:mood_map/core/theme/text_styles.dart';
import 'package:mood_map/core/constants/colors.dart';
import 'package:mood_map/l10n/app_localizations.dart';

// class MoodTextField extends StatelessWidget {
//   final TextEditingController controller;

//   const MoodTextField({super.key, required this.controller});

//   @override
//   Widget build(BuildContext context) {
//     return TextField(
//       controller: controller,
//       maxLength: 100,
//       maxLines: 4,
//       decoration: InputDecoration(
//         hintText: AppLocalizations.of(context)!.moodPlaceholder,
//         hintStyle: MoodTextStyles.normal3.copyWith(fontSize: 18, height: 1.5, color: MoodColors.tSecondaryNormal),
//         border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//       ),
//     );
//   }
// }

class MoodTextField extends StatelessWidget {
  final TextEditingController controller;

  const MoodTextField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final lang = Localizations.localeOf(context).languageCode;

    return TextField(
      controller: controller,
      maxLength: 100,
      maxLines: 4,
      style: TextStyle(
        fontFamily: lang == 'ar' ? 'Zain' : 'Poppins',
        fontSize: 18,
        color: isDark ? Colors.white : Colors.black87,
      ),
      decoration: InputDecoration(
        hintText: AppLocalizations.of(context)!.moodPlaceholder,
        hintStyle: MoodTextStyles.normal3.copyWith(
          fontSize: 18,
          height: 1.5,
          color:
              isDark ? MoodColors.tSecondaryDark : MoodColors.tSecondaryNormal,
          fontFamily: lang == 'ar' ? 'Zain' : 'Poppins',
        ),
        filled: true,
        fillColor: isDark ? const Color(0xFF232B34) : Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: isDark ? Colors.white24 : MoodColors.primaryNormal,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: isDark ? Colors.white24 : MoodColors.primaryNormal,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: isDark ? MoodColors.primaryDark : MoodColors.primaryNormal,
            width: 2,
          ),
        ),
        counterStyle: TextStyle(
          color: isDark ? Colors.white54 : Colors.black45,
          fontFamily: lang == 'ar' ? 'Zain' : 'Poppins',
        ),
      ),
      cursorColor: isDark ? MoodColors.primaryDark : MoodColors.primaryNormal,
    );
  }
}
