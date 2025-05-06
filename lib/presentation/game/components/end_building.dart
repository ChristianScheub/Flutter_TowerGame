import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:tower_defense_game/presentation/game/tower_defense_game.dart';

class EndBuilding extends PositionComponent with HasGameRef<TowerDefenseGame> {
  final int maxHealth;
  int health;
  // Removed the redundant position field as it conflicts with the inherited property
  late RectangleComponent buildingSprite;
  
  EndBuilding({
    required Vector2 position,
    this.maxHealth = 100,
    Vector2? size,
  }) : health = maxHealth,
       super(
         position: position, // Use the inherited position property
         size: size ?? Vector2(48, 48),
         anchor: Anchor.center,
       );

  @override
  Future<void> onLoad() async {
    buildingSprite = RectangleComponent(
      size: size,
      paint: Paint()..color = Colors.blue.shade800,
    );
    add(buildingSprite);
  }

  void takeDamage(int amount) {
    health = (health - amount).clamp(0, maxHealth);
  
    // Visual feedback
    buildingSprite.paint.color = Colors.red;
    Future.delayed(const Duration(milliseconds: 100), () {
      if (isMounted) {
        buildingSprite.paint.color = Colors.blue.shade800;
      }
    });
  }
}