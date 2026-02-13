import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../features/mood/data/datasources/mood_local_data_source.dart';
import '../../features/mood/data/models/mood_entry_model.dart';
import '../../features/mood/data/repositories/mood_repository_impl.dart';
import '../../features/mood/domain/repositories/mood_repository.dart';
import '../../features/mood/domain/usecases/add_mood.dart';
import '../../features/mood/domain/usecases/delete_mood.dart';
import '../../features/mood/domain/usecases/get_moods.dart';
import '../../features/mood/presentation/providers/mood_provider.dart';

final sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  // Features - Mood

  // Data sources
  sl.registerLazySingleton<MoodLocalDataSource>(
    () =>
        MoodLocalDataSourceImpl(moodBox: Hive.box<MoodEntryModel>('mood_box')),
  );

  // Repository
  sl.registerLazySingleton<MoodRepository>(
    () => MoodRepositoryImpl(localDataSource: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => AddMood(sl()));
  sl.registerLazySingleton(() => GetMoods(sl()));
  sl.registerLazySingleton(() => DeleteMood(sl()));

  // Providers
  sl.registerFactory(
    () => MoodProvider(
      addMoodUseCase: sl(),
      getMoodsUseCase: sl(),
      deleteMoodUseCase: sl(),
    ),
  );
}
