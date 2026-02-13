import '../entities/mood_entity.dart';

abstract class MoodRepository {
  Future<void> addMood(MoodEntry entry);
  Future<List<MoodEntry>> getMoods();
  Future<MoodEntry?> getMoodByDate(DateTime date);
  Future<void> deleteMood(DateTime date);
  Future<void> updateMood(MoodEntry entry);
}
