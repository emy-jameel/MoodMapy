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
          // Background Gradient Element
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors:
                      isDark
                          ? [
                            MoodColors.primaryDark.withAlpha(50),
                            Colors.transparent,
                          ]
                          : [
                            MoodColors.primaryLight.withAlpha(100),
                            Colors.transparent,
                          ],
                ),
              ),
            ),
          ),

          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 200),
            child: Column(
              children: [
                const HeaderLogo(),
                const SizedBox(height: 24),
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: const Duration(milliseconds: 800),
                  builder: (context, value, child) {
                    return Opacity(
                      opacity: value,
                      child: Transform.translate(
                        offset: Offset(0, 20 * (1 - value)),
                        child: child,
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      Text(
                        l10n.reflections,
                        style: MoodTextStyles.heading2.copyWith(
                          color: isDark ? Colors.white : Colors.black,
                          fontSize: 28,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        l10n.spaceForYourMood,
                        style: MoodTextStyles.body1.copyWith(
                          color:
                              isDark
                                  ? MoodColors.tPrimaryLightActive
                                  : MoodColors.tPrimaryNormalActive,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 60),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  switchInCurve: Curves.easeOutBack,
                  switchOutCurve: Curves.easeInBack,
                  transitionBuilder: (child, anim) {
                    return SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0.0, 0.1),
                        end: Offset.zero,
                      ).animate(anim),
                      child: FadeTransition(opacity: anim, child: child),
                    );
                  },
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
                    height: screenSize.height * 0.28,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors:
                            isDark
                                ? [
                                  MoodColors.tPrimaryDark,
                                  const Color(0xFF1A222C),
                                ]
                                : [MoodColors.tPrimaryLight, Colors.white],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ArrowButton(
                        icon: MoodIcons.arrowRight,
                        onTap: () {
                          _prev();
                        },
                        flipForRtl: true,
                        isDark: isDark,
                      ),
                      const SizedBox(width: 80),
                      ArrowButton(
                        icon: MoodIcons.arrowLeft,
                        onTap: () {
                          _next();
                        },
                        flipForRtl: true,
                        isDark: isDark,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
