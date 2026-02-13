import 'package:hive/hive.dart';
import '../models/mood_entry_model.dart';

abstract class MoodLocalDataSource {
  Future<void> cacheMood(MoodEntryModel entry);
  Future<List<MoodEntryModel>> getCachedMoods();
  Future<MoodEntryModel?> getMoodByDate(DateTime date);
  Future<void> deleteMood(DateTime date);
}

class MoodLocalDataSourceImpl implements MoodLocalDataSource {
  final Box<MoodEntryModel> moodBox;

  MoodLocalDataSourceImpl({required this.moodBox});

  @override
  Future<void> cacheMood(MoodEntryModel entry) async {
    final key =
        DateTime(
          entry.date.year,
          entry.date.month,
          entry.date.day,
        ).toIso8601String();
    await moodBox.put(key, entry);
  }

  @override
  Future<List<MoodEntryModel>> getCachedMoods() async {
    return moodBox.values.toList();
  }

  @override
  Future<MoodEntryModel?> getMoodByDate(DateTime date) async {
    final key = DateTime(date.year, date.month, date.day).toIso8601String();
    return moodBox.get(key);
  }

  @override
  Future<void> deleteMood(DateTime date) async {
    final key = DateTime(date.year, date.month, date.day).toIso8601String();
    await moodBox.delete(key);
  }
}
