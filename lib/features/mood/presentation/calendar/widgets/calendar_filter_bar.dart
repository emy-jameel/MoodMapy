import 'package:flutter/material.dart';
import 'package:mood_map/core/theme/text_styles.dart';
import 'package:mood_map/core/constants/colors.dart';
import 'package:mood_map/features/mood/domain/enums/mood_type.dart';
import 'icon_filter_widget.dart';
import 'package:mood_map/l10n/app_localizations.dart';

// class CalendarFilterBar extends StatelessWidget {
//   final bool isWeekView;
//   final VoidCallback onWeekTap;
//   final VoidCallback onMonthTap;
//   final MoodType? selectedFilter;
//   final Future<void> Function() onFilterTap;

//   const CalendarFilterBar({
//     super.key,
//     required this.isWeekView,
//     required this.onWeekTap,
//     required this.onMonthTap,
//     required this.selectedFilter,
//     required this.onFilterTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.only(left: 16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [BoxShadow(color: Colors.black12.withOpacity(0.06), blurRadius: 8, offset: const Offset(0, 2))],
//       ),
//       child: Row(
//         children: [
//           // زر Week
//           Expanded(
//             child: TextButton(
//               style: TextButton.styleFrom(
//                 backgroundColor: isWeekView ? MoodColors.primaryNormal : Colors.white,
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//               ),
//               onPressed: onWeekTap,
//               child: Text(
//                 AppLocalizations.of(context)!.week,
//                 style: MoodTextStyles.normal1.copyWith(
//                   fontWeight: FontWeight.w500,
//                   fontSize: 16,
//                   color: isWeekView ? MoodColors.primaryDarker : MoodColors.awfulNormalHover,
//                 ),
//               ),
//             ),
//           ),
//           // زر Month
//           Expanded(
//             child: TextButton(
//               style: TextButton.styleFrom(
//                 backgroundColor: !isWeekView ? MoodColors.primaryNormal : Colors.white,
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//               ),
//               onPressed: onMonthTap,
//               child: Text(
//                 AppLocalizations.of(context)!.month,
//                 style: MoodTextStyles.normal1.copyWith(
//                   fontWeight: FontWeight.w500,
//                   fontSize: 16,

//                   color: !isWeekView ? MoodColors.primaryDarker : MoodColors.awfulNormalHover,
//                 ),
//               ),
//             ),
//           ),
//           // أيقونة الفلتر مع البادج
//           IconFilterWidget(onFilterTap: onFilterTap, selectedFilter: selectedFilter),
//         ],
//       ),
//     );
//   }
// }

class CalendarFilterBar extends StatelessWidget {
  final bool isWeekView;
  final VoidCallback onWeekTap;
  final VoidCallback onMonthTap;
  final MoodType? selectedFilter;
  final Future<void> Function() onFilterTap;

  const CalendarFilterBar({
    super.key,
    required this.isWeekView,
    required this.onWeekTap,
    required this.onMonthTap,
    required this.selectedFilter,
    required this.onFilterTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final lang = Localizations.localeOf(context).languageCode;
    final cardColor = Theme.of(context).cardColor; // يدعم الثيمين

    return Container(
      padding: const EdgeInsets.only(left: 16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: isDark ? Colors.black45 : Colors.black12.withAlpha(15),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // زر Week
          Expanded(
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor:
                    isWeekView
                        ? (isDark
                            ? MoodColors.primaryDarkActive
                            : MoodColors.primaryNormal)
                        : cardColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: onWeekTap,
              child: Text(
                AppLocalizations.of(context)!.week,
                style: MoodTextStyles.normal1.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color:
                      isWeekView
                          ? (isDark
                              ? MoodColors.primaryNormal
                              : MoodColors.primaryDarker)
                          : (isDark
                              ? MoodColors.awfulDark
                              : MoodColors.awfulNormalHover),
                  fontFamily: lang == 'ar' ? 'Zain' : 'Poppins',
                ),
              ),
            ),
          ),
          // زر Month
          Expanded(
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor:
                    !isWeekView
                        ? (isDark
                            ? MoodColors.primaryDarkActive
                            : MoodColors.primaryNormal)
                        : cardColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: onMonthTap,
              child: Text(
                AppLocalizations.of(context)!.month,
                style: MoodTextStyles.normal1.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color:
                      !isWeekView
                          ? (isDark
                              ? MoodColors.primaryNormal
                              : MoodColors.primaryDarker)
                          : (isDark
                              ? MoodColors.awfulDark
                              : MoodColors.awfulNormalHover),
                  fontFamily: lang == 'ar' ? 'Zain' : 'Poppins',
                ),
              ),
            ),
          ),
          // أيقونة الفلتر مع البادج
          IconFilterWidget(
            onFilterTap: onFilterTap,
            selectedFilter: selectedFilter,
          ),
        ],
      ),
    );
  }
}
