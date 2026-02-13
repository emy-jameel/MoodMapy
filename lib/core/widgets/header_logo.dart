import 'package:flutter/material.dart';
import 'package:mood_map/core/theme/text_styles.dart';
import 'package:mood_map/core/constants/colors.dart';
import 'package:mood_map/core/constants/icons.dart';
import 'package:mood_map/core/widgets/mood_heart.dart';

// class HeaderLogo extends StatelessWidget {
//   const HeaderLogo({super.key, this.showHeart = true});
//   final bool showHeart;

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Row(
//               children: [
//                 Image.asset(MoodIcons.animatedLogo, width: 36, height: 36),
//                 const SizedBox(width: 8),
//                 Text(
//                   'MoodMap',
//                   style: MoodTextStyles.bold3.copyWith(
//                     fontWeight: FontWeight.w500, // Medium
//                     fontSize: 24,
//                     height: 1.45,
//                     letterSpacing: 0,
//                     color: MoodColors.tPrimaryDark,
//                   ),
//                 ),
//               ],
//             ),
//             if (showHeart) MoodHeart(),
//           ],
//         ),
//       ),
//     );
//   }
// }

class HeaderLogo extends StatelessWidget {
  const HeaderLogo({super.key, this.showHeart = true});
  final bool showHeart;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final lang = Localizations.localeOf(context).languageCode;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(MoodIcons.animatedLogo, width: 36, height: 36),
                const SizedBox(width: 8),
                Text(
                  'MoodMap',
                  style: MoodTextStyles.bold3.copyWith(
                    fontWeight: FontWeight.w500, // Medium
                    fontSize: 24,
                    height: 1.45,
                    letterSpacing: 0,
                    color: isDark ? Colors.white : MoodColors.tPrimaryDark,
                    fontFamily: lang == 'ar' ? 'Zain' : 'Poppins',
                  ),
                ),
              ],
            ),
            if (showHeart) MoodHeart(),
          ],
        ),
      ),
    );
  }
}
