import 'package:flutter/material.dart';
import 'package:mood_map/core/constants/colors.dart';
import 'package:mood_map/core/constants/icons.dart';
import 'package:mood_map/core/theme/text_styles.dart';
import 'package:mood_map/core/widgets/header_logo.dart';
import 'package:mood_map/features/mood_map/reflections/widgets/arrow_btn.dart';
import 'package:mood_map/features/mood_map/reflections/widgets/clip_path.dart';
import 'package:mood_map/features/mood_map/reflections/widgets/quote_card.dart';
import 'package:mood_map/l10n/app_localizations.dart';

class ReflectionsPage extends StatefulWidget {
  const ReflectionsPage({super.key});
  @override
  State<ReflectionsPage> createState() => _ReflectionsPageState();
}

class _ReflectionsPageState extends State<ReflectionsPage> {
  int current = 0;

  static const List<String> quoteKeys = [
    'quote_1',
    'quote_2',
    'quote_3',
    'quote_4',
    'quote_5',
    'quote_6',
    'quote_7',
    'quote_8',
    'quote_9',
    'quote_10',
    'quote_11',
    'quote_12',
    'quote_13',
    'quote_14',
    'quote_15',
    'quote_16',
    'quote_17',
    'quote_18',
    'quote_19',
    'quote_20',
  ];

  List<String> getQuotes(AppLocalizations l10n) {
    return [
      l10n.quote_1,
      l10n.quote_2,
      l10n.quote_3,
      l10n.quote_4,
      l10n.quote_5,
      l10n.quote_6,
      l10n.quote_7,
      l10n.quote_8,
      l10n.quote_9,
      l10n.quote_10,
      l10n.quote_11,
      l10n.quote_12,
      l10n.quote_13,
      l10n.quote_14,
      l10n.quote_15,
      l10n.quote_16,
      l10n.quote_17,
      l10n.quote_18,
      l10n.quote_19,
      l10n.quote_20,
    ];
  }

  void _prev() => setState(
    () => current = (current - 1 + quoteKeys.length) % quoteKeys.length,
  );
  void _next() => setState(() => current = (current + 1) % quoteKeys.length);

  //   @override
  //   Widget build(BuildContext context) {
  //     final Size screenSize = MediaQuery.of(context).size;
  //     final l10n = AppLocalizations.of(context)!;
  //     final quotes = getQuotes(l10n);
  //     final isDark = Theme.of(context).brightness == Brightness.dark;
  //     return Scaffold(
  //       backgroundColor: isDark ? const Color(0xFF222C36) : Colors.white,
  //       body: Stack(
  //         children: [
  //           SingleChildScrollView(
  //             padding: const EdgeInsets.only(bottom: 200),
  //             child: Column(
  //               children: [
  //                 const HeaderLogo(),
  //                 const SizedBox(height: 16),
  //                 Text(l10n.reflections, style: MoodTextStyles.bold3.copyWith(color: Colors.black, fontSize: 28)),
  //                 const SizedBox(height: 4),
  //                 Text(l10n.spaceForYourMood, style: MoodTextStyles.normal3.copyWith(color: MoodColors.tPrimaryNormalActive)),
  //                 const SizedBox(height: 42),
  //                 AnimatedSwitcher(
  //                   duration: const Duration(milliseconds: 350),
  //                   transitionBuilder: (child, anim) => FadeTransition(opacity: anim, child: child),
  //                   child: QuoteCard(key: ValueKey(current), quote: quotes[current]),
  //                 ),
  //                 const SizedBox(height: 150),
  //               ],
  //             ),
  //           ),
  //           // Bottom navigation
  //           Positioned(
  //             bottom: 0,
  //             left: 0,
  //             right: 0,
  //             child: Stack(
  //               alignment: Alignment.topCenter,
  //               children: [
  //                 ClipPath(
  //                   clipper: HeaderClipperFavorite(),
  //                   child: Container(height: screenSize.height * 0.3, decoration: BoxDecoration(color: MoodColors.tPrimaryLight)),
  //                 ),
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   children: [
  //                     ArrowButton(icon: MoodIcons.arrowRight, onTap: _prev, flipForRtl: true),
  //                     const SizedBox(width: 60),
  //                     ArrowButton(icon: MoodIcons.arrowLeft, onTap: _next, flipForRtl: true),
  //                   ],
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ],
  //       ),
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final l10n = AppLocalizations.of(context)!;
    final quotes = getQuotes(l10n);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF222C36) : Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 200),
            child: Column(
              children: [
                const HeaderLogo(),
                const SizedBox(height: 16),
                Text(
                  l10n.reflections,
                  style: MoodTextStyles.bold3.copyWith(
                    color: isDark ? Colors.white : Colors.black,
                    fontSize: 28,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  l10n.spaceForYourMood,
                  style: MoodTextStyles.normal3.copyWith(
                    color:
                        isDark
                            ? MoodColors.tPrimaryLightActive
                            : MoodColors.tPrimaryNormalActive,
                  ),
                ),
                const SizedBox(height: 42),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 350),
                  transitionBuilder:
                      (child, anim) =>
                          FadeTransition(opacity: anim, child: child),
                  child: QuoteCard(
                    key: ValueKey(current),
                    quote: quotes[current],
                    isDark: isDark,
                  ),
                ),
                const SizedBox(height: 150),
              ],
            ),
          ),
          // Bottom navigation
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                ClipPath(
                  clipper: HeaderClipperFavorite(),
                  child: Container(
                    height: screenSize.height * 0.3,
                    decoration: BoxDecoration(
                      color:
                          isDark
                              ? MoodColors.tPrimaryDark
                              : MoodColors.tPrimaryLight,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ArrowButton(
                      icon: MoodIcons.arrowRight,
                      onTap: _prev,
                      flipForRtl: true,
                      isDark: isDark,
                    ),
                    const SizedBox(width: 60),
                    ArrowButton(
                      icon: MoodIcons.arrowLeft,
                      onTap: _next,
                      flipForRtl: true,
                      isDark: isDark,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
