import '../repositories/mood_repository.dart';

class DeleteMood {
  final MoodRepository repository;

  DeleteMood(this.repository);

  Future<void> call(DateTime date) async {
    return await repository.deleteMood(date);
  }
}
