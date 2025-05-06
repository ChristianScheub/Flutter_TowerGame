import 'package:tower_defense_game/domain/entities/level.dart';
import 'package:tower_defense_game/domain/repositories/level_repository.dart';

class LevelRepositoryImpl implements LevelRepository {
  final List<Level> _levels = [
    // Tutorial Levels (1-3)
    const Level(
      id: '1',
      name: 'First Steps',
      description: 'Learn the basics of tower defense',
      difficulty: 1,
      isEndless: false,
      mapAsset: 'assets/maps/level1.json',
      waves: 5,
      initialResources: 300,
      maxLives: 20,
    ),
    const Level(
      id: '2',
      name: 'Dual Paths',
      description: 'Handle enemies from two directions',
      difficulty: 1,
      isEndless: false,
      mapAsset: 'assets/maps/level2.json',
      waves: 6,
      initialResources: 400,
      maxLives: 18,
    ),
    const Level(
      id: '3',
      name: 'Scout Rush',
      description: 'Fast enemies test your reflexes',
      difficulty: 2,
      isEndless: false,
      mapAsset: 'assets/maps/level3.json',
      waves: 7,
      initialResources: 500,
      maxLives: 15,
    ),
    
    // Early Challenge Levels (4-6)
    const Level(
      id: '4',
      name: 'Tank Brigade',
      description: 'Tough enemies require strategic planning',
      difficulty: 2,
      isEndless: false,
      mapAsset: 'assets/maps/level4.json',
      waves: 8,
      initialResources: 600,
      maxLives: 15,
    ),
    const Level(
      id: '5',
      name: 'Boss Battle',
      description: 'Face your first major challenge',
      difficulty: 3,
      isEndless: false,
      mapAsset: 'assets/maps/level5.json',
      waves: 10,
      initialResources: 700,
      maxLives: 12,
    ),
    const Level(
      id: '6',
      name: 'Air Assault',
      description: 'Flying enemies ignore your maze',
      difficulty: 3,
      isEndless: false,
      mapAsset: 'assets/maps/level6.json',
      waves: 10,
      initialResources: 700,
      maxLives: 12,
    ),
    
    // Mid-Game Levels (7-9)
    const Level(
      id: '7',
      name: 'Healing Squad',
      description: 'Enemies support each other with healing',
      difficulty: 3,
      isEndless: false,
      mapAsset: 'assets/maps/level7.json',
      waves: 12,
      initialResources: 700,
      maxLives: 10,
    ),
    const Level(
      id: '8',
      name: 'Resource Management',
      description: 'Limited resources test your efficiency',
      difficulty: 4,
      isEndless: false,
      mapAsset: 'assets/maps/level8.json',
      waves: 12,
      initialResources: 700,
      maxLives: 10,
    ),
    const Level(
      id: '9',
      name: 'Mixed Forces',
      description: 'Various enemy types attack together',
      difficulty: 4,
      isEndless: false,
      mapAsset: 'assets/maps/level9.json',
      waves: 15,
      initialResources: 800,
      maxLives: 8,
    ),
    
    // Advanced Challenge Levels (10-12)
    const Level(
      id: '10',
      name: 'Elite Boss',
      description: 'A powerful boss with elite minions',
      difficulty: 4,
      isEndless: false,
      mapAsset: 'assets/maps/level10.json',
      waves: 15,
      initialResources: 800,
      maxLives: 8,
    ),
    const Level(
      id: '11',
      name: 'Maze Master',
      description: 'Complex paths require perfect tower placement',
      difficulty: 4,
      isEndless: false,
      mapAsset: 'assets/maps/level11.json',
      waves: 18,
      initialResources: 800,
      maxLives: 6,
    ),
    const Level(
      id: '12',
      name: 'Speed Run',
      description: 'Rapid waves test your quick thinking',
      difficulty: 5,
      isEndless: false,
      mapAsset: 'assets/maps/level12.json',
      waves: 20,
      initialResources: 800,
      maxLives: 6,
    ),
    
    // Expert Levels (13-15)
    const Level(
      id: '13',
      name: 'Ultimate Test',
      description: 'All enemy types in challenging combinations',
      difficulty: 5,
      isEndless: false,
      mapAsset: 'assets/maps/level13.json',
      waves: 25,
      initialResources: 800,
      maxLives: 5,
    ),
    const Level(
      id: '14',
      name: 'Boss Rush',
      description: 'Multiple bosses push your defenses to the limit',
      difficulty: 5,
      isEndless: false,
      mapAsset: 'assets/maps/level14.json',
      waves: 20,
      initialResources: 700,
      maxLives: 5,
    ),
    const Level(
      id: '15',
      name: 'Final Stand',
      description: 'The ultimate challenge of skill and strategy',
      difficulty: 5,
      isEndless: false,
      mapAsset: 'assets/maps/level15.json',
      waves: 30,
      initialResources: 800,
      maxLives: 3,
    ),
    
    // Special Level
    const Level(
      id: 'endless',
      name: 'Endless Mode',
      description: 'How long can you survive?',
      difficulty: 5,
      isEndless: true,
      mapAsset: 'assets/maps/endless.json',
      initialResources: 1000,
      maxLives: 5,
    ),
  ];

