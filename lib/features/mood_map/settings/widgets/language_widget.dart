import 'package:flutter/material.dart';
import 'package:mood_map/core/constants/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mood_map/features/settings/cubit/app_settings_cubit.dart';
import 'package:mood_map/l10n/app_localizations.dart';

// class LanguageWidget extends StatelessWidget {
//   const LanguageWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final settings = Provider.of<AppSettingsProvider>(context, listen: true);

//     return Container(
//       padding: const EdgeInsets.all(18),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 3))],
//       ),
//       child: Row(
//         children: [
//           const Icon(Icons.language, color: Color(0xFF3B82F6), size: 28),
//           const SizedBox(width: 18),
//           Text(AppLocalizations.of(context)!.language, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18)),
//           const Spacer(),
//           ToggleButtons(
//             borderRadius: BorderRadius.circular(14),
//             selectedColor: Colors.white,
//             color: Colors.grey,
//             fillColor: MoodColors.primaryNormalActive,
//             constraints: const BoxConstraints(minWidth: 66, minHeight: 40),
//             isSelected: [settings.language == 'ar', settings.language == 'en'],
//             onPressed: (idx) async {
//               final newLang = idx == 0 ? 'ar' : 'en';
//               await settings.setLanguage(newLang);
//             },
//             children: const [Text('العربية', style: TextStyle(fontSize: 15)), Text('English', style: TextStyle(fontSize: 15))],
//           ),
//         ],
//       ),
//     );
//   }
// }

class LanguageWidget extends StatelessWidget {
  const LanguageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsCubit = context.watch<AppSettingsCubit>();
    final settingsState = settingsCubit.state;
    final isDark = settingsState.isDarkMode;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1A2233) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: isDark ? Colors.black.withAlpha(38) : Colors.black12,
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            Icons.language,
            color: isDark ? Colors.blue[200] : const Color(0xFF3B82F6),
            size: 28,
          ),
          const SizedBox(width: 18),
          Text(
            AppLocalizations.of(context)!.language,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
          const Spacer(),
          ToggleButtons(
            borderRadius: BorderRadius.circular(14),
            selectedColor: isDark ? Colors.black : Colors.white,
            color: isDark ? Colors.white70 : Colors.grey,
            fillColor:
                isDark ? Colors.blue[200]! : MoodColors.primaryNormalActive,
            constraints: const BoxConstraints(minWidth: 66, minHeight: 40),
            isSelected: [
              settingsState.language == 'ar',
              settingsState.language == 'en',
            ],
            onPressed: (idx) async {
              final newLang = idx == 0 ? 'ar' : 'en';
              await settingsCubit.setLanguage(newLang);
            },
            children: const [
              Text('العربية', style: TextStyle(fontSize: 15)),
              Text('English', style: TextStyle(fontSize: 15)),
            ],
          ),
        ],
      ),
    );
  }
}
