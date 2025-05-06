# Core Constants

This directory contains constants used throughout the application.

## Files

- `app_theme.dart`: Defines the application theme including colors, text styles, and visual elements.
- `asset_paths.dart`: Contains paths to assets like images, sounds, and maps.
- `game_constants.dart`: Defines game-specific constants like tower costs, enemy stats, etc.

## Usage

Constants should be organized by category and accessed directly from their respective files. This ensures consistency throughout the application and makes it easier to update values in a single location.

Example:
```dart
import 'package:tower_defense_game/core/constants/app_theme.dart';

// Using a color constant
Container(
  color: AppTheme.primaryColor,
  child: Text('Hello'),
);
```