  @override
  Future<List<Level>> getAllLevels() async {
    return Future.delayed(
      const Duration(milliseconds: 300),
      () => _levels,
    );
  }

  @override
  Future<Level?> getLevelById(String levelId) async {
    return Future.delayed(
      const Duration(milliseconds: 100),
      () => _levels.firstWhere(
        (level) => level.id == levelId,
        orElse: () => _levels.first,
      ),
    );
  }

  @override
  bool isEndlessMode(String levelId) {
    return levelId == 'endless';
  }

  @override
  double getLevelDifficultyMultiplier(String levelId) {
    if (isEndlessMode(levelId)) {
      return 2.0;
    }
    
    final id = int.tryParse(levelId) ?? 1;
    return 0.8 + (id * 0.15); // Smoother difficulty progression
  }

  @override
  Future<List<Map<String, dynamic>>> getLevelWaves(String levelId) async {
    if (isEndlessMode(levelId)) {
      return [];
    }
    
    final id = int.tryParse(levelId) ?? 1;
    final level = await getLevelById(levelId);
    final numWaves = level?.waves ?? (id * 5);
    
    final List<Map<String, dynamic>> waves = [];
    
    for (int i = 0; i < numWaves; i++) {
      waves.add({
        'waveNumber': i + 1,
        'enemies': _generateEnemiesForWave(id, i + 1),
        'spawnInterval': _getSpawnInterval(id, i + 1),
      });
    }
    
    return waves;
  }

  double _getSpawnInterval(int levelId, int waveNumber) {
    // Faster spawns in later levels and waves
    double baseInterval = 1.5;
    double levelReduction = levelId * 0.05;
    double waveReduction = waveNumber * 0.02;
    return (baseInterval - levelReduction - waveReduction).clamp(0.5, 1.5);
  }

  List<Map<String, dynamic>> _generateEnemiesForWave(int levelId, int waveNumber) {
    final List<Map<String, dynamic>> enemies = [];
    final baseCount = 5 + (waveNumber * 2);
    
    // Boss waves
    if (waveNumber % 5 == 0) {
      enemies.add({
        'type': 'boss',
        'count': levelId >= 14 ? 2 : 1, // Double bosses in last levels
      });
    }
    
    // Regular enemies based on level progression
    if (levelId >= 2) {
      enemies.add({
        'type': 'scout',
        'count': baseCount ~/ 2,
      });
    }
    
    if (levelId >= 4) {
      enemies.add({
        'type': 'tank',
        'count': baseCount ~/ 3,
      });
    }
    
    if (levelId >= 6) {
      enemies.add({
        'type': 'flyer',
        'count': baseCount ~/ 3,
      });
    }
    
    if (levelId >= 7) {
      enemies.add({
        'type': 'healer',
        'count': baseCount ~/ 4,
      });
    }
    
    // Basic enemies always present
    enemies.add({
      'type': 'basic',
      'count': baseCount,
    });
    
    return enemies;
  }

