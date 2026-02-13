import 'package:flutter/material.dart';
import 'package:mood_map/core/constants/colors.dart';
import 'package:mood_map/features/mood/domain/enums/mood_type.dart';
import 'package:mood_map/l10n/app_localizations.dart';

// class IconFilterWidget extends StatelessWidget {
//   const IconFilterWidget({super.key, required this.onFilterTap, required this.selectedFilter});

//   final Future<void> Function() onFilterTap;
//   final MoodType? selectedFilter;

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       alignment: Alignment.center,
//       children: [
//         IconButton(
//           onPressed: onFilterTap,
//           icon: Icon(Icons.filter_alt_outlined, color: Colors.grey[700], size: 30),
//           tooltip:
//               selectedFilter != null
//                   ? AppLocalizations.of(context)!.filterTooltipActive
//                   : AppLocalizations.of(context)!.filterTooltipInactive,
//         ),
//         if (selectedFilter != null)
//           Positioned(
//             top: 10,
//             right: 12,
//             child: Container(
//               width: 13,
//               height: 13,
//               decoration: BoxDecoration(color: Colors.red, shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 2)),
//             ),
//           ),
//       ],
//     );
//   }
// }

class IconFilterWidget extends StatelessWidget {
  const IconFilterWidget({
    super.key,
    required this.onFilterTap,
    required this.selectedFilter,
  });

  final Future<void> Function() onFilterTap;
  final MoodType? selectedFilter;

  @override
  Widget build(BuildContext context) {
    // اختَر لون البادج حسب الثيم
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final badgeColor =
        selectedFilter != null
            ? (isDark ? MoodColors.primaryDark : MoodColors.primaryNormal)
            : Colors.transparent;

    return Stack(
      alignment: Alignment.center,
      children: [
        IconButton(
          onPressed: onFilterTap,
          icon: Icon(
            Icons.filter_alt_outlined,
            color: isDark ? Colors.white70 : Colors.grey[700],
            size: 30,
          ),
          tooltip:
              selectedFilter != null
                  ? AppLocalizations.of(context)!.filterTooltipActive
                  : AppLocalizations.of(context)!.filterTooltipInactive,
        ),
        if (selectedFilter != null)
          Positioned(
            top: 10,
            right: 12,
            child: Container(
              width: 13,
              height: 13,
              decoration: BoxDecoration(
                color: badgeColor,
                shape: BoxShape.circle,
                border: Border.all(
                  color: isDark ? Colors.black : Colors.white,
                  width: 2,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
