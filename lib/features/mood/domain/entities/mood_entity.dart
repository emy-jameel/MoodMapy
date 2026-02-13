import 'package:equatable/equatable.dart';
import '../enums/mood_type.dart';

class MoodEntry extends Equatable {
  final DateTime date;
  final MoodType mood;
  final String? note;

  const MoodEntry({required this.date, required this.mood, this.note});

  @override
  List<Object?> get props => [date, mood, note];
}