  @override
  Future<Map<String, dynamic>> getLevelMap(String levelId) async {
    return {
      'width': 40,
      'height': 24,
      'tileSize': 32,
      'startPoints': _generateStartPoints(levelId),
      'endPoints': _generateEndPoints(levelId),
      'paths': _generatePaths(levelId),
      'buildableTiles': _generateBuildableTiles(levelId),
    };
  }

  List<Map<String, int>> _generateStartPoints(String levelId) {
    if (isEndlessMode(levelId)) {
      return [
        {'x': 0, 'y': 3},
        {'x': 19, 'y': 8},
      ];
    }
    
    final id = int.tryParse(levelId) ?? 1;
    final points = <Map<String, int>>[];
    
    switch (id) {
      case 1:
        points.add({'x': 0, 'y': 5});
        break;
      case 2:
        points.addAll([
          {'x': 0, 'y': 3},
          {'x': 0, 'y': 8},
        ]);
        break;
      case 3:
        points.add({'x': 0, 'y': 2});
        break;
      case 4:
        points.addAll([
          {'x': 0, 'y': 1},
          {'x': 0, 'y': 10},
        ]);
        break;
      case 5:
        points.add({'x': 0, 'y': 5});
        break;
      case 6:
        points.addAll([
          {'x': 0, 'y': 3},
          {'x': 19, 'y': 3},
        ]);
        break;
      case 7:
        points.addAll([
          {'x': 0, 'y': 2},
          {'x': 0, 'y': 9},
        ]);
        break;
      case 8:
        points.add({'x': 0, 'y': 6});
        break;
      case 9:
        points.addAll([
          {'x': 0, 'y': 1},
          {'x': 0, 'y': 6},
          {'x': 0, 'y': 10},
        ]);
        break;
      case 10:
        points.add({'x': 0, 'y': 5});
        break;
      case 11:
        points.addAll([
          {'x': 0, 'y': 2},
          {'x': 19, 'y': 2},
        ]);
        break;
      case 12:
        points.addAll([
          {'x': 0, 'y': 3},
          {'x': 0, 'y': 8},
        ]);
        break;
      case 13:
        points.addAll([
          {'x': 0, 'y': 1},
          {'x': 0, 'y': 5},
          {'x': 0, 'y': 9},
        ]);
        break;
      case 14:
        points.addAll([
          {'x': 0, 'y': 2},
          {'x': 19, 'y': 8},
        ]);
        break;
      case 15:
        points.addAll([
          {'x': 0, 'y': 1},
          {'x': 0, 'y': 5},
          {'x': 0, 'y': 10},
          {'x': 19, 'y': 3},
          {'x': 19, 'y': 8},
        ]);
        break;
      default:
        points.add({'x': 0, 'y': 5});
    }
    
    return points;
  }

  List<Map<String, int>> _generateEndPoints(String levelId) {
    if (isEndlessMode(levelId)) {
      return [
        {'x': 19, 'y': 3},
        {'x': 0, 'y': 8},
      ];
    }
    
    final id = int.tryParse(levelId) ?? 1;
    final points = <Map<String, int>>[];
    
    switch (id) {
      case 1:
        points.add({'x': 19, 'y': 5});
        break;
      case 2:
        points.addAll([
          {'x': 19, 'y': 3},
          {'x': 19, 'y': 8},
        ]);
        break;
      case 3:
        points.add({'x': 19, 'y': 8});
        break;
      case 4:
        points.addAll([
          {'x': 19, 'y': 1},
          {'x': 19, 'y': 10},
        ]);
        break;
      case 5:
        points.add({'x': 19, 'y': 5});
        break;
      case 6:
        points.addAll([
          {'x': 19, 'y': 8},
          {'x': 0, 'y': 8},
        ]);
        break;
      case 7:
        points.add({'x': 19, 'y': 5});
        break;
      case 8:
        points.add({'x': 19, 'y': 6});
        break;
      case 9:
        points.addAll([
          {'x': 19, 'y': 3},
          {'x': 19, 'y': 8},
        ]);
        break;
      case 10:
        points.add({'x': 19, 'y': 5});
        break;
      case 11:
        points.addAll([
          {'x': 10, 'y': 0},
          {'x': 10, 'y': 11},
        ]);
        break;
      case 12:
        points.addAll([
          {'x': 19, 'y': 3},
          {'x': 19, 'y': 8},
        ]);
        break;
      case 13:
        points.addAll([
          {'x': 19, 'y': 3},
          {'x': 19, 'y': 8},
        ]);
        break;
      case 14:
        points.addAll([
          {'x': 19, 'y': 2},
          {'x': 0, 'y': 8},
        ]);
        break;
      case 15:
        points.addAll([
          {'x': 19, 'y': 1},
          {'x': 19, 'y': 5},
          {'x': 19, 'y': 10},
          {'x': 0, 'y': 3},
          {'x': 0, 'y': 8},
        ]);
        break;
      default:
        points.add({'x': 19, 'y': 5});
    }
    
    return points;
  }

