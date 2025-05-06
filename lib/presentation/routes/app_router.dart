import 'package:flutter/material.dart';
import 'package:tower_defense_game/presentation/pages/game_page.dart';
import 'package:tower_defense_game/presentation/pages/level_selection_page.dart';
import 'package:tower_defense_game/presentation/pages/start/main_menu_page.dart';
import 'package:tower_defense_game/presentation/pages/legal/settings_page.dart';
import 'package:tower_defense_game/presentation/pages/start/splash_page.dart';
import 'package:tower_defense_game/presentation/pages/legal/imprint_page.dart';
import 'package:tower_defense_game/presentation/pages/legal/privacy_policy_page.dart';

/// Manages application routing.
/// Defines all available routes and handles navigation.
class AppRouter {
  // Route names
  static const String splashRoute = '/';
  static const String menuRoute = '/menu';
  static const String levelSelectionRoute = '/levels';
  static const String gameRoute = '/game';
  static const String settingsRoute = '/settings';
  static const String imprintRoute = '/imprint';
  static const String privacyPolicyRoute = '/privacy';

  /// Route generator function.
  /// Creates the appropriate page based on route settings.
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashPage());
      case menuRoute:
        return MaterialPageRoute(builder: (_) => const MainMenuPage());
      case levelSelectionRoute:
        return MaterialPageRoute(builder: (_) => const LevelSelectionPage());
      case gameRoute:
        final args = settings.arguments as Map<String, dynamic>?;
        final levelId = args?['levelId'] as String? ?? '1';
        return MaterialPageRoute(
          builder: (_) => GamePage(levelId: levelId),
        );
      case settingsRoute:
        return MaterialPageRoute(builder: (_) => const SettingsPage());
      case imprintRoute:
        return MaterialPageRoute(builder: (_) => const ImprintPage());
      case privacyPolicyRoute:
        return MaterialPageRoute(builder: (_) => const PrivacyPolicyPage());
      default:
        return MaterialPageRoute(builder: (_) => const SplashPage());
    }
  }
}