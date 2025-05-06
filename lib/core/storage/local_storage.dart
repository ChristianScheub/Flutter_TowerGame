import 'package:shared_preferences/shared_preferences.dart';

/// Provides local storage functionality for the game.
/// Handles saving and loading game data.
class LocalStorage {
  late SharedPreferences _prefs;
  
  /// Initializes the local storage.
  /// Must be called before using any other methods.
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }
  
  /// Saves an integer value with the given key.
  Future<bool> saveInt(String key, int value) async {
    return await _prefs.setInt(key, value);
  }
  
  /// Retrieves an integer value for the given key.
  /// Returns the defaultValue if the key doesn't exist.
  int getInt(String key, {int defaultValue = 0}) {
    return _prefs.getInt(key) ?? defaultValue;
  }
  
  /// Saves a string value with the given key.
  Future<bool> saveString(String key, String value) async {
    return await _prefs.setString(key, value);
  }
  
  /// Retrieves a string value for the given key.
  /// Returns the defaultValue if the key doesn't exist.
  String getString(String key, {String defaultValue = ''}) {
    return _prefs.getString(key) ?? defaultValue;
  }
  
  /// Saves a boolean value with the given key.
  Future<bool> saveBool(String key, bool value) async {
    return await _prefs.setBool(key, value);
  }
  
  /// Retrieves a boolean value for the given key.
  /// Returns the defaultValue if the key doesn't exist.
  bool getBool(String key, {bool defaultValue = false}) {
    return _prefs.getBool(key) ?? defaultValue;
  }
  
  /// Checks if the storage contains a value for the given key.
  bool containsKey(String key) {
    return _prefs.containsKey(key);
  }
  
  /// Removes the value associated with the given key.
  Future<bool> remove(String key) async {
    return await _prefs.remove(key);
  }
  
  /// Clears all data from the storage.
  Future<bool> clear() async {
    return await _prefs.clear();
  }
}