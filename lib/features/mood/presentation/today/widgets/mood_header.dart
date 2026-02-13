import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mood_map/core/constants/colors.dart';
import 'package:mood_map/core/theme/text_styles.dart';
import 'header_clipper.dart';
import 'package:mood_map/core/widgets/header_logo.dart';
import 'package:mood_map/l10n/app_localizations.dart';

// class MoodHeader extends StatelessWidget {
//   const MoodHeader({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         ClipPath(
//           clipper: HeaderClipper(),
//           child: Container(
//             height: 300,
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//                 colors: [MoodColors.primaryNormalActive, MoodColors.primaryNormalHover],
//               ),
//             ),
//           ),
//         ),
//         ClipPath(
//           clipper: HeaderClipperTow(),
//           child: Container(
//             height: 300,
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//                 colors: [MoodColors.primaryNormal, MoodColors.primaryLightHover],
//               ),
//             ),
//           ),
//         ),
//         HeaderLogo(),
//         Positioned(
//           top: 130,
//           left: 0,
//           right: 0,
//           child: Column(
//             children: [
//               Text(AppLocalizations.of(context)!.todayMood, style: MoodTextStyles.bold4.copyWith(fontWeight: FontWeight.w500)),
//               const SizedBox(height: 4),
//               Text(
//                 DateFormat('EEEE, MMMM d, yyyy', Localizations.localeOf(context).languageCode).format(DateTime.now()),
//                 style: MoodTextStyles.normal3.copyWith(fontWeight: FontWeight.w400, color: MoodColors.badDarkActive),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

class MoodHeader extends StatelessWidget {
  const MoodHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final lang = Localizations.localeOf(context).languageCode;

    // التدرجات تتغير مع الثيم
    final gradient1 = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors:
          isDark
              ? [MoodColors.primaryDarkActive, MoodColors.primaryDarkHover]
              : [MoodColors.primaryNormalActive, MoodColors.primaryNormalHover],
    );
    final gradient2 = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors:
          isDark
              ? [MoodColors.primaryDark, MoodColors.primaryDarkHover]
              : [MoodColors.primaryNormal, MoodColors.primaryLightHover],
    );

    return Stack(
      children: [
        ClipPath(
          clipper: HeaderClipper(),
          child: Container(
            height: 300,
            decoration: BoxDecoration(gradient: gradient1),
          ),
        ),
        ClipPath(
          clipper: HeaderClipperTow(),
          child: Container(
            height: 300,
            decoration: BoxDecoration(gradient: gradient2),
          ),
        ),
        const HeaderLogo(),
        Positioned(
          top: 130,
          left: 0,
          right: 0,
          child: Column(
            children: [
              Text(
                AppLocalizations.of(context)!.todayMood,
                style: MoodTextStyles.bold4.copyWith(
                  fontWeight: FontWeight.w500,
                  color: isDark ? Colors.white : Colors.black,
                  fontFamily: lang == 'ar' ? 'Zain' : 'Poppins',
                ),
              ),
              const SizedBox(height: 4),
              Text(
                DateFormat('EEEE, MMMM d, yyyy', lang).format(DateTime.now()),
                style: MoodTextStyles.normal3.copyWith(
                  fontWeight: FontWeight.w400,
                  color:
                      isDark
                          ? MoodColors.awfulNormal
                          : MoodColors.badDarkActive,
                  fontFamily: lang == 'ar' ? 'Zain' : 'Poppins',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
