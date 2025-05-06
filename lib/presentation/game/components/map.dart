import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:tower_defense_game/domain/entities/level.dart';
import 'package:tower_defense_game/domain/repositories/level_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:tower_defense_game/presentation/game/tower_defense_game.dart';

class GameMap extends PositionComponent with HasGameRef<TowerDefenseGame> {
  final Level level;
  final double tileSize = 32.0;
  @override
  late double width;
  @override
  late double height;
  late List<List<Vector2>> paths;
  late List<Vector2> startPoints;
  late List<Vector2> endPoints;
  late List<Vector2> buildableTiles;

  GameMap({
    required this.level,
    Vector2? position,
    Vector2? size,
  }) : super(
          position: position ?? Vector2.zero(),
          size: size ?? Vector2.zero(),
        );

  @override
  Future<void> onLoad() async {
    await _loadMapData();
    size.setValues(width * tileSize, height * tileSize);
    await _drawTerrain();
    await _drawPaths();
    await _drawGrid();
  }

  Future<void> _loadMapData() async {
    final levelRepository = GetIt.instance<LevelRepository>();
    final mapData = await levelRepository.getLevelMap(level.id);

    width = (mapData['width'] as int).toDouble();
    height = (mapData['height'] as int).toDouble();

    // Convert start points
    startPoints =
        (mapData['startPoints'] as List<Map<String, int>>).map((point) {
      return Vector2(
        point['x']!.toDouble() * tileSize,
        point['y']!.toDouble() * tileSize,
      );
    }).toList();

    // Convert end points
    endPoints = (mapData['endPoints'] as List<Map<String, int>>).map((point) {
      return Vector2(
        point['x']!.toDouble() * tileSize,
        point['y']!.toDouble() * tileSize,
      );
    }).toList();

    // Convert paths
    paths = (mapData['paths'] as List<List<Map<String, int>>>).map((path) {
      return path.map((point) {
        return Vector2(
          point['x']!.toDouble() * tileSize,
          point['y']!.toDouble() * tileSize,
        );
      }).toList();
    }).toList();

    // Convert buildable tiles
    buildableTiles =
        (mapData['buildableTiles'] as List<Map<String, int>>).map((point) {
      return Vector2(
        point['x']!.toDouble() * tileSize,
        point['y']!.toDouble() * tileSize,
      );
    }).toList();
  }

  Future<void> _drawTerrain() async {
    for (int x = 0; x < width; x++) {
      for (int y = 0; y < height; y++) {
        final isEdge = x == 0 || y == 0 || x == width - 1 || y == height - 1;

        final tile = RectangleComponent(
          position: Vector2(x * tileSize, y * tileSize),
          size: Vector2(tileSize, tileSize),
          paint: Paint()
            ..color =
                isEdge ? const Color(0xFF2C3E50) : const Color(0xFF34495E),
        );

        await add(tile);
      }
    }
  }

  Future<void> _drawPaths() async {
    for (final path in paths) {
      for (int i = 0; i < path.length - 1; i++) {
        final start = path[i];
        final end = path[i + 1];

        if (start.y == end.y) {
          final minX = start.x < end.x ? start.x : end.x;
          final maxX = start.x < end.x ? end.x : start.x;

          for (double x = minX; x < maxX; x += tileSize) {
            final pathTile = RectangleComponent(
              position: Vector2(x, start.y),
              size: Vector2(tileSize, tileSize),
              paint: Paint()..color = const Color(0xFF7F8C8D),
            );

            await add(pathTile);
          }
        }

        if (start.x == end.x) {
          final minY = start.y < end.y ? start.y : end.y;
          final maxY = start.y < end.y ? end.y : start.y;

          for (double y = minY; y < maxY; y += tileSize) {
            final pathTile = RectangleComponent(
              position: Vector2(start.x, y),
              size: Vector2(tileSize, tileSize),
              paint: Paint()..color = const Color(0xFF7F8C8D),
            );

            await add(pathTile);
          }
        }
      }
    }
  }

  Future<void> _drawGrid() async {
    for (int x = 0; x < width; x++) {
      for (int y = 0; y < height; y++) {
        final gridLine = RectangleComponent(
          position: Vector2(x * tileSize, y * tileSize),
          size: Vector2(tileSize, tileSize),
          paint: Paint()
            ..color = Colors.white.withOpacity(0.1)
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1,
        );
        await add(gridLine);
      }
    }
  }

  bool canBuildAt(Vector2 position) {
    if (position.x < 0 ||
        position.x > width * tileSize ||
        position.y < 0 ||
        position.y > height * tileSize) {
      return false;
    }

    // Check if position is on a buildable tile
    bool isOnBuildableTile = false;
    for (final tile in buildableTiles) {
      if ((position - tile).length < tileSize / 2) {
        isOnBuildableTile = true;
        break;
      }
    }

    if (!isOnBuildableTile) {
      return false;
    }

    // Check if position is on a path
    for (final path in paths) {
      for (int i = 0; i < path.length - 1; i++) {
        final start = path[i];
        final end = path[i + 1];

        if (_isPointNearLineSegment(position, start, end)) {
          return false;
        }
      }
    }

    // Check if tower already exists at this position
    for (final tower in gameRef.towers) {
      if ((tower.position - position).length < tileSize) {
        return false;
      }
    }

    return true;
  }

  bool _isPointNearLineSegment(Vector2 point, Vector2 start, Vector2 end) {
    final buffer = tileSize * 0.8;

    if (start.x == end.x) {
      final minY = start.y < end.y ? start.y : end.y;
      final maxY = start.y < end.y ? end.y : start.y;

      return point.x >= start.x - buffer &&
          point.x <= start.x + buffer &&
          point.y >= minY - buffer &&
          point.y <= maxY + buffer;
    }

    if (start.y == end.y) {
      final minX = start.x < end.x ? start.x : end.x;
      final maxX = start.x < end.x ? end.x : start.x;

      return point.y >= start.y - buffer &&
          point.y <= start.y + buffer &&
          point.x >= minX - buffer &&
          point.x <= maxX + buffer;
    }

    return false;
  }
}
