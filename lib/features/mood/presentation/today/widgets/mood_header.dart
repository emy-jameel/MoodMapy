import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mood_map/core/theme/text_styles.dart';
import 'header_clipper.dart';
import 'package:mood_map/core/widgets/header_logo.dart';
import 'package:mood_map/l10n/app_localizations.dart';

class MoodHeader extends StatelessWidget {
  const MoodHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final lang = Localizations.localeOf(context).languageCode;

    // Enhanced Gradients
    final gradient1 = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors:
          isDark
              ? [
                const Color(0xFF4A6fa5),
                const Color(0xFF3B5978),
              ] // Deep Blue-Grey
              : [const Color(0xFFA9DEF9), const Color(0xFF81C9F6)], // Soft Blue
    );
    final gradient2 = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors:
          isDark
              ? [
                const Color(0xFF3B5978).withAlpha(200),
                const Color(0xFF2C435A).withAlpha(150),
              ]
              : [
                const Color(0xFFD0F0FD).withAlpha(200),
                const Color(0xFFB6E6FC).withAlpha(150),
              ],
    );

    return SizedBox(
      height: 320, // Slightly taller for better spacing
      child: Stack(
        children: [
          // Layer 1: Main Gradient Background
          ClipPath(
            clipper: HeaderClipper(),
            child: Container(
              height: 300,
              decoration: BoxDecoration(gradient: gradient1),
            ),
          ),
          // Layer 2: Overlay Gradient for Depth
          ClipPath(
            clipper: HeaderClipperTow(),
            child: Container(
              height: 300,
              decoration: BoxDecoration(gradient: gradient2),
            ),
          ),

          // Header Logo (repositioned slightly)
          const Positioned(top: 0, left: 0, right: 0, child: HeaderLogo()),

          // Text Content with Animation
          Positioned(
            top: 140,
            left: 24,
            right: 24,
            child: Column(
              children: [
                // Animated Entrance for Title
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.easeOutBack,
                  builder: (context, value, child) {
                    return Transform.translate(
                      offset: Offset(0, 20 * (1 - value)),
                      child: Opacity(opacity: value, child: child),
                    );
                  },
                  child: Text(
                    AppLocalizations.of(context)!.todayMood,
                    style: MoodTextStyles.heading1.copyWith(
                      color: isDark ? Colors.white : Colors.black87,
                      fontFamily: lang == 'ar' ? 'Zain' : 'Poppins',
                      shadows: [
                        BoxShadow(
                          color: isDark ? Colors.black45 : Colors.black12,
                          offset: const Offset(0, 4),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 8),
                // Subtitle (Date)
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.easeOutCubic,
                  builder: (context, value, child) {
                    return Transform.translate(
                      offset: Offset(0, 20 * (1 - value)),
                      child: Opacity(opacity: value, child: child),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: isDark ? Colors.black12 : Colors.white30,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isDark ? Colors.white10 : Colors.white24,
                      ),
                    ),
                    child: Text(
                      DateFormat(
                        'EEEE, MMMM d, yyyy',
                        lang,
                      ).format(DateTime.now()),
                      style: MoodTextStyles.body1.copyWith(
                        fontWeight: FontWeight.w500,
                        color:
                            isDark ? Colors.white70 : const Color(0xFF5A7A94),
                        fontFamily: lang == 'ar' ? 'Zain' : 'Poppins',
                      ),
                    ),
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
