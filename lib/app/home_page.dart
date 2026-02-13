import 'package:flutter/material.dart';
import 'package:mood_map/core/constants/icons.dart';
import 'package:mood_map/core/widgets/bottom_navigation_bar.dart';
import 'package:mood_map/l10n/app_localizations.dart';
import '../features/mood/presentation/calendar/calendar_page.dart';
import '../features/mood/presentation/today/today_page.dart';
import '../features/mood_map/reflections/reflections_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [TodayPage(), CalendarPage(), ReflectionsPage()];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeIn,
        transitionBuilder: (child, animation) {
          return FadeTransition(opacity: animation, child: child);
        },
        child: KeyedSubtree(
          key: ValueKey<int>(_currentIndex),
          child: _pages[_currentIndex],
        ),
      ),
      extendBody: true, // Allows content to go behind the bottom nav bar
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(MoodIcons.smile, size: 33),
            label: AppLocalizations.of(context)!.tabToday,
          ),
          BottomNavigationBarItem(
            icon: Icon(MoodIcons.calendar, size: 33),
            label: AppLocalizations.of(context)!.tabCalendar,
          ),
          BottomNavigationBarItem(
            icon: Icon(MoodIcons.bulb, size: 33),
            label: AppLocalizations.of(context)!.tabReflections,
          ),
        ],
      ),
    );
  }
}
