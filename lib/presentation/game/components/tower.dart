import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:tower_defense_game/data/config/tower.config.dart';
import 'package:tower_defense_game/presentation/game/components/enemy.dart';
import 'package:tower_defense_game/presentation/game/components/projectile.dart';
import 'package:tower_defense_game/presentation/game/tower_defense_game.dart';
import 'dart:math';

class Tower extends PositionComponent with HasGameRef<TowerDefenseGame> {
  final TowerConfig config;
  int level = 1;
  double damage;
  double range;
  double fireRate;
  double timeSinceLastShot = 0;
  Enemy? target;
  late TextComponent levelIndicator;

  Tower({
    required this.config,
    required Vector2 position,
    Vector2? size,
  }) : damage = config.baseDamage,
       range = config.baseRange,
       fireRate = config.baseFireRate,
       super(
         position: position,
         size: size ?? Vector2(32, 32),
         anchor: Anchor.center,
       );

  static Tower create({
    required String type,
    required Vector2 position,
  }) {
    final config = TowerConfigs.towers[type]!;
    return Tower(
      config: config,
      position: position,
    );
  }

  @override
  Future<void> onLoad() async {
    final sprite = RectangleComponent(
      size: size,
      paint: Paint()..color = _getTowerColor(),
    );
    add(sprite);

    levelIndicator = TextComponent(
      text: level.toString(),
      textRenderer: TextPaint(
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
      position: Vector2(size.x - 8, 0),
      anchor: Anchor.center,
    );
    add(levelIndicator);
  }

  Color _getTowerColor() {
    double luminance = 0.1 * level;
    return HSLColor.fromColor(config.color)
        .withLightness((HSLColor.fromColor(config.color).lightness + luminance).clamp(0.0, 1.0))
        .toColor();
  }

  @override
  void update(double dt) {
    super.update(dt);
    
    timeSinceLastShot += dt;
    
    if (target != null && (target!.health <= 0 || !_isInRange(target!))) {
        target = null;
    }
    
    if (Random().nextDouble() < 0.35) {
        target = null;
    }
    
    // Schießen wenn bereit
    if (target != null && timeSinceLastShot >= 1 / fireRate) {
        _fireAt(target!);
        timeSinceLastShot = 0;
    }
  }

  void findTarget(List<Enemy> enemies) {
    if (target != null) return;
    
    // Liste aller erreichbaren Gegner erstellen
    final reachableEnemies = enemies.where((enemy) => _isInRange(enemy)).toList();
    
    // Wenn keine Gegner in Reichweite sind, return
    if (reachableEnemies.isEmpty) return;
    
    // Zufälligen Gegner aus der Liste auswählen
    final random = Random();
    final randomIndex = random.nextInt(reachableEnemies.length);
    target = reachableEnemies[randomIndex];
  }

  bool _isInRange(Enemy enemy) {
    return position.distanceTo(enemy.position) <= range;
  }

  void _fireAt(Enemy target) {
    final projectile = Projectile(
      config: TowerConfigs.towers[config.id]!,  // Hier war der Fehler - wir müssen die Original-Config verwenden
      position: position.clone(),
      target: target,
      damage: damage,
    );
    
    gameRef.projectiles.add(projectile);
    gameRef.add(projectile);
  }

  int upgrade() {
    if (level >= 7) return -1; 
    
    level++;
    damage *= 1.2;  // 20% damage increase
    range *= 1.1;   // 10% range increase
    fireRate *= 1.1; // 10% fire rate increase
    
    children.whereType<RectangleComponent>().first.paint.color = _getTowerColor();
    levelIndicator.text = level.toString();
    
    return (config.cost * 0.5).round();
  }
}