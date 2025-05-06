import 'package:flutter/material.dart';
import 'package:tower_defense_game/core/constants/app_theme.dart';
import 'package:tower_defense_game/presentation/routes/app_router.dart';
import '../l10n/gen_l10n/app_localizations.dart';

class TowerDefenseApp extends StatelessWidget {
  const TowerDefenseApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tower Defense Game',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRouter.onGenerateRoute,
      initialRoute: AppRouter.splashRoute,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      builder: (context, child) {
        // Add responsive layout wrapper
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: const TextScaler.linear(1.0),
          ),
          child: child!,
        );
      },
    );
  }
}
