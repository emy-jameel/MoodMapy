import 'package:flutter/material.dart';
import 'package:mood_map/core/theme/text_styles.dart';
import 'package:mood_map/core/widgets/error_dialog.dart';
import 'package:mood_map/core/widgets/saved_dialog.dart';
import 'package:mood_map/features/mood/domain/enums/mood_type.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mood_map/features/mood/presentation/cubit/mood_cubit.dart';
import 'package:mood_map/features/mood/presentation/cubit/mood_state.dart';
import 'package:mood_map/features/settings/cubit/app_settings_cubit.dart';
import 'package:mood_map/features/settings/cubit/app_settings_state.dart';
import 'widgets/mood_btn.dart';
import 'widgets/mood_header.dart';
import 'widgets/mood_emojis.dart';
import 'widgets/mood_text_field.dart';
import 'package:mood_map/l10n/app_localizations.dart';

class TodayPage extends StatefulWidget {
  const TodayPage({super.key});

  @override
  State<TodayPage> createState() => _TodayPageState();
}

class _TodayPageState extends State<TodayPage> {
  final TextEditingController _noteController = TextEditingController();

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<MoodType> moodList = MoodType.values;

    return BlocBuilder<AppSettingsCubit, AppSettingsState>(
      builder: (context, settingsState) {
        final isDark = settingsState.isDarkMode;

        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: SingleChildScrollView(
            child: Column(
              children: [
                const MoodHeader(),
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: BlocBuilder<MoodCubit, MoodState>(
                    builder: (context, moodState) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.howAreYouFeeling,
                            style: MoodTextStyles.bold4.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 24,
                              height: 1.46,
                              color: isDark ? Colors.white : Colors.black,
                              fontFamily:
                                  Localizations.localeOf(
                                            context,
                                          ).languageCode ==
                                          'ar'
                                      ? 'Zain'
                                      : 'Poppins',
                            ),
                          ),
                          const SizedBox(height: 16),
                          MoodEmojis(
                            moodList: moodList,
                            selected: moodState.selectedMood,
                            onSelect:
                                (mood) =>
                                    context.read<MoodCubit>().setMood(mood),
                          ),
                          const SizedBox(height: 24),
                          MoodTextField(controller: _noteController),
                          const SizedBox(height: 12),
                          SizedBox(
                            width: double.infinity,
                            child: MoodButton(
                              text: AppLocalizations.of(context)!.saveMood,
                              onPressed: () async {
                                final result = await context
                                    .read<MoodCubit>()
                                    .saveMood(_noteController.text);
                                if (result == MoodSaveResult.noMood) {
                                  if (mounted) {
                                    errorDialog(
                                      context,
                                      AppLocalizations.of(
                                        context,
                                      )!.chooseModeFirst,
                                    );
                                  }
                                } else if (result == MoodSaveResult.emptyNote) {
                                  if (mounted) {
                                    errorDialog(
                                      context,
                                      AppLocalizations.of(
                                        context,
                                      )!.emptyTextFieldError,
                                    );
                                  }
                                } else if (result == MoodSaveResult.success) {
                                  if (mounted) {
                                    _noteController.clear();
                                    savedDialog(context);
                                  }
                                } else if (result == MoodSaveResult.error) {
                                  if (mounted) {
                                    errorDialog(
                                      context,
                                      AppLocalizations.of(
                                        context,
                                      )!.unexpectedError,
                                    );
                                  }
                                }
                              },
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
