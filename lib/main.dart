import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tower_defense_game/core/injection/injection.dart';
import 'package:tower_defense_game/presentation/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Force landscape orientation
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  
  // Initialize dependency injection
  await configureDependencies();
  
  // Run the app
  runApp(const TowerDefenseApp());
}