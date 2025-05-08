import 'package:flutter/material.dart';
import '../../../l10n/gen_l10n/app_localizations.dart';
import 'package:tower_defense_game/core/constants/app_theme.dart';
import 'package:tower_defense_game/presentation/routes/app_router.dart';
import 'package:tower_defense_game/presentation/widgets/menu_button.dart';

/// Main menu page displayed after the splash screen.
/// Provides navigation to game modes, settings, and legal information.
class MainMenuPage extends StatelessWidget {
  const MainMenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppTheme.primaryColor,
              AppTheme.darkColor,
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                const Icon(
                  Icons.shield,
                  size: 100,
                  color: Colors.white,
                ),
                const SizedBox(height: 16),
                Text(
                  'Tactical Blocks',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const Spacer(),
                MenuButton(
                  text: local.playGame,
                  onPressed: () => Navigator.of(context).pushNamed(
                    AppRouter.levelSelectionRoute,
                  ),
                ),
                const SizedBox(height: 16),
                MenuButton(
                  text: local.settingsTitle,
                  onPressed: () => Navigator.of(context).pushNamed(
                    AppRouter.settingsRoute,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pushNamed(
                        AppRouter.imprintRoute,
                      ),
                      child: Text(
                        local.imprint,
                        style: const TextStyle(color: Colors.white70),
                      ),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pushNamed(
                        AppRouter.privacyPolicyRoute,
                      ),
                      child: Text(
                        local.privacyPolicy,
                        style: const TextStyle(color: Colors.white70),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
