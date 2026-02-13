import 'package:flutter/material.dart';
import 'package:mood_map/core/theme/text_styles.dart';

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
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final lang = Localizations.localeOf(context).languageCode;

    // Use card color from theme, or fallback
    final backgroundColor =
        theme.cardTheme.color ??
        (isDark ? const Color(0xFF2B3642) : Colors.white);
    final activeColor = theme.primaryColor;
    final inactiveColor = isDark ? Colors.white70 : Colors.black54;

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: isDark ? Colors.black45 : Colors.black12,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Week Button
          Expanded(
            child: GestureDetector(
              onTap: onWeekTap,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color:
                      isWeekView
                          ? activeColor.withAlpha(isDark ? 50 : 30)
                          : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isWeekView ? activeColor : Colors.transparent,
                    width: 1.5,
                  ),
                ),
                child: Text(
                  AppLocalizations.of(context)!.week,
                  textAlign: TextAlign.center,
                  style: MoodTextStyles.button.copyWith(
                    color: isWeekView ? activeColor : inactiveColor,
                    fontFamily: lang == 'ar' ? 'Zain' : 'Poppins',
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(width: 8),

          // Month Button
          Expanded(
            child: GestureDetector(
              onTap: onMonthTap,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color:
                      !isWeekView
                          ? activeColor.withAlpha(isDark ? 50 : 30)
                          : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: !isWeekView ? activeColor : Colors.transparent,
                    width: 1.5,
                  ),
                ),
                child: Text(
                  AppLocalizations.of(context)!.month,
                  textAlign: TextAlign.center,
                  style: MoodTextStyles.button.copyWith(
                    color: !isWeekView ? activeColor : inactiveColor,
                    fontFamily: lang == 'ar' ? 'Zain' : 'Poppins',
                  ),
                ),
              ),
            ),
          ),

          // Filter Icon with Badge
          const SizedBox(width: 8),
          Container(
            height: 40,
            width: 1,
            color: isDark ? Colors.white12 : Colors.black12,
          ),
          const SizedBox(width: 8),

          IconFilterWidget(
            onFilterTap: onFilterTap,
            selectedFilter: selectedFilter,
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }
}
