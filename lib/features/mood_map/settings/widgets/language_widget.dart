import 'package:flutter/material.dart';
import 'package:mood_map/core/constants/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mood_map/core/theme/text_styles.dart';
import 'package:mood_map/features/settings/cubit/app_settings_cubit.dart';
import 'package:mood_map/l10n/app_localizations.dart';

class LanguageWidget extends StatelessWidget {
  const LanguageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsCubit = context.watch<AppSettingsCubit>();
    final settingsState = settingsCubit.state;
    final isDark = settingsState.isDarkMode;

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
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color:
                      isDark
                          ? Colors.blue.withAlpha(30)
                          : Colors.blue.withAlpha(20),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.language,
                  color: isDark ? Colors.blue[200] : const Color(0xFF3B82F6),
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Text(
                AppLocalizations.of(context)!.language,
                style: MoodTextStyles.heading3.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              color: isDark ? Colors.black26 : Colors.grey.shade100,
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.all(4),
            child: Row(
              children: [
                _LanguageOption(
                  label: 'العربية',
                  isSelected: settingsState.language == 'ar',
                  onTap: () => settingsCubit.setLanguage('ar'),
                  isDark: isDark,
                ),
                _LanguageOption(
                  label: 'English',
                  isSelected: settingsState.language == 'en',
                  onTap: () => settingsCubit.setLanguage('en'),
                  isDark: isDark,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LanguageOption extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isDark;

  const _LanguageOption({
    required this.label,
    required this.isSelected,
    required this.onTap,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 12),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color:
                isSelected
                    ? (isDark ? MoodColors.primaryNormal : Colors.white)
                    : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            boxShadow:
                isSelected
                    ? [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ]
                    : [],
          ),
          child: Text(
            label,
            style: MoodTextStyles.body1.copyWith(
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color:
                  isSelected
                      ? (isDark ? Colors.white : Colors.black87)
                      : (isDark ? Colors.white60 : Colors.black54),
            ),
          ),
        ),
      ),
    );
  }
}
