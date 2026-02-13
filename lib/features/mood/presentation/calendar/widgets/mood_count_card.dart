import 'package:flutter/material.dart';
import 'package:mood_map/core/constants/colors.dart';
import 'package:mood_map/core/constants/icons.dart';
import 'package:mood_map/core/constants/mood_utils.dart';
import 'package:mood_map/features/mood/domain/enums/mood_type.dart';
import 'package:mood_map/core/widgets/success_dialog.dart';
import 'package:mood_map/features/mood/data/models/chart_model.dart';
import 'emojis_bar_widget.dart';
import 'package:mood_map/features/provider/app_settings_provider.dart';
import 'package:mood_map/features/mood/presentation/providers/mood_provider.dart';
import 'package:mood_map/l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

// قطعة العد والإحصائية مع الأنيميشن
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
  final MoodType? filter; // الجديد

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
        // إظهار رسالة نجاح بعد المشاركة
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

  //   @override
  //   Widget build(BuildContext context) {
  //     final provider = Provider.of<MoodProvider>(context);

  //     Map<MoodType, int> counts;
  //     if (widget.weekStart != null && widget.weekEnd != null) {
  //       counts = provider.getMoodCountForWeek(widget.weekStart!, widget.weekEnd!, filter: widget.filter);
  //     } else {
  //       counts = provider.getMoodCountForMonth(widget.month!, widget.year!, filter: widget.filter);
  //     }

  //     final moods = [
  //       {'type': MoodType.happy, 'icon': MoodEmoji.happy, 'label': AppLocalizations.of(context)!.happy, 'color': MoodColors.happyNormal},
  //       {'type': MoodType.good, 'icon': MoodEmoji.good, 'label': AppLocalizations.of(context)!.good, 'color': MoodColors.goodNormal},
  //       {'type': MoodType.okay, 'icon': MoodEmoji.okay, 'label': AppLocalizations.of(context)!.okay, 'color': MoodColors.okNormal},
  //       {'type': MoodType.bad, 'icon': MoodEmoji.bad, 'label': AppLocalizations.of(context)!.bad, 'color': MoodColors.badNormal},
  //       {'type': MoodType.awfull, 'icon': MoodEmoji.awfull, 'label': AppLocalizations.of(context)!.awfull, 'color': MoodColors.awfulNormal},
  //     ];

  //     final total = counts.values.fold<int>(0, (sum, c) => sum + c);
  //     final chartData = moods.map((m) => ChartData(m['label'] as String, (counts[m['type']] ?? 0).toDouble(), m['color'] as Color)).toList();

  //     return Screenshot(
  //       controller: _screenshotController,
  //       child: Container(
  //         decoration: BoxDecoration(
  //           color: Colors.white,
  //           borderRadius: BorderRadius.circular(24),
  //           boxShadow: [BoxShadow(color: Colors.black12.withOpacity(0.07), blurRadius: 12, offset: const Offset(0, 4))],
  //         ),
  //         child: Padding(
  //           padding: const EdgeInsets.all(16),
  //           child: Column(
  //             children: [
  //               Row(
  //                 children: [
  //                   Text(
  //                     AppLocalizations.of(context)!.moodCount,
  //                     style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: MoodColors.badDarker),
  //                   ),
  //                   const Spacer(),
  //                   GestureDetector(
  //                     onTap: _shareCard,
  //                     child: Image.asset(MoodIcons.share, width: 24, height: 24, color: MoodColors.awfulNormalActive),
  //                   ),
  //                 ],
  //               ),
  //               const SizedBox(height: 8),
  //               // نصف الدائرة
  //               SizedBox(
  //                 height: 190,
  //                 child: Stack(
  //                   children: [
  //                     SizedBox(
  //                       height: 170,
  //                       child: Stack(
  //                         alignment: Alignment.center,
  //                         children: [
  //                           SfCircularChart(
  //                             margin: EdgeInsets.zero,
  //                             series: <DoughnutSeries<ChartData, String>>[
  //                               DoughnutSeries<ChartData, String>(
  //                                 dataSource: chartData,
  //                                 xValueMapper: (d, _) => d.mood,
  //                                 yValueMapper: (d, _) => d.count,
  //                                 pointColorMapper: (d, _) => d.color,
  //                                 radius: '100%',
  //                                 innerRadius: '68%',
  //                                 startAngle: -90,
  //                                 endAngle: 90,
  //                                 explode: true,
  //                                 explodeOffset: '2%',
  //                                 animationDuration: 800,
  //                               ),
  //                             ],
  //                           ),
  //                           Positioned(
  //                             top: 40,
  //                             child: Text(
  //                               '$total',
  //                               style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 33, color: MoodColors.badDarker),
  //                             ),
  //                           ),
  //                           const Divider(height: 32, color: Color(0xFFEAEAEA), thickness: 1),
  //                         ],
  //                       ),
  //                     ),
  //                     // الأيقونات في الأسفل
  //                     EmojisBarCounter(moods: moods, counts: counts),
  //                   ],
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MoodProvider>(context);
    final settings = Provider.of<AppSettingsProvider>(context, listen: false);

    // الألوان حسب الثيم
    final cardColor = Theme.of(context).cardColor;
    final textColor =
        Theme.of(context).textTheme.displayMedium?.color ?? Colors.black;
    final dividerColor =
        settings.isDarkMode ? Colors.white12 : const Color(0xFFEAEAEA);

    Map<MoodType, int> counts;
    if (widget.weekStart != null && widget.weekEnd != null) {
      counts = provider.getMoodCountForWeek(
        widget.weekStart!,
        widget.weekEnd!,
        filter: widget.filter,
      );
    } else {
      counts = provider.getMoodCountForMonth(
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
              color:
                  settings.isDarkMode
                      ? Colors.black26
                      : Colors.black12.withAlpha(18),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    AppLocalizations.of(context)!.moodCount,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: textColor,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: _shareCard,
                    child: Image.asset(
                      MoodIcons.share,
                      width: 24,
                      height: 24,
                      color:
                          settings.isDarkMode
                              ? MoodColors.awfulDarkActive
                              : MoodColors.awfulNormalActive,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 190,
                child: Stack(
                  children: [
                    SizedBox(
                      height: 170,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          SfCircularChart(
                            margin: EdgeInsets.zero,
                            series: <DoughnutSeries<ChartData, String>>[
                              DoughnutSeries<ChartData, String>(
                                dataSource: chartData,
                                xValueMapper: (d, _) => d.mood,
                                yValueMapper: (d, _) => d.count,
                                pointColorMapper: (d, _) => d.color,
                                radius: '100%',
                                innerRadius: '68%',
                                startAngle: -90,
                                endAngle: 90,
                                explode: true,
                                explodeOffset: '2%',
                                animationDuration: 800,
                              ),
                            ],
                          ),
                          Positioned(
                            top: 40,
                            child: Text(
                              '$total',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 33,
                                color: textColor,
                              ),
                            ),
                          ),
                          Divider(
                            height: 32,
                            color: dividerColor,
                            thickness: 1,
                          ),
                        ],
                      ),
                    ),
                    EmojisBarCounter(moods: moods, counts: counts),
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
