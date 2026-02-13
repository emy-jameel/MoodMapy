import 'package:flutter/material.dart';
import 'package:mood_map/core/constants/colors.dart';
import 'package:mood_map/core/constants/date_utils.dart';
import 'package:mood_map/features/mood/domain/enums/mood_type.dart';
import 'package:mood_map/core/widgets/error_dialog.dart';
import 'mood_detail_dialog.dart';
import 'mood_edit_dialog.dart';
import 'package:mood_map/features/mood/presentation/providers/mood_provider.dart';
import 'package:mood_map/l10n/app_localizations.dart';
import 'package:provider/provider.dart';

// class MoodWeekView extends StatefulWidget {
//   const MoodWeekView({super.key, required this.initialWeekStart, required this.onWeekChanged, this.filter});
//   final DateTime initialWeekStart;
//   final Function(DateTime weekStart, DateTime weekEnd) onWeekChanged;
//   final MoodType? filter;
//   @override
//   State<MoodWeekView> createState() => _MoodWeekViewState();
// }

// class _MoodWeekViewState extends State<MoodWeekView> {
//   late DateTime _weekStart;

//   @override
//   void initState() {
//     super.initState();
//     _weekStart = widget.initialWeekStart;
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       widget.onWeekChanged(_weekStart, _weekStart.add(const Duration(days: 6)));
//     });
//   }

//   void _prevWeek() {
//     setState(() {
//       _weekStart = _weekStart.subtract(const Duration(days: 7));
//     });
//     widget.onWeekChanged(_weekStart, _weekStart.add(const Duration(days: 6)));
//   }

//   void _nextWeek() {
//     setState(() {
//       _weekStart = _weekStart.add(const Duration(days: 7));
//     });
//     widget.onWeekChanged(_weekStart, _weekStart.add(const Duration(days: 6)));
//   }

//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<MoodProvider>(context);
//     final weekDays = List.generate(7, (i) => weekDayName(i, context));

//     final now = DateTime.now();

