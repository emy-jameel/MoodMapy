import 'package:equatable/equatable.dart';
import '../../domain/entities/mood_entity.dart';
import '../../domain/enums/mood_type.dart';

enum MoodStatus { initial, loading, success, error }

class MoodState extends Equatable {
  final List<MoodEntry> entries;
  final MoodType? selectedMood;
  final MoodStatus status;
  final String? errorMessage;

  const MoodState({
    this.entries = const [],
    this.selectedMood,
    this.status = MoodStatus.initial,
    this.errorMessage,
  });

  MoodState copyWith({
    List<MoodEntry>? entries,
    MoodType? selectedMood,
    MoodStatus? status,
    String? errorMessage,
  }) {
    return MoodState(
      entries: entries ?? this.entries,
      selectedMood: selectedMood ?? this.selectedMood,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [entries, selectedMood, status, errorMessage];
}
