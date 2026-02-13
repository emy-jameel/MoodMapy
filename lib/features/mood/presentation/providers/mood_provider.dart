import 'dart:math';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import '../../domain/entities/mood_entity.dart';
import 'package:mood_map/features/mood/domain/enums/mood_type.dart';
import '../../domain/usecases/add_mood.dart';
import '../../domain/usecases/get_moods.dart';
import '../../domain/usecases/delete_mood.dart';
import '../../../../core/constants/colors.dart';

class MoodProvider extends ChangeNotifier {
  final AddMood addMoodUseCase;
  final GetMoods getMoodsUseCase;
  final DeleteMood deleteMoodUseCase;

  MoodProvider({
    required this.addMoodUseCase,
    required this.getMoodsUseCase,
    required this.deleteMoodUseCase,
  }) {
    _loadMoods();
  }

  MoodType? selectedMood;
  final TextEditingController noteController = TextEditingController();

  List<MoodEntry> _entries = [];
  List<MoodEntry> get entries => List.unmodifiable(_entries);

  Future<void> _loadMoods() async {
    _entries = await getMoodsUseCase();
    notifyListeners();
  }

  Future<void> addMood(MoodEntry entry) async {
    final dateOnly = DateTime(
      entry.date.year,
      entry.date.month,
      entry.date.day,
    );
    final entryWithDateOnly = MoodEntry(
      date: dateOnly,
      mood: entry.mood,
      note: entry.note,
    );
    await addMoodUseCase(entryWithDateOnly);
    await _loadMoods();
  }

  Future<void> deleteMood(DateTime date) async {
    final dateOnly = DateTime(date.year, date.month, date.day);
    await deleteMoodUseCase(dateOnly);
    await _loadMoods();
  }

  void setMood(MoodType mood) {
    selectedMood = mood;
    notifyListeners();
  }

  Future<MoodSaveResult> saveMood() async {
    if (selectedMood == null) return MoodSaveResult.noMood;
    if (noteController.text.trim().isEmpty) return MoodSaveResult.emptyNote;

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    try {
      final moodEntry = MoodEntry(
        mood: selectedMood!,
        note: noteController.text.trim(),
        date: today,
      );
      await addMoodUseCase(moodEntry);
      selectedMood = null;
      noteController.clear();
      await _loadMoods();
      return MoodSaveResult.success;
    } catch (e) {
      return MoodSaveResult.error;
    }
  }

  MoodType? getMoodTypeForDay(int day, int month, int year) {
    final entry = _entries.firstWhereOrNull(
      (e) => e.date.year == year && e.date.month == month && e.date.day == day,
    );
    return entry?.mood;
  }

  Color getMoodColorForDay(bool isDark, int day, int month, int year) {
    final mood = getMoodTypeForDay(day, month, year);

    switch (mood) {
      case MoodType.happy:
        return isDark ? MoodColors.happyDark : MoodColors.happyNormal;
      case MoodType.good:
        return isDark ? MoodColors.goodDark : MoodColors.goodNormal;
      case MoodType.okay:
        return isDark ? MoodColors.okDark : MoodColors.okNormal;
      case MoodType.bad:
        return isDark ? MoodColors.badDark : MoodColors.badNormal;
      case MoodType.awfull:
        return isDark ? MoodColors.awfulDark : MoodColors.awfulNormal;
      default:
        return Colors.transparent;
    }
  }

  MoodEntry? getMoodByDate(DateTime date) {
    return _entries.firstWhereOrNull(
      (e) =>
          e.date.year == date.year &&
          e.date.month == date.month &&
          e.date.day == date.day,
    );
  }

  Map<MoodType, int> getMoodCountForMonth(
    int month,
    int year, {
    MoodType? filter,
  }) {
    final counts = <MoodType, int>{};
    for (final entry in _entries) {
      if (entry.date.month == month && entry.date.year == year) {
        if (filter == null || entry.mood == filter) {
          counts.update(entry.mood, (v) => v + 1, ifAbsent: () => 1);
        }
      }
    }
    return counts;
  }

  Map<MoodType, int> getMoodCountForWeek(
    DateTime start,
    DateTime end, {
    MoodType? filter,
  }) {
    final DateTime startDay = DateTime(start.year, start.month, start.day);
    final DateTime endDay = DateTime(end.year, end.month, end.day);

    final counts = <MoodType, int>{};
    for (final entry in _entries) {
      final entryDay = DateTime(
        entry.date.year,
        entry.date.month,
        entry.date.day,
      );
      if (!entryDay.isBefore(startDay) && !entryDay.isAfter(endDay)) {
        if (filter == null || entry.mood == filter) {
          counts.update(entry.mood, (v) => v + 1, ifAbsent: () => 1);
        }
      }
    }
    return counts;
  }

  Future<void> seedMoodEntriesForCurrentMonth() async {
    final now = DateTime.now();
    final int month = now.month;
    final int year = now.year;

    final List<int> days = [10, 15, 22, 5, 17, 27];
    final moods = MoodType.values;
    final random = Random();

    for (final day in days) {
      final mood = moods[random.nextInt(moods.length)];
      final entry = MoodEntry(
        date: DateTime(year, month, day),
        mood: mood,
        note: "Test mood for $day",
      );
      await addMoodUseCase(entry);
    }
    await _loadMoods();
  }
}
