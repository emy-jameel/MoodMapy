import '../../domain/entities/mood_entity.dart';
import '../../domain/repositories/mood_repository.dart';
import '../datasources/mood_local_data_source.dart';
import '../models/mood_entry_model.dart';

class MoodRepositoryImpl implements MoodRepository {
  final MoodLocalDataSource localDataSource;

  MoodRepositoryImpl({required this.localDataSource});

  @override
  Future<void> addMood(MoodEntry entry) async {
    final model = MoodEntryModel.fromEntity(entry);
    return await localDataSource.cacheMood(model);
  }

  @override
  Future<List<MoodEntry>> getMoods() async {
    final models = await localDataSource.getCachedMoods();
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<MoodEntry?> getMoodByDate(DateTime date) async {
    final model = await localDataSource.getMoodByDate(date);
    return model?.toEntity();
  }

  @override
  Future<void> deleteMood(DateTime date) async {
    return await localDataSource.deleteMood(date);
  }

  @override
  Future<void> updateMood(MoodEntry entry) async {
    final model = MoodEntryModel.fromEntity(entry);
    return await localDataSource.cacheMood(model);
  }
}
