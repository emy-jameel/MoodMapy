import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mood_map/core/constants/icons.dart';
import 'package:mood_map/core/theme/text_styles.dart';
import 'package:mood_map/core/widgets/header_logo.dart';
import 'package:mood_map/features/mood_map/settings/widgets/language_widget.dart';
import 'package:mood_map/features/mood_map/settings/widgets/theme_widget.dart';
import 'package:mood_map/features/settings/cubit/app_settings_cubit.dart';
import 'package:mood_map/l10n/app_localizations.dart';

final switcherKey = 'settings_switcher';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsCubit = context.watch<AppSettingsCubit>();
    final settingsState = settingsCubit.state;
    final isDark = settingsState.isDarkMode;
    final l10n = AppLocalizations.of(context)!;
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    final dividerColor = isDark ? Colors.white12 : const Color(0xFFEAEAEA);
    final scaffoldColor =
        isDark ? const Color(0xFF222C36) : const Color(0xFFF8FBFD);

    return Scaffold(
      backgroundColor: scaffoldColor,
      body: SafeArea(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 555),
          transitionBuilder:
              (child, anim) => FadeTransition(opacity: anim, child: child),
          key: ValueKey(switcherKey),
          child: Column(
            key: ValueKey(switcherKey),
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const HeaderLogo(showHeart: false),
                    const Spacer(),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color:
                            isDark
                                ? Colors.white.withAlpha(10)
                                : Colors.black.withAlpha(5),
                      ),
                      child: IconButton(
                        icon: Icon(
                          isRtl
                              ? Icons.arrow_back_ios_new
                              : Icons.arrow_forward_ios,
                          color: isDark ? Colors.white70 : Colors.black54,
                          size: 20,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                    const SizedBox(width: 16),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // Title
              Center(
                child: Text(
                  l10n.settings,
                  style: MoodTextStyles.heading1.copyWith(
                    color: isDark ? Colors.white : Colors.black87,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ),

              const SizedBox(height: 32),

              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    LanguageWidget(),
                    const SizedBox(height: 20),
                    ThemeWidget(settings: settingsState),
                  ],
                ),
              ),

              // Footer
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: Row(
                  children: [
                    const SizedBox(width: 24),
                    Expanded(
                      child: Divider(
                        color: dividerColor,
                        thickness: 1,
                        endIndent: 12,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            l10n.madeWithLove,
                            style: MoodTextStyles.body2.copyWith(
                              fontWeight: FontWeight.bold,
                              color:
                                  isDark
                                      ? Colors.white70
                                      : const Color(0xFF8B4B47),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Image.asset(
                            MoodIcons.madeBy,
                            height: 28,
                            width: 28,
                            fit: BoxFit.contain,
                            color: isDark ? Colors.white70 : null,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: dividerColor,
                        thickness: 1,
                        indent: 12,
                      ),
                    ),
                    const SizedBox(width: 24),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
