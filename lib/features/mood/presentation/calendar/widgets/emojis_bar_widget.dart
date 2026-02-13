import 'package:flutter/material.dart';
import 'package:mood_map/core/theme/text_styles.dart';
import 'package:mood_map/features/mood/domain/enums/mood_type.dart';

// class EmojisBarCounter extends StatelessWidget {
//   const EmojisBarCounter({super.key, required this.moods, required this.counts});

//   final List<Map<String, Object>> moods;
//   final Map<MoodType, int> counts;

//   @override
//   Widget build(BuildContext context) {
//     return Positioned(
//       bottom: 0,
//       child: SizedBox(
//         width: MediaQuery.of(context).size.width * 0.79,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children:
//               moods.map((m) {
//                 final count = counts[m['type']] ?? 0;
//                 final color = m['color'] as Color;
//                 return Column(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(2.0),
//                       child: Stack(
//                         clipBehavior: Clip.none,
//                         children: [
//                           CircleAvatar(
//                             backgroundColor: color.withAlpha(59),
//                             radius: 28,
//                             child: Image.asset(m['icon'] as String, width: 48, height: 48, fit: BoxFit.contain),
//                           ),
//                           if (count > 0)
//                             Positioned(
//                               top: -8,
//                               right: -8,
//                               child: Container(
//                                 padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
//                                 decoration: BoxDecoration(
//                                   color: color,
//                                   borderRadius: BorderRadius.circular(15),
//                                   border: Border.all(color: Colors.white, width: 1),
//                                 ),
//                                 child: Text(
//                                   '$count',
//                                   style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
//                                 ),
//                               ),
//                             ),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(height: 3),
//                     Text(
//                       m['label'] as String,
//                       style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 13, letterSpacing: 0.1),
//                     ),
//                   ],
//                 );
//               }).toList(),
//         ),
//       ),
//     );
//   }
// }

class EmojisBarCounter extends StatelessWidget {
  const EmojisBarCounter({
    super.key,
    required this.moods,
    required this.counts,
  });

  final List<Map<String, Object>> moods;
  final Map<MoodType, int> counts;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final lang = Localizations.localeOf(context).languageCode;
    final Color badgeTextColor =
        isDark ? Colors.black : Colors.white; // فقط مثال للتوضيح

    return Positioned(
      bottom: 0,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.79,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children:
              moods.map((m) {
                final count = counts[m['type']] ?? 0;
                final color = m['color'] as Color;
                final String label = m['label'] as String;

                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          CircleAvatar(
                            backgroundColor: color.withAlpha(59),
                            radius: 28,
                            child: Image.asset(
                              m['icon'] as String,
                              width: 48,
                              height: 48,
                              fit: BoxFit.contain,
                            ),
                          ),
                          if (count > 0)
                            Positioned(
                              top: -8,
                              right: -8,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 7,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: color,
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                    color: isDark ? Colors.black : Colors.white,
                                    width: 1,
                                  ),
                                ),
                                child: Text(
                                  '$count',
                                  style: MoodTextStyles.normal1.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    color: badgeTextColor,
                                    fontFamily:
                                        lang == 'ar' ? 'Zain' : 'Poppins',
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      label,
                      style: MoodTextStyles.normal1.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        letterSpacing: 0.1,
                        color: color,
                        fontFamily: lang == 'ar' ? 'Zain' : 'Poppins',
                      ),
                    ),
                  ],
                );
              }).toList(),
        ),
      ),
    );
  }
}
