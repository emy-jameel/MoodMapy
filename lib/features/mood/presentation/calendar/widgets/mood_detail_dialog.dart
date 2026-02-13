import 'package:flutter/material.dart';
import 'package:mood_map/core/constants/mood_utils.dart';
import 'package:mood_map/features/mood/domain/entities/mood_entity.dart';
import 'package:mood_map/l10n/app_localizations.dart';
import 'mood_edit_dialog.dart';

// class MoodDetailDialog extends StatelessWidget {
//   final MoodEntry entry;
//   const MoodDetailDialog({required this.entry, super.key});

//   @override
//   Widget build(BuildContext context) {
//     final moods = {
//       MoodType.happy: {'label': AppLocalizations.of(context)!.happy, 'icon': MoodEmoji.happy, 'color': MoodColors.happyNormal},
//       MoodType.good: {'label': AppLocalizations.of(context)!.good, 'icon': MoodEmoji.good, 'color': MoodColors.goodNormal},
//       MoodType.okay: {'label': AppLocalizations.of(context)!.okay, 'icon': MoodEmoji.okay, 'color': MoodColors.okNormal},
//       MoodType.bad: {'label': AppLocalizations.of(context)!.bad, 'icon': MoodEmoji.bad, 'color': MoodColors.badNormal},
//       MoodType.awfull: {'label': AppLocalizations.of(context)!.awfull, 'icon': MoodEmoji.awfull, 'color': MoodColors.awfulNormal},
//     };

//     final mood = moods[entry.mood]!;

//     return Dialog(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(38)),
//       backgroundColor: Colors.white,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Row(
//               children: [
//                 GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.close, color: Colors.red, size: 32)),
//                 const Spacer(),
//                 Text('${entry.date.day}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28)),
//               ],
//             ),
//             const SizedBox(height: 8),
//             Image.asset(mood['icon'] as String, width: 64, height: 64),
//             const SizedBox(height: 8),
//             Text(mood['label'] as String, style: TextStyle(color: mood['color'] as Color, fontWeight: FontWeight.bold, fontSize: 18)),
//             const SizedBox(height: 12),
//             Text(
//               entry.note ?? '',
//               style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500, height: 1.3),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 24),
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton.icon(
//                 icon: const Icon(Icons.edit, color: Colors.black54),
//                 label: Text(
//                   AppLocalizations.of(context)!.edit,
//                   style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22),
//                 ),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.lightBlue[100],
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
//                   padding: const EdgeInsets.symmetric(vertical: 14),
//                 ),
//                 onPressed: () async {
//                   Navigator.pop(context); // اغلق نافذة التفاصيل
//                   // افتح نافذة التعديل
//                   showDialog(context: context, builder: (_) => MoodEditDialog(date: entry.date, existingEntry: entry));
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class MoodDetailDialog extends StatelessWidget {
  final MoodEntry entry;
  const MoodDetailDialog({required this.entry, super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    // استخدم getMoodList للحصول على كل المودز
    final moods = getMoodList(context);
    // ابحث عن المود المطلوب بناءً على type
    final mood = moods.firstWhere((m) => m['type'] == entry.mood);

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(38)),
      backgroundColor: Theme.of(context).dialogBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(
                    Icons.close,
                    color: Colors.red.shade400,
                    size: 32,
                  ),
                ),
                const Spacer(),
                Text(
                  '${entry.date.day}',
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Image.asset(mood['icon'] as String, width: 64, height: 64),
            const SizedBox(height: 8),
            Text(
              mood['label'] as String,
              style: TextStyle(
                color: mood['color'] as Color,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              entry.note ?? '',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w500,
                height: 1.3,
                color: isDark ? Colors.white70 : Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: Icon(
                  Icons.edit,
                  color: isDark ? Colors.white70 : Colors.black54,
                ),
                label: Text(
                  AppLocalizations.of(context)!.edit,
                  style: TextStyle(
                    color: isDark ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      isDark ? Colors.blueGrey[800] : Colors.lightBlue[100],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () async {
                  Navigator.pop(context); // اغلق نافذة التفاصيل
                  showDialog(
                    context: context,
                    builder:
                        (_) => MoodEditDialog(
                          date: entry.date,
                          existingEntry: entry,
                        ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
