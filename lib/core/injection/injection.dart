import 'package:get_it/get_it.dart';
import 'package:tower_defense_game/core/storage/local_storage.dart';
import 'package:tower_defense_game/data/repositories/game_repository_impl.dart';
import 'package:tower_defense_game/data/repositories/level_repository_impl.dart';
import 'package:tower_defense_game/domain/repositories/game_repository.dart';
import 'package:tower_defense_game/domain/repositories/level_repository.dart';

final GetIt getIt = GetIt.instance;

/// Configures all dependencies for dependency injection.
/// Registers repositories, use cases, and services.
Future<void> configureDependencies() async {
  // Register storage
  final localStorage = LocalStorage();
  await localStorage.init();
  getIt.registerSingleton<LocalStorage>(localStorage);
  
  // Register repositories
  getIt.registerLazySingleton<GameRepository>(
    () => GameRepositoryImpl(localStorage: getIt()),
  );
  
  getIt.registerLazySingleton<LevelRepository>(
    () => LevelRepositoryImpl(),
  );
  
  // Add more dependencies as needed
}