import 'package:hive/hive.dart';
import '../../domain/entities/mood_entity.dart';
import '../../domain/enums/mood_type.dart';

part 'mood_entry_model.g.dart';

@HiveType(typeId: 1)
class MoodEntryModel extends HiveObject {
  @HiveField(0)
  final DateTime date;

  @HiveField(1)
  final int moodIndex;

  @HiveField(2)
  final String? note;

  MoodEntryModel({required this.date, required this.moodIndex, this.note});

  factory MoodEntryModel.fromEntity(MoodEntry entity) {
    return MoodEntryModel(
      date: entity.date,
      moodIndex: entity.mood.index,
      note: entity.note,
    );
  }

  MoodEntry toEntity() {
    return MoodEntry(date: date, mood: MoodType.values[moodIndex], note: note);
  }
}
