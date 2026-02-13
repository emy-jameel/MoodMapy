import 'package:flutter/material.dart';
import 'package:mood_map/core/constants/colors.dart';
import 'package:mood_map/core/constants/date_utils.dart';
import 'package:mood_map/features/mood/domain/enums/mood_type.dart';
import 'package:mood_map/core/widgets/error_dialog.dart';
import 'mood_detail_dialog.dart';
import 'mood_edit_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mood_map/features/mood/presentation/cubit/mood_cubit.dart';
import 'package:mood_map/l10n/app_localizations.dart';

// class MoodMonthView extends StatefulWidget {
//   const MoodMonthView({super.key, required this.month, required this.year, required this.onMonthChanged, this.filter});

//   final int month;
//   final int year;
//   final Function(int, int) onMonthChanged;
//   final MoodType? filter; // الجديد
//   @override
//   State<MoodMonthView> createState() => _MoodMonthViewState();
// }

// class _MoodMonthViewState extends State<MoodMonthView> {
//   late int _displayedYear;
//   late int _displayedMonth;

//   @override
//   void initState() {
//     super.initState();
//     _displayedYear = widget.year; // استخدم القيم القادمة من الصفحة الرئيسية
//     _displayedMonth = widget.month;
//   }

//   void _prevMonth() {
//     setState(() {
//       if (_displayedMonth == 1) {
//         _displayedMonth = 12;
//         _displayedYear--;
//       } else {
//         _displayedMonth--;
//       }
//     });
//     // مهم: أخبر CalendarPage بتغيير الشهر
//     widget.onMonthChanged(_displayedMonth, _displayedYear);
//   }

//   void _nextMonth() {
//     setState(() {
//       if (_displayedMonth == 12) {
//         _displayedMonth = 1;
//         _displayedYear++;
//       } else {
//         _displayedMonth++;
//       }
//     });
//     // مهم: أخبر CalendarPage بتغيير الشهر
//     widget.onMonthChanged(_displayedMonth, _displayedYear);
//   }

//   @override
//   void didUpdateWidget(covariant MoodMonthView oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     // في حال تغير الشهر من الصفحة الرئيسية (مثلاً بعد العودة من أسبوع)
//     if (widget.month != _displayedMonth || widget.year != _displayedYear) {
//       setState(() {
//         _displayedMonth = widget.month;
//         _displayedYear = widget.year;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<MoodProvider>(context);

//     final int daysInMonth = DateUtils.getDaysInMonth(_displayedYear, _displayedMonth);

//     final firstDayOfMonth = DateTime(_displayedYear, _displayedMonth, 1);
//     final int startWeekday = firstDayOfMonth.weekday % 7;
//     final int leadingEmptyDays = startWeekday;
//     final weekDays = List.generate(7, (i) => weekDayName(i, context));
//     final List<_CalendarDay> calendarDays = [];
//     for (int i = 0; i < leadingEmptyDays; i++) {
//       calendarDays.add(_CalendarDay.empty());
//     }
//     for (int day = 1; day <= daysInMonth; day++) {
//       calendarDays.add(_CalendarDay.day(day));
//     }
//     while (calendarDays.length % 7 != 0) {
//       calendarDays.add(_CalendarDay.empty());
//     }

//     return Container(
//       padding: const EdgeInsets.all(24),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(24),
//         boxShadow: [BoxShadow(color: Colors.black12.withOpacity(0.07), blurRadius: 12, offset: const Offset(0, 4))],
//       ),
//       child: Column(
//         children: [
//           // Month Navigation
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               IconButton(onPressed: _prevMonth, icon: const Icon(Icons.chevron_left, color: MoodColors.badDarker)),
//               Text(
//                 '${monthName(_displayedMonth, context)} $_displayedYear',
//                 style: MoodTextStyles.bold3.copyWith(fontWeight: FontWeight.w500, color: MoodColors.badDarker),
//               ),

