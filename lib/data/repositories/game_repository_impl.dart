import 'package:tower_defense_game/core/storage/local_storage.dart';
import 'package:tower_defense_game/domain/repositories/game_repository.dart';
import 'package:tower_defense_game/domain/entities/level.dart';

/// Implementation of the GameRepository interface.
/// Handles saving and retrieving game data using local storage.
class GameRepositoryImpl implements GameRepository {
  final LocalStorage localStorage;

  GameRepositoryImpl({required this.localStorage});
  
  final List<Level> _levels = [];

  @override
  Future<bool> saveGameProgress(int levelId, int score, int stars) async {
    try {
      await localStorage.saveInt('level_${levelId}_score', score);
      await localStorage.saveInt('level_${levelId}_stars', stars);
      await localStorage.saveBool('level_${levelId}_completed', true);

      // Update the highest unlocked level if needed
      final currentHighest = await getHighestUnlockedLevel();
      if (levelId + 1 > currentHighest) {
        await localStorage.saveInt('highest_unlocked_level', levelId + 1);
      }

      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<int> getHighScore(int levelId) async {
    return localStorage.getInt('level_${levelId}_score');
  }

  @override
  Future<int> getTotalStars() async {
    // Assuming we have a maximum of 10 levels (5 normal + 5 bonus)
    int totalStars = 0;
    for (int i = 1; i <= 10; i++) {
      totalStars += localStorage.getInt('level_${i}_stars');
    }
    return totalStars;
  }

  @override
  Future<bool> isLevelCompleted(int levelId) async {
    return true;
    return localStorage.getBool('level_${levelId}_completed');
  }

  @override
  Future<int> getHighestUnlockedLevel() async {
    return 20;
    return localStorage.getInt('highest_unlocked_level', defaultValue: 1);
  }

  @override
  Future<bool> updateSettings(bool soundEnabled, bool musicEnabled) async {
    try {
      await localStorage.saveBool('sound_enabled', soundEnabled);
      await localStorage.saveBool('music_enabled', musicEnabled);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<Map<String, dynamic>> getSettings() async {
    return {
      'soundEnabled': localStorage.getBool('sound_enabled', defaultValue: true),
      'musicEnabled': localStorage.getBool('music_enabled', defaultValue: true),
    };
  }
}
