import 'package:flutter/material.dart';
import 'package:mood_map/core/constants/icons.dart';
import 'package:mood_map/core/widgets/header_logo.dart';
import 'package:mood_map/features/mood_map/settings/widgets/language_widget.dart';
import 'package:mood_map/features/mood_map/settings/widgets/theme_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mood_map/features/settings/cubit/app_settings_cubit.dart';
import 'package:mood_map/l10n/app_localizations.dart';

final switcherKey = 'settings_switcher';

// class SettingsPage extends StatelessWidget {
//   const SettingsPage({super.key});
//   @override
//   Widget build(BuildContext context) {
//     final settings = Provider.of<AppSettingsProvider>(context, listen: true);
//     // final settings = Provider.of<AppSettingsProvider>(context);
//     return Scaffold(
//       backgroundColor: settings.isDarkMode ? const Color(0xFF222C36) : const Color(0xFFF8FBFD),
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         title: AnimatedSwitcher(
//           duration: const Duration(milliseconds: 555),
//           transitionBuilder: (child, anim) => FadeTransition(opacity: anim, child: child),
//           child: Text(
//             AppLocalizations.of(context)!.settings,
//             key: ValueKey(switcherKey), // مهم جداً
//             style: TextStyle(color: settings.isDarkMode ? Colors.white : Colors.black87, fontWeight: FontWeight.bold, fontSize: 26),
//           ),
//         ),
//         centerTitle: true,
//         iconTheme: IconThemeData(color: settings.isDarkMode ? Colors.white : Colors.black87),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
//         child: AnimatedSwitcher(
//           duration: const Duration(milliseconds: 555),
//           transitionBuilder: (child, anim) => FadeTransition(opacity: anim, child: child),
//           key: ValueKey(switcherKey), // كلما تغيرت اللغة أو الثيم يتحرك الانميشن
//           child: Column(
//             key: ValueKey(switcherKey),
//             children: [
//               LanguageWidget(),
//               const SizedBox(height: 24),
//               ThemeWidget(settings: settings),
//               const Spacer(),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   Center(
//                     child: Text(
//                       AppLocalizations.of(context)!.madeWithLove,
//                       style: TextStyle(
//                         fontSize: 17,
//                         fontWeight: FontWeight.bold,
//                         color: settings.isDarkMode ? Colors.white70 : const Color(0xFF8B4B47),
//                         shadows: [Shadow(color: Colors.black12, blurRadius: 5, offset: Offset(0, 2))],
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                   Image.asset(MoodIcons.madeBy, height: 45, width: 45, fit: BoxFit.contain),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsCubit = context.watch<AppSettingsCubit>();
    final settingsState = settingsCubit.state;
    final isDark = settingsState.isDarkMode;
    final l10n = AppLocalizations.of(context)!;
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    final dividerColor =
        settingsState.isDarkMode ? Colors.white12 : const Color(0xFFEAEAEA);

    return Scaffold(
      backgroundColor:
          isDark ? const Color(0xFF222C36) : const Color(0xFFF8FBFD),
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
              // Header + زر العودة
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const HeaderLogo(showHeart: false),
                  const Spacer(),
                  IconButton(
                    icon: Icon(
                      isRtl ? Icons.arrow_back_ios : Icons.arrow_forward_ios,
                      color: isDark ? Colors.white70 : Colors.black54,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // عنوان الإعدادات
              Center(
                child: Text(
                  l10n.settings,
                  style: TextStyle(
                    color: isDark ? Colors.white : Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: 26,
                    letterSpacing: 0.1,
                  ),
                ),
              ),
              const SizedBox(height: 28),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: LanguageWidget(),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ThemeWidget(settings: settingsState),
              ),
              const Spacer(),
              Row(
                children: [
                  const SizedBox(width: 8),
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
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color:
                                isDark
                                    ? Colors.white70
                                    : const Color(0xFF8B4B47),
                            shadows: [
                              Shadow(
                                color: Colors.black12,
                                blurRadius: 5,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 5),
                        Image.asset(
                          MoodIcons.madeBy,
                          height: 32,
                          width: 32,
                          fit: BoxFit.contain,
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
                  const SizedBox(width: 8),
                ],
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