//               IconButton(onPressed: _nextMonth, icon: const Icon(Icons.chevron_right, color: MoodColors.badDarker)),
//             ],
//           ),
//           const SizedBox(height: 16),
//           // Weekday labels
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: weekDays.map((day) => Text(day, style: const TextStyle(fontWeight: FontWeight.w600))).toList(),
//           ),
//           const SizedBox(height: 12),
//           // Calendar grid
//           GridView.builder(
//             shrinkWrap: true,
//             physics: const NeverScrollableScrollPhysics(),
//             itemCount: calendarDays.length,
//             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7, mainAxisSpacing: 8, crossAxisSpacing: 8),
//             itemBuilder: (context, index) {
//               final calDay = calendarDays[index];
//               if (calDay.isEmpty) return const SizedBox.shrink();
//               final day = calDay.day!;
//               final moodType = provider.getMoodTypeForDay(day, _displayedMonth, _displayedYear);
//               bool matchesFilter = widget.filter == null || moodType == widget.filter;

//               final DateTime today = DateTime.now();
//               final DateTime selectedDate = DateTime(_displayedYear, _displayedMonth, day);
//               final bool isFuture = selectedDate.isAfter(DateTime(today.year, today.month, today.day));

//               final color =
//                   isFuture
//                       ? MoodColors.awfulLight
//                       : (matchesFilter ? provider.getMoodColorForDay(day, _displayedMonth, _displayedYear) : Colors.grey.withOpacity(0.14));

//               final bool isToday = today.year == _displayedYear && today.month == _displayedMonth && today.day == day;

//               return GestureDetector(
//                 onTap:
//                     isFuture
//                         ? () {
//                           errorDialog(context, AppLocalizations.of(context)!.errorFutureDate);
//                         }
//                         : () {
//                           final entry = provider.getMoodByDate(selectedDate);
//                           if (entry != null) {
//                             showDialog(context: context, builder: (_) => MoodDetailDialog(entry: entry));
//                           } else {
//                             showDialog(context: context, builder: (_) => MoodEditDialog(date: selectedDate));
//                           }
//                         },
//                 child: Container(
//                   key: ValueKey('${_displayedYear}_$_displayedMonth\_$day'),
//                   alignment: Alignment.center,
//                   decoration: BoxDecoration(
//                     color: color,
//                     borderRadius: BorderRadius.circular(10),
//                     border: isToday ? Border.all(color: MoodColors.primaryDarker, width: 1) : Border.all(color: MoodColors.awfulNormal),
//                   ),
//                   child: Text(
//                     '$day',
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       color: isFuture ? MoodColors.awfulNormalActive : MoodColors.primaryDarker,
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

class MoodMonthView extends StatefulWidget {
  const MoodMonthView({
    super.key,
    required this.month,
    required this.year,
    required this.onMonthChanged,
    this.filter,
  });

  final int month;
  final int year;
  final Function(int, int) onMonthChanged;
  final MoodType? filter;

  @override
  State<MoodMonthView> createState() => _MoodMonthViewState();
}

class _MoodMonthViewState extends State<MoodMonthView> {
  late int _displayedYear;
  late int _displayedMonth;

  @override
  void initState() {
    super.initState();
    _displayedYear = widget.year;
    _displayedMonth = widget.month;
  }

  void _prevMonth() {
    setState(() {
      if (_displayedMonth == 1) {
        _displayedMonth = 12;
        _displayedYear--;
      } else {
        _displayedMonth--;
      }
    });
    widget.onMonthChanged(_displayedMonth, _displayedYear);
  }

  void _nextMonth() {
    setState(() {
      if (_displayedMonth == 12) {
        _displayedMonth = 1;
        _displayedYear++;
      } else {
        _displayedMonth++;
      }
    });
    widget.onMonthChanged(_displayedMonth, _displayedYear);
  }

