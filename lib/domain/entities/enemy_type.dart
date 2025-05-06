import 'package:equatable/equatable.dart';

class EnemyType extends Equatable {
  final String id;
  final String name;
  final double baseHealth;
  final double baseSpeed;
  final int reward;
  final int damage;
  final bool isFlying;
  final bool canHeal;
  final double healRadius;
  final double healAmount;
  
  const EnemyType({
    required this.id,
    required this.name,
    required this.baseHealth,
    required this.baseSpeed,
    required this.reward,
    required this.damage,
    this.isFlying = false,
    this.canHeal = false,
    this.healRadius = 0,
    this.healAmount = 0,
  });

  static const basic = EnemyType(
    id: 'basic',
    name: 'Basic',
    baseHealth: 50,
    baseSpeed: 40,
    reward: 10,
    damage: 1,
  );
  
  static const scout = EnemyType(
    id: 'scout',
    name: 'Scout',
    baseHealth: 30,
    baseSpeed: 80,
    reward: 15,
    damage: 1,
  );
  
  static const tank = EnemyType(
    id: 'tank',
    name: 'Tank',
    baseHealth: 200,
    baseSpeed: 15,
    reward: 30,
    damage: 2,
  );
  
  static const flyer = EnemyType(
    id: 'flyer',
    name: 'Flyer',
    baseHealth: 40,
    baseSpeed: 60,
    reward: 20,
    damage: 1,
    isFlying: true,
  );
  
  static const healer = EnemyType(
    id: 'healer',
    name: 'Healer',
    baseHealth: 50,
    baseSpeed: 25,
    reward: 25,
    damage: 1,
    canHeal: true,
    healRadius: 100,
    healAmount: 5,
  );
  
  static const boss = EnemyType(
    id: 'boss',
    name: 'Boss',
    baseHealth: 1000,
    baseSpeed: 20,
    reward: 100,
    damage: 5,
  );
  
  @override
  List<Object?> get props => [
    id,
    name,
    baseHealth,
    baseSpeed,
    reward,
    damage,
    isFlying,
    canHeal,
    healRadius,
    healAmount,
  ];
}