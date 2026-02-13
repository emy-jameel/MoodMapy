import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mood_map/core/constants/colors.dart';
import 'package:mood_map/core/theme/text_styles.dart';
import 'package:mood_map/features/settings/cubit/app_settings_cubit.dart';
import 'package:mood_map/features/settings/cubit/app_settings_state.dart';
import 'package:mood_map/l10n/app_localizations.dart';

class ThemeWidget extends StatelessWidget {
  const ThemeWidget({super.key, required this.settings});
  final AppSettingsState settings;

  @override
  Widget build(BuildContext context) {
    final isDark = settings.isDarkMode;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E2630) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark ? Colors.white10 : Colors.black.withAlpha(10),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: isDark ? Colors.black26 : Colors.black.withAlpha(10),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color:
                  isDark
                      ? MoodColors.primaryDark.withAlpha(30)
                      : MoodColors.primaryLight.withAlpha(50),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.nightlight_round,
              color:
                  isDark ? MoodColors.primaryLight : MoodColors.primaryNormal,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.theme,
                  style: MoodTextStyles.heading3.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  isDark ? 'Dark Mode' : 'Light Mode',
                  style: MoodTextStyles.body2.copyWith(
                    color: isDark ? Colors.white54 : Colors.black45,
                  ),
                ),
              ],
            ),
          ),
          Switch.adaptive(
            value: settings.isDarkMode,
            activeColor: MoodColors.primaryNormal,
            activeTrackColor: MoodColors.primaryNormal.withAlpha(100),
            inactiveThumbColor: Colors.grey.shade400,
            inactiveTrackColor: Colors.grey.shade200,
            onChanged: (_) => context.read<AppSettingsCubit>().toggleTheme(),
          ),
        ],
      ),
    );
  }
}