  List<List<Map<String, int>>> _generatePaths(String levelId) {
    if (isEndlessMode(levelId)) {
      return [
        [
          {'x': 0, 'y': 3},
          {'x': 18, 'y': 3},
          {'x': 18, 'y': 8},
          {'x': 0, 'y': 8},
        ],
        [
          {'x': 19, 'y': 8},
          {'x': 1, 'y': 8},
          {'x': 1, 'y': 3},
          {'x': 19, 'y': 3},
        ],
      ];
    }
    
    final id = int.tryParse(levelId) ?? 1;
    final startPoints = _generateStartPoints(levelId);
    final endPoints = _generateEndPoints(levelId);
    final paths = <List<Map<String, int>>>[];
    
    for (int i = 0; i < startPoints.length; i++) {
      final start = startPoints[i];
      final end = endPoints[i % endPoints.length];
      final path = _generatePathBetweenPoints(start, end, id);
      paths.add(path);
    }
    
    return paths;
  }

  List<Map<String, int>> _generatePathBetweenPoints(
    Map<String, int> start,
    Map<String, int> end,
    int levelId,
  ) {
    final path = <Map<String, int>>[start];
    
    // Generate unique path patterns for each level
    switch (levelId) {
      case 1: // Simple path
        path.addAll([
          {'x': 5, 'y': start['y']!},
          {'x': 5, 'y': 2},
          {'x': 15, 'y': 2},
          {'x': 15, 'y': end['y']!},
          end,
        ]);
        break;
      
      case 2: // Parallel paths
        path.addAll([
          {'x': 18, 'y': start['y']!},
          {'x': 18, 'y': end['y']!},
          end,
        ]);
        break;
      
      case 3: // Zigzag path
        path.addAll([
          {'x': 5, 'y': 2},
          {'x': 5, 'y': 8},
          {'x': 10, 'y': 8},
          {'x': 10, 'y': 2},
          {'x': 15, 'y': 2},
          {'x': 15, 'y': 8},
          end,
        ]);
        break;
      
      case 4: // Direct paths
        path.add(end);
        break;
      
      case 5: // Complex zigzag
        path.addAll([
          {'x': 4, 'y': start['y']!},
          {'x': 4, 'y': 2},
          {'x': 8, 'y': 2},
          {'x': 8, 'y': 8},
          {'x': 12, 'y': 8},
          {'x': 12, 'y': 2},
          {'x': 16, 'y': 2},
          {'x': 16, 'y': end['y']!},
          end,
        ]);
        break;
      
      case 6: // Crossing paths
        path.addAll([
          {'x': 10, 'y': start['y']!},
          {'x': 10, 'y': 6},
          {'x': end['x'] ?? 0, 'y': 6},
          end,
        ]);
        break;
      
      case 7: // Spiral path
        path.addAll([
          {'x': 5, 'y': start['y']!},
          {'x': 5, 'y': 5},
          {'x': 15, 'y': 5},
          {'x': 15, 'y': 2},
          {'x': 10, 'y': 2},
          {'x': 10, 'y': 8},
          end,
        ]);
        break;
      
      case 8: // Maze-like path
        path.addAll([
          {'x': 5, 'y': start['y']!},
          {'x': 5, 'y': 2},
          {'x': 15, 'y': 2},
          {'x': 15, 'y': 10},
          {'x': 10, 'y': 10},
          {'x': 10, 'y': 6},
          end,
        ]);
        break;
      
      case 9: // Multiple converging paths
        path.addAll([
          {'x': 8, 'y': start['y']!},
          {'x': 8, 'y': 5},
          {'x': 12, 'y': 5},
          {'x': 12, 'y': end['y']!},
          end,
        ]);
        break;
      
      case 10: // Boss level path
        path.addAll([
          {'x': 5, 'y': 5},
          {'x': 15, 'y': 5},
          end,
        ]);
        break;
      
      case 11: // Complex maze
        path.addAll([
          {'x': 5, 'y': start['y']!},
          {'x': 5, 'y': 6},
          {'x': 10, 'y': 6},
          {'x': 10, 'y': 2},
          {'x': 15, 'y': 2},
          {'x': 15, 'y': end['y']!},
          end,
        ]);
        break;
      
      case 12: // Speed run path
        path.addAll([
          {'x': 10, 'y': start['y']!},
          {'x': 10, 'y': end['y']!},
          end,
        ]);
        break;
      
      case 13: // Multi-layer paths
        path.addAll([
          {'x': 5, 'y': start['y']!},
          {'x': 5, 'y': 5},
          {'x': 15, 'y': 5},
          {'x': 15, 'y': end['y']!},
          end,
        ]);
        break;
      
      case 14: // Boss rush paths
        path.addAll([
          {'x': 10, 'y': start['y']!},
          {'x': 10, 'y': 5},
          {'x': end['x'] ?? 0, 'y': 5},
          end,
        ]);
        break;
      
      case 15: // Final challenge paths
        path.addAll([
          {'x': 5, 'y': start['y']!},
          {'x': 5, 'y': 5},
          {'x': 10, 'y': 5},
          {'x': 10, 'y': end['y']!},
          {'x': 15, 'y': end['y']!},
          end,
        ]);
        break;
      
      default:
        path.add(end);
    }
    
    return path;
  }

