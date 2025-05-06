import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/particles.dart';
import 'package:flutter/material.dart';
import 'package:tower_defense_game/presentation/game/tower_defense_game.dart';

class GameOverEffect extends Component with HasGameRef<TowerDefenseGame> {
  @override
  Future<void> onLoad() async {
    final screenSize = gameRef.size;
    final center = screenSize / 2;
    
    // Add "Game Over" text with dramatic effect
    final gameOverText = TextComponent(
      text: 'GAME OVER',
      textRenderer: TextPaint(
        style: const TextStyle(
          color: Colors.red,
          fontSize: 64,
          fontWeight: FontWeight.bold,
          shadows: [
            Shadow(
              color: Colors.black,
              offset: Offset(2, 2),
              blurRadius: 4,
            ),
          ],
        ),
      ),
      position: Vector2(center.x, center.y - 50),
      anchor: Anchor.center,
    );
    
    add(gameOverText);
    
    // Add particle effects
    final particles = ParticleSystemComponent(
      particle: Particle.generate(
        count: 100,
        lifespan: 2,
        generator: (i) {
          final angle = i * (2 * 3.14159 / 100);
          const speed = 50.0;
          final velocity = Vector2(
            speed * cos(angle),
            speed * sin(angle),
          );
          
          return AcceleratedParticle(
            acceleration: Vector2(0, 50),
            speed: velocity,
            child: CircleParticle(
              radius: 2,
              paint: Paint()..color = Colors.red.withOpacity(0.5),
            ),
          );
        },
      ),
      position: center,
    );
    
    add(particles);
  }
}