import 'package:flutter/material.dart';
import 'package:mood_map/core/constants/mood_utils.dart';
import 'package:mood_map/core/theme/text_styles.dart';
import 'package:mood_map/features/mood/domain/enums/mood_type.dart';
import 'package:mood_map/core/widgets/success_dialog.dart';
import 'package:mood_map/features/mood/data/models/chart_model.dart';
import 'emojis_bar_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mood_map/features/settings/cubit/app_settings_cubit.dart';
import 'package:mood_map/features/mood/presentation/cubit/mood_cubit.dart';
import 'package:mood_map/l10n/app_localizations.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:io';

class MoodCountCard extends StatefulWidget {
  const MoodCountCard({
    super.key,
    this.month,
    this.year,
    this.weekStart,
    this.weekEnd,
    this.filter,
  });

  final int? month;
  final int? year;
  final DateTime? weekStart;
  final DateTime? weekEnd;
  final MoodType? filter;

  @override
  State<MoodCountCard> createState() => _MoodCountCardState();
}

class _MoodCountCardState extends State<MoodCountCard> {
  final ScreenshotController _screenshotController = ScreenshotController();

  Future<void> _shareCard() async {
    try {
      final image = await _screenshotController.capture();
      if (image != null) {
        final tempDir = await Directory.systemTemp.createTemp();
        final file = await File('${tempDir.path}/mood_card.png').create();
        await file.writeAsBytes(image);
        await Share.shareXFiles([
          XFile(file.path),
        ], text: AppLocalizations.of(context)!.shareMoodStats);
        if (mounted) {
          SuccessDialogWidget();
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              AppLocalizations.of(context)!.shareError + e.toString(),
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final moodCubit = context.watch<MoodCubit>();
    final settingsState = context.watch<AppSettingsCubit>().state;
    final isDark = settingsState.isDarkMode;

    final cardColor = Theme.of(context).cardTheme.color;
    final textColor =
        Theme.of(context).textTheme.headlineSmall?.color ?? Colors.black;

    Map<MoodType, int> counts;
    if (widget.weekStart != null && widget.weekEnd != null) {
      counts = moodCubit.getMoodCountForWeek(
        widget.weekStart!,
        widget.weekEnd!,
        filter: widget.filter,
      );
    } else {
      counts = moodCubit.getMoodCountForMonth(
        widget.month!,
        widget.year!,
        filter: widget.filter,
      );
    }

    final moods = getMoodList(context);

    final total = counts.values.fold<int>(0, (sum, c) => sum + c);
    final chartData =
        moods
            .map(
              (m) => ChartData(
                m['label'] as String,
                (counts[m['type']] ?? 0).toDouble(),
                m['color'] as Color,
              ),
            )
            .toList();

    return Screenshot(
      controller: _screenshotController,
      child: Container(
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: isDark ? Colors.black26 : Colors.black12.withAlpha(20),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    AppLocalizations.of(context)!.moodCount,
                    style: MoodTextStyles.heading3.copyWith(color: textColor),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: Icon(
                      Icons.ios_share_rounded,
                      color: isDark ? Colors.white70 : Colors.black54,
                    ),
                    onPressed: _shareCard,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 200,
                child: Stack(
                  children: [
                    SizedBox(
                      height: 180,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          SfCircularChart(
                            margin: EdgeInsets.zero,
                            series: <CircularSeries>[
                              DoughnutSeries<ChartData, String>(
                                dataSource: chartData,
                                xValueMapper: (d, _) => d.mood,
                                yValueMapper: (d, _) => d.count,
                                pointColorMapper: (d, _) => d.color,
                                radius: '100%',
                                innerRadius: '70%',
                                startAngle: 270,
                                endAngle: 90,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Text(
                          '$total',
                          style: MoodTextStyles.heading1.copyWith(
                            color: textColor,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: EmojisBarCounter(moods: moods, counts: counts),
                    ),
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
