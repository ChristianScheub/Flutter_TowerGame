import 'package:flutter/material.dart';

class TowerConfig {
  final String id;
  final String name;
  final String description;
  final int cost;
  final double baseDamage;
  final double baseRange;
  final double baseFireRate;
  final Color color;
  final TowerSpecialEffect? special;

  const TowerConfig({
    required this.id,
    required this.name,
    required this.description,
    required this.cost,
    required this.baseDamage,
    required this.baseRange,
    required this.baseFireRate,
    required this.color,
    this.special,
  });
}

class TowerSpecialEffect {
  final EffectType type;
  final double duration;
  final double? damagePerSecond;

  const TowerSpecialEffect({
    required this.type,
    required this.duration,
    this.damagePerSecond,
  });
}

enum EffectType {
  frost,
  poison,
}

class TowerConfigs {
  static const Map<String, TowerConfig> towers = {
    'basic': TowerConfig(
      id: 'basic',
      name: 'Basic Tower',
      description: 'Balanced tower with moderate damage and range',
      cost: 100,
      baseDamage: 10,
      baseRange: 150,
      baseFireRate: 1.0,
      color: Colors.blue,
      special: null,
    ),
    'cannon': TowerConfig(
      id: 'cannon',
      name: 'Cannon Tower',
      description: 'High damage but slow firing rate',
      cost: 150,
      baseDamage: 20,
      baseRange: 120,
      baseFireRate: 0.8,
      color: Colors.red,
      special: null,
    ),
    'sniper': TowerConfig(
      id: 'sniper',
      name: 'Sniper Tower',
      description: 'Very high damage and range but slow firing rate',
      cost: 200,
      baseDamage: 30,
      baseRange: 250,
      baseFireRate: 0.5,
      color: Colors.green,
      special: null,
    ),
    'frost': TowerConfig(
      id: 'frost',
      name: 'Frost Tower',
      description: 'Slows down enemies',
      cost: 175,
      baseDamage: 8,
      baseRange: 130,
      baseFireRate: 1.2,
      color: Colors.lightBlue,
      special: TowerSpecialEffect(
        type: EffectType.frost,
        duration: 3.0,
      ),
    ),
    'poison': TowerConfig(
      id: 'poison',
      name: 'Poison Tower',
      description: 'Deals damage over time',
      cost: 225,
      baseDamage: 5,
      baseRange: 140,
      baseFireRate: 1.0,
      color: Colors.purple,
      special: TowerSpecialEffect(
        type: EffectType.poison,
        duration: 3.0, 
        damagePerSecond: 20.0,
      ),
    ),
    'laser': TowerConfig(
      id: 'laser',
      name: 'Laser Tower',
      description: 'Continuous beam damage',
      cost: 300,
      baseDamage: 25,
      baseRange: 180,
      baseFireRate: 2.0,
      color: Colors.amber,
      special: null,
    ),
    'tesla': TowerConfig(
      id: 'tesla',
      name: 'Tesla Tower',
      description: 'Chain lightning damage',
      cost: 350,
      baseDamage: 40,
      baseRange: 100,
      baseFireRate: 1.5,
      color: Colors.cyan,
      special: null,
    ),
    'missile': TowerConfig(
      id: 'missile',
      name: 'Missile Tower',
      description: 'Area damage',
      cost: 400,
      baseDamage: 50,
      baseRange: 200,
      baseFireRate: 0.7,
      color: Colors.deepOrange,
      special: null,
    ),
    'magic': TowerConfig(
      id: 'magic',
      name: 'Magic Tower',
      description: 'Piercing damage',
      cost: 450,
      baseDamage: 35,
      baseRange: 160,
      baseFireRate: 1.3,
      color: Colors.indigo,
      special: null,
    ),
    'ultimate': TowerConfig(
      id: 'ultimate',
      name: 'Ultimate Tower',
      description: 'Extremely powerful but expensive',
      cost: 500,
      baseDamage: 60,
      baseRange: 220,
      baseFireRate: 1.0,
      color: Colors.pink,
      special: null,
    ),
  };
}