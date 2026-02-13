import 'package:flutter/material.dart';
import 'package:mood_map/core/constants/mood_utils.dart';
import 'package:mood_map/features/mood/domain/enums/mood_type.dart';
import 'package:mood_map/core/widgets/success_dialog.dart';
import 'package:mood_map/features/mood/domain/entities/mood_entity.dart';
import 'package:mood_map/features/mood/presentation/providers/mood_provider.dart';
import 'package:mood_map/l10n/app_localizations.dart';
import 'package:provider/provider.dart';

// class MoodEditDialog extends StatefulWidget {
//   final DateTime date;
//   final MoodEntry? existingEntry;

//   const MoodEditDialog({super.key, required this.date, this.existingEntry});

//   @override
//   State<MoodEditDialog> createState() => _MoodEditDialogState();
// }

// class _MoodEditDialogState extends State<MoodEditDialog> {
//   late MoodType? selectedMood;
//   late TextEditingController noteController;

//   @override
//   void initState() {
//     selectedMood = widget.existingEntry?.mood;
//     noteController = TextEditingController(text: widget.existingEntry?.note ?? '');
//     super.initState();
//   }

//   @override
//   void dispose() {
//     noteController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final moods = [
//       {'type': MoodType.happy, 'icon': MoodEmoji.happy},
//       {'type': MoodType.good, 'icon': MoodEmoji.good},
//       {'type': MoodType.okay, 'icon': MoodEmoji.okay},
//       {'type': MoodType.bad, 'icon': MoodEmoji.bad},
//       {'type': MoodType.awfull, 'icon': MoodEmoji.awfull},
//     ];

//     return Dialog(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
//       backgroundColor: Colors.white,
//       child: Padding(
//         padding: const EdgeInsets.all(26),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             // صف الإيموجيات
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children:
//                   moods.map((m) {
//                     final isSelected = m['type'] == selectedMood;
//                     return GestureDetector(
//                       onTap: () => setState(() => selectedMood = m['type'] as MoodType),
//                       child: CircleAvatar(
//                         backgroundColor: isSelected ? Colors.black12 : Colors.transparent,
//                         radius: 24,
//                         child: Image.asset(m['icon'] as String, width: 34, height: 34),
//                       ),
//                     );
//                   }).toList(),
//             ),
//             const SizedBox(height: 12),
//             TextField(
//               controller: noteController,
//               maxLines: 4,
//               maxLength: 100,
//               decoration: InputDecoration(
//                 hintText: AppLocalizations.of(context)!.hintMyMood,
//                 border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
//                 contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//               ),
//               style: const TextStyle(fontSize: 18, height: 1.4),
//             ),
//             const SizedBox(height: 18),
//             Row(
//               children: [
//                 Expanded(
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.red[400],
//                       padding: const EdgeInsets.symmetric(vertical: 13),
//                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                     ),
//                     onPressed: () => Navigator.pop(context),
//                     child: Text(
//                       AppLocalizations.of(context)!.cancel,
//                       style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 19),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 16),
//                 Expanded(
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.lightBlue[100],
//                       padding: const EdgeInsets.symmetric(vertical: 13),
//                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                     ),
//                     onPressed: () async {
//                       if (selectedMood == null) return;
//                       final provider = Provider.of<MoodProvider>(context, listen: false);
//                       final entry = MoodEntry(
//                         mood: selectedMood!,
//                         note: noteController.text.trim(),
//                         date: DateTime(widget.date.year, widget.date.month, widget.date.day),
//                       );
//                       await provider.addMood(entry); // ستعمل تحديث تلقائي لنفس اليوم بسبب مفتاح التاريخ
//                       Navigator.pop(context);
//                       // نافذة النجاح
//                       showDialog(context: context, builder: (_) => const SuccessDialogWidget());
//                     },
//                     child: Text(
//                       AppLocalizations.of(context)!.save,
//                       style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 19),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class MoodEditDialog extends StatefulWidget {
  final DateTime date;
  final MoodEntry? existingEntry;

  const MoodEditDialog({super.key, required this.date, this.existingEntry});

  @override
  State<MoodEditDialog> createState() => _MoodEditDialogState();
}

class _MoodEditDialogState extends State<MoodEditDialog> {
  late MoodType? selectedMood;
  late TextEditingController noteController;

  @override
  void initState() {
    selectedMood = widget.existingEntry?.mood;
    noteController = TextEditingController(
      text: widget.existingEntry?.note ?? '',
    );
    super.initState();
  }

  @override
  void dispose() {
    noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final moods = getMoodList(context);

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
      backgroundColor: Theme.of(context).dialogBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(26),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // صف الإيموجيات
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children:
                  moods.map((m) {
                    final isSelected = m['type'] == selectedMood;
                    return GestureDetector(
                      onTap:
                          () => setState(
                            () => selectedMood = m['type'] as MoodType,
                          ),
                      child: CircleAvatar(
                        backgroundColor:
                            isSelected
                                ? (isDark ? Colors.white12 : Colors.black12)
                                : Colors.transparent,
                        radius: 24,
                        child: Image.asset(
                          m['icon'] as String,
                          width: 34,
                          height: 34,
                        ),
                      ),
                    );
                  }).toList(),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: noteController,
              maxLines: 4,
              maxLength: 100,
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.hintMyMood,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                fillColor: isDark ? Colors.white10 : Colors.white,
                filled: true,
              ),
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(fontSize: 18, height: 1.4),
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red[400],
                      padding: const EdgeInsets.symmetric(vertical: 13),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      AppLocalizations.of(context)!.cancel,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 19,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          isDark ? Colors.blueGrey[800] : Colors.lightBlue[100],
                      padding: const EdgeInsets.symmetric(vertical: 13),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () async {
                      if (selectedMood == null) return;
                      final provider = Provider.of<MoodProvider>(
                        context,
                        listen: false,
                      );
                      final entry = MoodEntry(
                        mood: selectedMood!,
                        note: noteController.text.trim(),
                        date: DateTime(
                          widget.date.year,
                          widget.date.month,
                          widget.date.day,
                        ),
                      );
                      await provider.addMood(entry);
                      Navigator.pop(context);
                      showDialog(
                        context: context,
                        builder: (_) => const SuccessDialogWidget(),
                      );
                    },
                    child: Text(
                      AppLocalizations.of(context)!.save,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black,
                        fontSize: 19,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
