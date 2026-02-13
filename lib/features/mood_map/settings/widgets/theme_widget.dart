import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mood_map/core/constants/colors.dart';
import 'package:mood_map/features/settings/cubit/app_settings_cubit.dart';
import 'package:mood_map/features/settings/cubit/app_settings_state.dart';
import 'package:mood_map/l10n/app_localizations.dart';

// class ThemeWidget extends StatelessWidget {
//   const ThemeWidget({super.key, required this.settings});
//   final AppSettingsProvider settings;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(18),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 3))],
//       ),
//       child: Row(
//         children: [
//           Icon(Icons.nightlight_round, color: MoodColors.primaryNormalActive, size: 28),
//           const SizedBox(width: 18),
//           Text(AppLocalizations.of(context)!.theme, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18)),

//           const Spacer(),
//           Switch(
//             value: settings.isDarkMode,
//             activeColor: MoodColors.awfulDarker,
//             inactiveThumbColor: MoodColors.awfulDarkActive,
//             onChanged: (_) => settings.toggleTheme(),
//             trackColor: MaterialStateProperty.all(MoodColors.awfulDarkHover),
//           ),
//         ],
//       ),
//     );
//   }
// }

class ThemeWidget extends StatelessWidget {
  const ThemeWidget({super.key, required this.settings});
  final AppSettingsState settings;

  @override
  Widget build(BuildContext context) {
    final isDark = settings.isDarkMode;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1A2233) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: isDark ? Colors.black.withAlpha(33) : Colors.black12,
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            Icons.nightlight_round,
            color: isDark ? Colors.blue[200] : MoodColors.primaryNormalActive,
            size: 28,
          ),
          const SizedBox(width: 18),
          Text(
            AppLocalizations.of(context)!.theme,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: isDark ? Colors.white : Colors.black,
              //fontFamily: ... // تقدر تضيف شرط إذا العربية وتريد خط عربي خاص
            ),
          ),
          const Spacer(),
          Switch(
            value: settings.isDarkMode,
            activeColor: MoodColors.primaryNormalActive,
            inactiveThumbColor: MoodColors.awfulDarkActive,
            onChanged: (_) => context.read<AppSettingsCubit>().toggleTheme(),
            trackColor: WidgetStateProperty.all(MoodColors.awfulDark),
          ),
        ],
      ),
    );
  }
}
