import 'package:flutter/material.dart';

class EnemyConfig {
  final String id;
  final String name;
  final double baseHealth;
  final double baseSpeed;
  final int reward;
  final int damage;
  final Color color;
  final bool isFlying;
  final bool canHeal;
  final double healRadius;
  final double healAmount;

  const EnemyConfig({
    required this.id,
    required this.name,
    required this.baseHealth,
    required this.baseSpeed,
    required this.reward,
    required this.damage,
    required this.color,
    this.isFlying = false,
    this.canHeal = false,
    this.healRadius = 0,
    this.healAmount = 0,
  });
}

class EnemyConfigs {
  static const Map<String, EnemyConfig> enemies = {
    'basic': EnemyConfig(
      id: 'basic',
      name: 'Basic Enemy',
      baseHealth: 50,
      baseSpeed: 40,
      reward: 10,
      damage: 1,
      color: Colors.red,
    ),
    'scout': EnemyConfig(
      id: 'scout',
      name: 'Scout',
      baseHealth: 30,
      baseSpeed: 80,
      reward: 15,
      damage: 1,
      color: Colors.yellow,
    ),
    'tank': EnemyConfig(
      id: 'tank',
      name: 'Tank',
      baseHealth: 200,
      baseSpeed: 15,
      reward: 30,
      damage: 2,
      color: Colors.brown,
    ),
    'flyer': EnemyConfig(
      id: 'flyer',
      name: 'Flyer',
      baseHealth: 40,
      baseSpeed: 60,
      reward: 20,
      damage: 1,
      color: Colors.lightBlue,
      isFlying: true,
    ),
    'healer': EnemyConfig(
      id: 'healer',
      name: 'Healer',
      baseHealth: 50,
      baseSpeed: 25,
      reward: 25,
      damage: 1,
      color: Colors.green,
      canHeal: true,
      healRadius: 100,
      healAmount: 5,
    ),
    'boss': EnemyConfig(
      id: 'boss',
      name: 'Boss',
      baseHealth: 1000,
      baseSpeed: 20,
      reward: 100,
      damage: 5,
      color: Colors.purple,
    ),
  };
}