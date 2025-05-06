import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/particles.dart';
import 'package:flutter/material.dart';
import 'package:tower_defense_game/presentation/game/tower_defense_game.dart';

class VictoryEffect extends Component with HasGameRef<TowerDefenseGame> {
  @override
  Future<void> onLoad() async {
    final screenSize = gameRef.size;
    final center = screenSize / 2;
    
    // Create firework particles
    for (int i = 0; i < 5; i++) {
      final position = Vector2(
        center.x + (i - 2) * 50,
        center.y,
      );
      
      final colors = [
        Colors.red,
        Colors.blue,
        Colors.green,
        Colors.yellow,
        Colors.purple,
      ];
      
      final firework = ParticleSystemComponent(
        position: position,
        particle: Particle.generate(
          count: 50,
          lifespan: 2,
          generator: (i) {
            final angle = i * (2 * 3.14159 / 50);
            const speed = 100.0;
            final velocity = Vector2(
              speed * cos(angle),
              speed * sin(angle),
            );
            
            return AcceleratedParticle(
              acceleration: Vector2(0, 50), // Gravity
              speed: velocity,
              child: CircleParticle(
                radius: 2,
                paint: Paint()..color = colors[i % colors.length],
              ),
            );
          },
        ),
      );
      
      add(firework);
      
      // Add text effect
      final victoryText = TextComponent(
        text: 'VICTORY!',
        textRenderer: TextPaint(
          style: const TextStyle(
            color: Colors.white,
            fontSize: 48,
            fontWeight: FontWeight.bold,
          ),
        ),
        position: Vector2(center.x, center.y - 100),
        anchor: Anchor.center,
      );
      
      add(victoryText);
      
      // Add stars
      for (int i = 0; i < 3; i++) {
        final star = StarComponent(
          position: Vector2(
            center.x + (i - 1) * 60,
            center.y + 50,
          ),
        );
        add(star);
      }
    }
  }
}

class StarComponent extends PositionComponent {
  StarComponent({required Vector2 position})
      : super(position: position, size: Vector2.all(40));

 @override
Future<void> onLoad() async {
  final points = <Vector2>[
    Vector2(20, 0),
    Vector2(25, 15),
    Vector2(40, 15),
    Vector2(28, 25),
    Vector2(33, 40),
    Vector2(20, 30),
    Vector2(7, 40),
    Vector2(12, 25),
    Vector2(0, 15),
    Vector2(15, 15),
  ];

  final polygon = PolygonComponent(
    points, // ← Positional Argument
    paint: Paint()..color = Colors.yellow,
  );

  add(polygon);
}

}