  List<Map<String, int>> _generateBuildableTiles(String levelId) {
    final tiles = <Map<String, int>>[];
    final id = int.tryParse(levelId) ?? 1;
    
    // Create base buildable areas
    for (int x = 2; x < 18; x += 3) {
      for (int y = 1; y < 11; y += 3) {
        tiles.add({'x': x, 'y': y});
      }
    }
    
    // Add level-specific buildable tiles
    switch (id) {
      case 1:
        tiles.addAll([
          {'x': 2, 'y': 2},
          {'x': 2, 'y': 8},
          {'x': 8, 'y': 4},
          {'x': 8, 'y': 6},
        ]);
        break;
      
      case 5: // Boss level
        tiles.addAll([
          {'x': 3, 'y': 3},
          {'x': 7, 'y': 3},
          {'x': 11, 'y': 3},
          {'x': 15, 'y': 3},
          {'x': 3, 'y': 7},
          {'x': 7, 'y': 7},
          {'x': 11, 'y': 7},
          {'x': 15, 'y': 7},
        ]);
        break;
      
      case 10: // Elite boss level
        tiles.addAll([
          {'x': 4, 'y': 2},
          {'x': 8, 'y': 2},
          {'x': 12, 'y': 2},
          {'x': 16, 'y': 2},
          {'x': 4, 'y': 8},
          {'x': 8, 'y': 8},
          {'x': 12, 'y': 8},
          {'x': 16, 'y': 8},
        ]);
        break;
      
      case 15: // Final level
        tiles.addAll([
          {'x': 3, 'y': 2},
          {'x': 7, 'y': 2},
          {'x': 11, 'y': 2},
          {'x': 15, 'y': 2},
          {'x': 3, 'y': 5},
          {'x': 7, 'y': 5},
          {'x': 11, 'y': 5},
          {'x': 15, 'y': 5},
          {'x': 3, 'y': 8},
          {'x': 7, 'y': 8},
          {'x': 11, 'y': 8},
          {'x': 15, 'y': 8},
        ]);
        break;
    }
    
    return tiles;
  }
}