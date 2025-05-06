import 'package:flame/components.dart';
import 'package:flame/particles.dart';
import 'package:flutter/material.dart';
import 'package:tower_defense_game/data/config/tower.config.dart';
import 'package:tower_defense_game/presentation/game/components/enemy.dart';
import 'package:tower_defense_game/presentation/game/tower_defense_game.dart';

class Projectile extends PositionComponent with HasGameRef<TowerDefenseGame> {
  final TowerConfig config;
  final double damage;
  final Enemy target;
  final double speed = 300;
  final double maxLifetime = 3.0;
  double lifetime = 0.0;

  Projectile({
    required this.config,
    required Vector2 position,
    required this.target,
    required this.damage,
    Vector2? size,
  }) : super(
    position: position,
    size: size ?? Vector2(8, 8),
    anchor: Anchor.center,
  );

  @override
  Future<void> onLoad() async {
    final sprite = CircleComponent(
      radius: size.x / 2,
      paint: Paint()..color = config.color,
    );
    add(sprite);
    
    if (config.special != null) {
      final trail = ParticleSystemComponent(
        particle: _createTrailParticle(),
      );
      add(trail);
    }
  }

  Particle _createTrailParticle() {
    return Particle.generate(
      count: 10,
      lifespan: 0.5,
      generator: (i) => AcceleratedParticle(
        speed: Vector2(0, 0),
        acceleration: Vector2(0, 0),
        child: CircleParticle(
          radius: 2,
          paint: Paint()..color = config.color.withOpacity(0.5),
        ),
      ),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    
    lifetime += dt;
    
    if (lifetime >= maxLifetime) {
      removeFromParent();
      return;
    }
    
    if (!target.isMounted) {
      removeFromParent();
      return;
    }
    
    final direction = target.position - position;
    final distance = direction.length;
    
    if (distance < target.size.x / 2 + size.x / 2) {
      target.takeDamage(damage);
      
      if (config.special?.type == EffectType.frost) {
        target.applyFrostEffect(config.special!.duration);
      }
      
      if (config.special?.type == EffectType.poison) {
        target.applyPoisonEffect(
          config.special!.damagePerSecond!,
          config.special!.duration,
        );
      }
      
      removeFromParent();
      return;
    }
    
    final normalizedDirection = direction.normalized();
    final movement = normalizedDirection * speed * dt;
    position.add(movement);
    
    angle = normalizedDirection.angleTo(Vector2(1, 0));
  }

  Enemy? checkHit(List<Enemy> enemies) {
    for (final enemy in enemies) {
      final distance = position.distanceTo(enemy.position);
      if (distance < enemy.size.x / 2 + size.x / 2) {
        return enemy;
      }
    }
    return null;
  }
}