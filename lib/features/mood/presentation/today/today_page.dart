import 'package:flutter/material.dart';
import 'package:mood_map/core/theme/text_styles.dart';
import 'package:mood_map/core/widgets/error_dialog.dart';
import 'package:mood_map/core/widgets/saved_dialog.dart';
import 'package:mood_map/features/mood/domain/enums/mood_type.dart';
import 'package:mood_map/features/provider/app_settings_provider.dart';
import 'package:mood_map/features/mood/presentation/providers/mood_provider.dart';
import 'widgets/mood_btn.dart';
import 'widgets/mood_header.dart';
import 'widgets/mood_emojis.dart';
import 'widgets/mood_text_field.dart';
import 'package:mood_map/l10n/app_localizations.dart';
import 'package:provider/provider.dart';

// class TodayPage extends StatelessWidget {
//   const TodayPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<MoodProvider>(context);
//     final List<MoodType> moodList = MoodType.values;

//     return Scaffold(
//       backgroundColor: MoodColors.awfulLight,
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             MoodHeader(),

//             const SizedBox(height: 40),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 24.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     AppLocalizations.of(context)!.howAreYouFeeling,
//                     style: MoodTextStyles.bold4.copyWith(fontWeight: FontWeight.w500, fontSize: 24, height: 1.46),
//                   ),
//                   const SizedBox(height: 16),
//                   MoodEmojis(moodList: moodList, selected: provider.selectedMood, onSelect: provider.setMood),
//                   const SizedBox(height: 24),
//                   MoodTextField(controller: provider.noteController),
//                   const SizedBox(height: 12),

//                   SizedBox(
//                     width: double.infinity,
//                     child: MoodButton(
//                       text: AppLocalizations.of(context)!.saveMood,

//                       onPressed: () async {
//                         // Provider.of<MoodProvider>(context, listen: false).seedMoodEntriesForCurrentMonth();
//                         final result = await provider.saveMood();
//                         if (result == MoodSaveResult.noMood) {
//                           errorDialog(context, AppLocalizations.of(context)!.chooseModeFirst);
//                         } else if (result == MoodSaveResult.emptyNote) {
//                           errorDialog(context, AppLocalizations.of(context)!.emptyTextFieldError);
//                         } else if (result == MoodSaveResult.success) {
//                           savedDialog(context);
//                         } else if (result == MoodSaveResult.error) {
//                           errorDialog(context, AppLocalizations.of(context)!.unexpectedError);
//                         }
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
class TodayPage extends StatelessWidget {
  const TodayPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MoodProvider>(context);
    final settings = Provider.of<AppSettingsProvider>(context, listen: true);
    final List<MoodType> moodList = MoodType.values;
    final isDark = settings.isDarkMode;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            MoodHeader(),

            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.howAreYouFeeling,
                    style: MoodTextStyles.bold4.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 24,
                      height: 1.46,
                      color:
                          isDark ? Colors.white : Colors.black, // لون ديناميكي
                      fontFamily:
                          Localizations.localeOf(context).languageCode == 'ar'
                              ? 'Zain'
                              : 'Poppins',
                    ),
                  ),
                  const SizedBox(height: 16),
                  MoodEmojis(
                    moodList: moodList,
                    selected: provider.selectedMood,
                    onSelect: provider.setMood,
                  ),
                  const SizedBox(height: 24),
                  MoodTextField(controller: provider.noteController),
                  const SizedBox(height: 12),

                  SizedBox(
                    width: double.infinity,
                    child: MoodButton(
                      text: AppLocalizations.of(context)!.saveMood,
                      onPressed: () async {
                        final result = await provider.saveMood();
                        if (result == MoodSaveResult.noMood) {
                          errorDialog(
                            context,
                            AppLocalizations.of(context)!.chooseModeFirst,
                          );
                        } else if (result == MoodSaveResult.emptyNote) {
                          errorDialog(
                            context,
                            AppLocalizations.of(context)!.emptyTextFieldError,
                          );
                        } else if (result == MoodSaveResult.success) {
                          savedDialog(context);
                        } else if (result == MoodSaveResult.error) {
                          errorDialog(
                            context,
                            AppLocalizations.of(context)!.unexpectedError,
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
