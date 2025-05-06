import 'package:tower_defense_game/domain/entities/level.dart';

/// Repository interface for level-related operations.
/// Defines methods for retrieving level data.
abstract class LevelRepository {
  /// Retrieves all levels available in the game.
  /// Returns a list of Level entities.
  Future<List<Level>> getAllLevels();
  
  /// Gets a specific level by its ID.
  /// Returns the Level entity if found, null otherwise.
  Future<Level?> getLevelById(String levelId);
  
  /// Checks if a level is an endless mode level.
  /// Returns true for endless mode, false for normal levels.
  bool isEndlessMode(String levelId);
  
  /// Gets the difficulty multiplier for a specific level.
  /// Higher levels have higher difficulty multipliers.
  double getLevelDifficultyMultiplier(String levelId);
  
  /// Gets the wave configuration for a specific level.
  /// Returns the number and types of enemies for each wave.
  Future<List<Map<String, dynamic>>> getLevelWaves(String levelId);
  
  /// Gets the map data for a specific level.
  /// Returns the map configuration including paths and tower locations.
  Future<Map<String, dynamic>> getLevelMap(String levelId);
}