  @override
  void didUpdateWidget(covariant MoodMonthView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.month != _displayedMonth || widget.year != _displayedYear) {
      setState(() {
        _displayedMonth = widget.month;
        _displayedYear = widget.year;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final moodCubit = context.watch<MoodCubit>();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    final int daysInMonth = DateUtils.getDaysInMonth(
      _displayedYear,
      _displayedMonth,
    );

    final firstDayOfMonth = DateTime(_displayedYear, _displayedMonth, 1);
    final int startWeekday = firstDayOfMonth.weekday % 7;
    final int leadingEmptyDays = startWeekday;
    final weekDays = List.generate(7, (i) => weekDayName(i, context));
    final List<_CalendarDay> calendarDays = [];
    for (int i = 0; i < leadingEmptyDays; i++) {
      calendarDays.add(_CalendarDay.empty());
    }
    for (int day = 1; day <= daysInMonth; day++) {
      calendarDays.add(_CalendarDay.day(day));
    }
    while (calendarDays.length % 7 != 0) {
      calendarDays.add(_CalendarDay.empty());
    }

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF232c3b) : Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color:
                isDark
                    ? Colors.black.withAlpha(54)
                    : Colors.black12.withAlpha(18),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Month Navigation
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: _prevMonth,
                icon: Icon(
                  Icons.chevron_left,
                  color: isDark ? colorScheme.primary : MoodColors.badDarker,
                ),
              ),
              Text(
                '${monthName(_displayedMonth, context)} $_displayedYear',
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: isDark ? colorScheme.primary : MoodColors.badDarker,
                  fontSize: 20,
                ),
              ),
              IconButton(
                onPressed: _nextMonth,
                icon: Icon(
                  Icons.chevron_right,
                  color: isDark ? colorScheme.primary : MoodColors.badDarker,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Weekday labels
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children:
                weekDays
                    .map(
                      (day) => Text(
                        day,
                        style: textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: isDark ? Colors.white70 : Colors.grey[800],
                        ),
                      ),
                    )
                    .toList(),
          ),
          const SizedBox(height: 12),
          // Calendar grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: calendarDays.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            ),
            itemBuilder: (context, index) {
              final calDay = calendarDays[index];
              if (calDay.isEmpty) return const SizedBox.shrink();
              final day = calDay.day!;
              final moodType = moodCubit.getMoodTypeForDay(
                day,
                _displayedMonth,
                _displayedYear,
              );
              bool matchesFilter =
                  widget.filter == null || moodType == widget.filter;

              final DateTime today = DateTime.now();
              final DateTime selectedDate = DateTime(
                _displayedYear,
                _displayedMonth,
                day,
              );
              final bool isFuture = selectedDate.isAfter(
                DateTime(today.year, today.month, today.day),
              );

              final color =
                  isFuture
                      ? (isDark ? Colors.grey[900] : MoodColors.awfulLight)
                      : (matchesFilter
                          ? moodCubit.getMoodColorForDay(
                            isDark,
                            day,
                            _displayedMonth,
                            _displayedYear,
                          )
                          : (isDark
                              ? Colors.grey[800]!.withAlpha(25)
                              : Colors.grey.withAlpha(36)));

              final bool isToday =
                  today.year == _displayedYear &&
                  today.month == _displayedMonth &&
                  today.day == day;

              return GestureDetector(
                onTap:
                    isFuture
                        ? () {
                          errorDialog(
                            context,
                            AppLocalizations.of(context)!.errorFutureDate,
                          );
                        }
                        : () {
                          final entry = moodCubit.getMoodByDate(selectedDate);
                          if (entry != null) {
                            showDialog(
                              context: context,
                              builder: (_) => MoodDetailDialog(entry: entry),
                            );
                          } else {
                            showDialog(
                              context: context,
                              builder:
                                  (_) => MoodEditDialog(date: selectedDate),
                            );
                          }
                        },
                child: Container(
                  key: ValueKey('${_displayedYear}_$_displayedMonth\_$day'),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(10),
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
                  child: Text(
                    '$day',
                    style: textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color:
                          isFuture
                              ? (isDark
                                  ? Colors.grey[600]
                                  : MoodColors.awfulNormalActive)
                              : (isDark
                                  ? MoodColors.primaryNormalHover
                                  : MoodColors.primaryDarker),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

// مساعد لتمييز الأيام الفارغة/الحقيقية
class _CalendarDay {
  final int? day;
  final bool isEmpty;
  _CalendarDay.day(this.day) : isEmpty = false;
  _CalendarDay.empty() : day = null, isEmpty = true;
}
