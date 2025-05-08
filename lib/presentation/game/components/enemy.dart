import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:tower_defense_game/data/config/enemy_config.dart';
import 'package:tower_defense_game/presentation/game/tower_defense_game.dart';

class Enemy extends PositionComponent with HasGameRef<TowerDefenseGame> {
  final EnemyConfig config;
  double health;
  final double maxHealth;
  double speed;
  final double baseSpeed;
  final int reward;
  final int damage;
  final List<Vector2> path;
  int currentPathIndex = 0;
  bool reachedEnd = false;

  bool isFrozen = false;
  bool isPoisoned = false;
  double poisonDamagePerSecond = 0;
  double frostDuration = 0;
  double poisonDuration = 0;
  double healCooldown = 0;

  late RectangleComponent healthBar;
  late RectangleComponent healthBarBackground;

  Enemy({
    required this.config,
    required Vector2 position,
    required this.path,
    required double health,
    required double speed,
    Vector2? size,
  })  : health = health,
        maxHealth = health,
        baseSpeed = speed,
        speed = speed,
        reward = config.reward,
        damage = config.damage,
        super(
          position: position,
          size: size ?? Vector2(24, 24),
          anchor: Anchor.center,
        );

  static Enemy create({
    required String type,
    required Vector2 position,
    required List<Vector2> path,
    double? difficultyMultiplier = 1.0,
  }) {
    final config = EnemyConfigs.enemies[type]!;
    final health = config.baseHealth * (difficultyMultiplier ?? 1.0);
    final speed = config.baseSpeed;
    final size = type == 'boss' ? Vector2(48, 48) : Vector2(24, 24);

    return Enemy(
      config: config,
      position: position,
      path: path,
      health: health,
      speed: speed,
      size: size,
    );
  }

  @override
  Future<void> onLoad() async {
    final sprite = RectangleComponent(
      size: size,
      paint: Paint()..color = _getEnemyColor(),
    );
    add(sprite);

    final healthBarWidth = size.x * 1.2;
    const healthBarHeight = 4.0;
    final healthBarOffset = Vector2(0, -size.y / 2 - 8);

    healthBarBackground = RectangleComponent(
      position: healthBarOffset,
      size: Vector2(healthBarWidth, healthBarHeight),
      paint: Paint()..color = Colors.grey.shade800,
      anchor: Anchor.topCenter,
    );

    healthBar = RectangleComponent(
      position: healthBarOffset,
      size: Vector2(healthBarWidth, healthBarHeight),
      paint: Paint()..color = Colors.green,
      anchor: Anchor.topCenter,
    );

    add(healthBarBackground);
    add(healthBar);
  }

  Color _getEnemyColor() {
    Color baseColor = config.color;

    if (isFrozen) {
      return Color.alphaBlend(Colors.blue.withOpacity(0.8), baseColor);
    }
    if (isPoisoned) {
      return Color.alphaBlend(Colors.green.withOpacity(0.8), baseColor);
    }
    return baseColor;
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Aktive Effekte verarbeiten
    _updateEffects(dt);

    // Bewegungslogik
    if (!reachedEnd && currentPathIndex < path.length) {
      _updateMovement(dt);
    }

    // Kampflogik
    _updateCombat(dt);
  }

  void _updateEffects(double dt) {
    // Frost-Effekt
    if (frostDuration > 0) {
      frostDuration -= dt;
      
      // Garantiere, dass die Verlangsamung aktiv ist
      if (isFrozen) {
        speed = baseSpeed * 0.2;
      }
      
      // Effekt beenden wenn die Zeit abgelaufen ist
      if (frostDuration <= 0) {
        isFrozen = false;
        speed = baseSpeed;
      }
    }

    // Gift-Effekt
    if (isPoisoned && poisonDuration > 0) {
      // Gift-Schaden anwenden
      health -= poisonDamagePerSecond * dt;
      
      // Timer reduzieren
      poisonDuration -= dt;
      
      // Effekt nur beenden wenn die Zeit wirklich abgelaufen ist
      if (poisonDuration <= 0) {
        isPoisoned = false;
        poisonDamagePerSecond = 0;
      }
    }

    // Heiler-Logik bleibt unverändert
    if (config.canHeal && healCooldown <= 0) {
      _healNearbyEnemies();
      healCooldown = 2.0;
    } else if (healCooldown > 0) {
      healCooldown -= dt;
    }
  }

  void _updateMovement(double dt) {
    final targetPoint = path[currentPathIndex];
    final direction = targetPoint - position;
    final distance = direction.length;

    if (distance < 5) {
      currentPathIndex++;
      if (currentPathIndex >= path.length) {
        reachedEnd = true;
        return;
      }
    } else {
      final normalizedDirection = direction.normalized();
      final movement = normalizedDirection * speed * dt;
      position.add(movement);
    }
  }

  void _updateCombat(double dt) {
    // Gesundheitsbalken aktualisieren
    final healthPercent = (health / maxHealth).clamp(0.0, 1.0);
    healthBar.size.x = healthBarBackground.size.x * healthPercent;
    
    healthBar.paint.color = switch (healthPercent) {
      < 0.3 => Colors.red,
      < 0.6 => Colors.orange,
      _ => Colors.green,
    };
    
    // Visuelles Update der Gegnerfarbe basierend auf aktiven Effekten
    final sprite = children.firstWhere((child) => child is RectangleComponent) as RectangleComponent;
    sprite.paint.color = _getEnemyColor();
  }

  void _healNearbyEnemies() {
    if (!config.canHeal) return;

    for (final enemy in gameRef.enemies) {
      if (enemy != this &&
          (enemy.position - position).length <= config.healRadius) {
        enemy.health =
            (enemy.health + config.healAmount).clamp(0, enemy.maxHealth);
      }
    }
  }

  bool takeDamage(double amount) {
    health -= amount;
    return health <= 0;
  }

  void applyFrostEffect(double duration) {
    if (!isFrozen) {
      speed = baseSpeed * 0.2;
    }
    isFrozen = true;
    frostDuration = duration;
  }

  void applyPoisonEffect(double damage, double duration) {
    isPoisoned = true;
    poisonDamagePerSecond = isPoisoned ? 
        max(poisonDamagePerSecond, damage) : 
        damage;
    poisonDuration = duration;
  }
}