//     return Container(
//       padding: const EdgeInsets.all(18),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(18),
//         boxShadow: [BoxShadow(color: Colors.black12.withOpacity(0.08), blurRadius: 10, offset: const Offset(0, 4))],
//       ),
//       child: Column(
//         children: [
//           // --- Row أزرار التنقل مع عنوان الأسبوع ---
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               IconButton(onPressed: _prevWeek, icon: const Icon(Icons.chevron_left)),
//               Text(
//                 "${monthName(_weekStart.month, context)} ${_weekStart.year}",
//                 style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
//               ),
//               IconButton(onPressed: _nextWeek, icon: const Icon(Icons.chevron_right)),
//             ],
//           ),
//           const SizedBox(height: 8),
//           // --- Row الأيام ---
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: List.generate(7, (i) {
//               final date = _weekStart.add(Duration(days: i));
//               final moodType = provider.getMoodTypeForDay(date.day, date.month, date.year);
//               final isFiltered = widget.filter != null && moodType != widget.filter;
//               final todayDateOnly = DateTime(now.year, now.month, now.day);
//               final dateOnly = DateTime(date.year, date.month, date.day);
//               final isDark = Theme.of(context).brightness == Brightness.dark;
//               final isFuture = dateOnly.isAfter(todayDateOnly);
//               final isDisabled = isFuture || isFiltered;
//               final color =
//                   isDisabled ? Colors.grey.withAlpha(36) : provider.getMoodColorForDay(isDark, date.day, date.month, date.year);
//               final isToday = dateOnly == todayDateOnly;

//               return Expanded(
//                 child: GestureDetector(
//                   onTap:
//                       isDisabled
//                           ? () {
//                             if (isFuture) {
//                               errorDialog(context, AppLocalizations.of(context)!.errorFutureDate);
//                             }
//                           }
//                           : () {
//                             final entry = provider.getMoodByDate(date);
//                             if (entry != null) {
//                               showDialog(context: context, builder: (_) => MoodDetailDialog(entry: entry));
//                             } else {
//                               showDialog(context: context, builder: (_) => MoodEditDialog(date: date));
//                             }
//                           },
//                   child: Column(
//                     children: [
//                       Text(weekDays[i], style: const TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF4E5A65))),
//                       const SizedBox(height: 7),
//                       Container(
//                         width: 39,
//                         height: 99,
//                         decoration: BoxDecoration(
//                           color: color,
//                           borderRadius: BorderRadius.circular(14),
//                           border: isToday ? Border.all(color: Colors.black, width: 1) : Border.all(color: Colors.black12),
//                         ),
//                         alignment: Alignment.center,
//                         child: Text(
//                           '${date.day}',
//                           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: isDisabled ? Colors.grey[400] : Colors.black),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             }),
//           ),
//         ],
//       ),
//     );
//   }
// }

class MoodWeekView extends StatefulWidget {
  const MoodWeekView({
    super.key,
    required this.initialWeekStart,
    required this.onWeekChanged,
    this.filter,
  });

  final DateTime initialWeekStart;
  final Function(DateTime weekStart, DateTime weekEnd) onWeekChanged;
  final MoodType? filter;

  @override
  State<MoodWeekView> createState() => _MoodWeekViewState();
}

class _MoodWeekViewState extends State<MoodWeekView> {
  late DateTime _weekStart;

  @override
  void initState() {
    super.initState();
    _weekStart = widget.initialWeekStart;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onWeekChanged(_weekStart, _weekStart.add(const Duration(days: 6)));
    });
  }

  void _prevWeek() {
    setState(() {
      _weekStart = _weekStart.subtract(const Duration(days: 7));
    });
    widget.onWeekChanged(_weekStart, _weekStart.add(const Duration(days: 6)));
  }

  void _nextWeek() {
    setState(() {
      _weekStart = _weekStart.add(const Duration(days: 7));
    });
    widget.onWeekChanged(_weekStart, _weekStart.add(const Duration(days: 6)));
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MoodProvider>(context);
    final weekDays = List.generate(7, (i) => weekDayName(i, context));
    final now = DateTime.now();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    // الألوان حسب الثيم
    final backgroundColor = isDark ? const Color(0xFF222C36) : Colors.white;
    final dayTextColor = isDark ? Colors.white : Colors.black;
    final disabledColor =
        isDark ? Colors.grey[700]!.withAlpha(36) : Colors.grey.withAlpha(36);
    final disabledTextColor = isDark ? Colors.grey[500] : Colors.grey[400];

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: isDark ? Colors.black26 : Colors.black12.withAlpha(20),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // --- Row أزرار التنقل مع عنوان الأسبوع ---
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: _prevWeek,
                icon: Icon(
                  Icons.chevron_left,
                  color: isDark ? colorScheme.primary : MoodColors.badDarker,
                ),
              ),
              Text(
                "${monthName(_weekStart.month, context)} ${_weekStart.year}",
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: isDark ? colorScheme.primary : MoodColors.badDarker,
                  fontSize: 20,
                ),
              ),
              IconButton(
                onPressed: _nextWeek,
                icon: Icon(
                  Icons.chevron_right,
                  color: isDark ? colorScheme.primary : MoodColors.badDarker,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // --- Row الأيام ---
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(7, (i) {
              final date = _weekStart.add(Duration(days: i));
              final moodType = provider.getMoodTypeForDay(
                date.day,
                date.month,
                date.year,
              );
              final isFiltered =
                  widget.filter != null && moodType != widget.filter;
              final todayDateOnly = DateTime(now.year, now.month, now.day);
              final dateOnly = DateTime(date.year, date.month, date.day);
              final isFuture = dateOnly.isAfter(todayDateOnly);
              final isDisabled = isFuture || isFiltered;
              final color =
                  isDisabled
                      ? disabledColor
                      : provider.getMoodColorForDay(
                        isDark,
                        date.day,
                        date.month,
                        date.year,
                      );
              final isToday = dateOnly == todayDateOnly;

              return Expanded(
                child: GestureDetector(
                  onTap:
                      isDisabled
                          ? () {
                            if (isFuture) {
                              errorDialog(
                                context,
                                AppLocalizations.of(context)!.errorFutureDate,
                              );
                            }
                          }
                          : () {
                            final entry = provider.getMoodByDate(date);
                            if (entry != null) {
                              showDialog(
                                context: context,
                                builder: (_) => MoodDetailDialog(entry: entry),
                              );
                            } else {
                              showDialog(
                                context: context,
                                builder: (_) => MoodEditDialog(date: date),
                              );
                            }
                          },
                  child: Column(
                    children: [
                      Text(
                        weekDays[i],
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color:
                              isDark ? Colors.white54 : const Color(0xFF4E5A65),
                        ),
                      ),
                      const SizedBox(height: 7),
                      Container(
                        width: 39,
                        height: 99,
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(14),
                          border:
                              isToday
                                  ? Border.all(
                                    color:
                                        isDark
                                            ? colorScheme.primary
                                            : MoodColors.primaryDarker,
                                    width: 2,
                                  )
                                  : Border.all(
                                    color:
                                        isDark
                                            ? Colors.grey[700]!
                                            : MoodColors.awfulNormal,
                                  ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          '${date.day}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color:
                                isDisabled ? disabledTextColor : dayTextColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
