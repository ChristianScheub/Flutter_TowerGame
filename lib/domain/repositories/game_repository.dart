/// Repository interface for game-related operations.
/// Defines methods for saving and retrieving game state.
abstract class GameRepository {
  /// Saves the current game progress.
  /// Returns true if successful, false otherwise.
  Future<bool> saveGameProgress(int levelId, int score, int stars);

  /// Retrieves the highest score achieved for a specific level.
  /// Returns 0 if no score is found.
  Future<int> getHighScore(int levelId);


  /// Gets the total number of stars collected across all levels.
  Future<int> getTotalStars();

  /// Checks if a level has been completed.
  /// Returns true if the level is completed, false otherwise.
  Future<bool> isLevelCompleted(int levelId);

  /// Gets the highest level that has been unlocked.
  /// Returns 1 if no levels have been unlocked yet.
  Future<int> getHighestUnlockedLevel();

  /// Updates settings such as sound and music preferences.
  /// Returns true if successful, false otherwise.
  Future<bool> updateSettings(bool soundEnabled, bool musicEnabled);

  /// Retrieves the current game settings.
  /// Returns a map with settings values.
  Future<Map<String, dynamic>> getSettings();
}
