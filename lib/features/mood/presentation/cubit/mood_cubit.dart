import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collection/collection.dart';
import '../../domain/entities/mood_entity.dart';
import '../../domain/enums/mood_type.dart';
import '../../domain/usecases/add_mood.dart';
import '../../domain/usecases/get_moods.dart';
import '../../domain/usecases/delete_mood.dart';
import '../../../../core/constants/colors.dart';
import 'mood_state.dart';

class MoodCubit extends Cubit<MoodState> {
  final AddMood addMoodUseCase;
  final GetMoods getMoodsUseCase;
  final DeleteMood deleteMoodUseCase;

  MoodCubit({
    required this.addMoodUseCase,
    required this.getMoodsUseCase,
    required this.deleteMoodUseCase,
  }) : super(const MoodState()) {
    loadMoods();
  }

  Future<void> loadMoods() async {
    emit(state.copyWith(status: MoodStatus.loading));
    try {
      final entries = await getMoodsUseCase();
      emit(state.copyWith(status: MoodStatus.success, entries: entries));
    } catch (e) {
      emit(
        state.copyWith(status: MoodStatus.error, errorMessage: e.toString()),
      );
    }
  }

  void setMood(MoodType mood) {
    emit(state.copyWith(selectedMood: mood));
  }

  Future<MoodSaveResult> saveMood(String note) async {
    if (state.selectedMood == null) return MoodSaveResult.noMood;
    if (note.trim().isEmpty) return MoodSaveResult.emptyNote;

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    try {
      final moodEntry = MoodEntry(
        mood: state.selectedMood!,
        note: note.trim(),
        date: today,
      );
      await addMoodUseCase(moodEntry);

      // Reset selection after save
      emit(state.copyWith(selectedMood: null));
      await loadMoods();
      return MoodSaveResult.success;
    } catch (e) {
      return MoodSaveResult.error;
    }
  }

  Future<void> addMood(MoodEntry entry) async {
    try {
      await addMoodUseCase(entry);
      await loadMoods();
    } catch (e) {
      emit(
        state.copyWith(status: MoodStatus.error, errorMessage: e.toString()),
      );
    }
  }

  Future<void> deleteMood(DateTime date) async {
    final dateOnly = DateTime(date.year, date.month, date.day);
    try {
      await deleteMoodUseCase(dateOnly);
      await loadMoods();
    } catch (e) {
      emit(
        state.copyWith(status: MoodStatus.error, errorMessage: e.toString()),
      );
    }
  }

  // Utils (ported from Provider)
  MoodType? getMoodTypeForDay(int day, int month, int year) {
    final entry = state.entries.firstWhereOrNull(
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
    return state.entries.firstWhereOrNull(
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
    for (final entry in state.entries) {
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
    for (final entry in state.entries) {
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
}
