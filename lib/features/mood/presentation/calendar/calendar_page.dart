import 'package:flutter/material.dart';
import 'package:mood_map/core/theme/text_styles.dart';
import 'package:mood_map/features/mood/domain/enums/mood_type.dart';
import 'package:mood_map/core/widgets/header_logo.dart';
import 'widgets/calendar_filter_bar.dart';
import 'widgets/filter_dialog.dart';
import 'widgets/mood_count_card.dart';
import 'widgets/mood_month_calendar.dart';
import 'widgets/mood_week_calendar.dart';
import 'package:mood_map/l10n/app_localizations.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  int selectedMonth = DateTime.now().month;
  int selectedYear = DateTime.now().year;
  bool isWeekView = false;
  MoodType? _selectedFilter;
  DateTime weekStart = DateTime.now().subtract(
    Duration(days: DateTime.now().weekday % 7),
  );
  DateTime weekEnd = DateTime.now().add(
    Duration(days: 6 - DateTime.now().weekday % 7),
  );

  void _onMonthChanged(int month, int year) {
    setState(() {
      selectedMonth = month;
      selectedYear = year;
    });
  }

  void _onWeekChanged(DateTime start, DateTime end) {
    setState(() {
      weekStart = start;
      weekEnd = end;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF222C36) : Colors.white,
      body: SafeArea(
        child: ListView(
          children: [
            const HeaderLogo(),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0.0, end: 1.0),
                    duration: const Duration(milliseconds: 600),
                    curve: Curves.easeOut,
                    builder: (context, value, child) {
                      return Opacity(
                        opacity: value,
                        child: Transform.translate(
                          offset: Offset(0, 20 * (1 - value)),
                          child: child,
                        ),
                      );
                    },
                    child: Text(
                      AppLocalizations.of(context)!.moodCalendar,
                      style: MoodTextStyles.bold4.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Filter bar
                  TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0.0, end: 1.0),
                    duration: const Duration(milliseconds: 600),
                    curve: Curves.easeOut,
                    builder: (context, value, child) {
                      return Opacity(
                        opacity: value,
                        child: Transform.translate(
                          offset: Offset(0, 20 * (1 - value)),
                          child: child,
                        ),
                      );
                    },
                    child: CalendarFilterBar(
                      isWeekView: isWeekView,
                      onWeekTap: () => setState(() => isWeekView = true),
                      onMonthTap: () => setState(() => isWeekView = false),
                      selectedFilter: _selectedFilter,
                      onFilterTap: () async {
                        final result = await showDialog<MoodType>(
                          context: context,
                          builder:
                              (_) => MoodCircleFilterDialog(
                                selected: _selectedFilter,
                              ),
                        );
                        setState(() {
                          _selectedFilter = result;
                        });
                      },
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Calendar View
                  TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0.0, end: 1.0),
                    duration: const Duration(milliseconds: 600),
                    curve: Curves.easeOut,
                    builder: (context, value, child) {
                      return Opacity(
                        opacity: value,
                        child: Transform.translate(
                          offset: Offset(0, 30 * (1 - value)),
                          child: child,
                        ),
                      );
                    },
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child:
                          isWeekView
                              ? MoodWeekView(
                                key: const ValueKey('week_view'),
                                initialWeekStart: weekStart,
                                onWeekChanged: _onWeekChanged,
                                filter: _selectedFilter,
                              )
                              : MoodMonthView(
                                key: const ValueKey('month_view'),
                                month: selectedMonth,
                                year: selectedYear,
                                onMonthChanged: _onMonthChanged,
                                filter: _selectedFilter,
                              ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Count Card
                  TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0.0, end: 1.0),
                    duration: const Duration(milliseconds: 600),
                    curve: Curves.easeOut,
                    builder: (context, value, child) {
                      return Opacity(
                        opacity: value,
                        child: Transform.translate(
                          offset: Offset(0, 40 * (1 - value)),
                          child: child,
                        ),
                      );
                    },
                    child: MoodCountCard(
                      month: !isWeekView ? selectedMonth : null,
                      year: !isWeekView ? selectedYear : null,
                      weekStart: isWeekView ? weekStart : null,
                      weekEnd: isWeekView ? weekEnd : null,
                      filter: _selectedFilter,
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
