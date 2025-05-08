import 'package:flame/game.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:tower_defense_game/data/config/tower.config.dart';
import 'package:tower_defense_game/domain/entities/level.dart';
import 'package:tower_defense_game/domain/repositories/game_repository.dart';
import 'package:tower_defense_game/presentation/game/components/enemy.dart';
import 'package:tower_defense_game/presentation/game/components/end_building.dart';
import 'package:tower_defense_game/presentation/game/components/map.dart';
import 'package:tower_defense_game/presentation/game/components/projectile.dart';
import 'package:tower_defense_game/presentation/game/components/tower.dart';
import 'package:tower_defense_game/presentation/game/components/victory_effect.dart';
import 'package:tower_defense_game/presentation/game/components/game_over_effect.dart';
import 'dart:math';

class TowerDefenseGame extends FlameGame
    with TapCallbacks, DragCallbacks, ScrollDetector {
  final Level level;
  String? selectedTowerId;
  late GameMap gameMap;
  final List<Tower> towers = [];
  final List<Enemy> enemies = [];
  final List<Projectile> projectiles = [];
  final List<EndBuilding> endBuildings = [];
  int resources = 0;
  int lives = 0;
  int currentWave = 0;
  double waveTimer = 5.0;
  double spawnTimer = 0.0;
  List<Map<String, dynamic>> currentWaveEnemies = [];
  int enemiesLeftToSpawn = 0;
  bool isDoubleSpeed = false;
  double difficultyMultiplier = 1.0;
  bool isVictoryAnimationShown = false;
  bool isGameOverAnimationShown = false;

  double minZoom = 0.5;
  double maxZoom = 2.0;
  double currentZoom = 1.0;

  Function(Tower tower, int cost)? onShowUpgradeDialog;
  Function()? onEnemyReachEnd;
  Function(double zoom)? onZoomChanged;

  TowerDefenseGame({
    required this.level,
    this.onEnemyReachEnd,
    this.onZoomChanged,
  });

  @override
  Future<void> onLoad() async {
    camera.viewfinder.zoom = currentZoom;

    resources = level.initialResources;
    lives = level.maxLives;
    gameMap = GameMap(level: level);
    await add(gameMap);

    for (final endPoint in gameMap.endPoints) {
      final building = EndBuilding(position: endPoint);
      endBuildings.add(building);
      add(building);
    }

    await _initializeWaveData();
  }

  Future<void> _initializeWaveData() async {
    currentWave = 0;
    waveTimer = 5.0;
    difficultyMultiplier = 1.0;

    if (level.isEndless) {
      _generateEndlessWave();
    } else {
      _generateWaveEnemies();
    }
  }

  void _generateWaveEnemies() {
    final isBossWave = (currentWave + 1) % 5 == 0;
    final baseCount = 5 + (currentWave * 2);

    currentWaveEnemies = [
      {'type': 'basic', 'count': baseCount + (currentWave < 3 ? 5 : 0)},
      {'type': 'scout', 'count': currentWave > 1 ? baseCount ~/ 2 : 0},
      {'type': 'tank', 'count': currentWave > 2 ? baseCount ~/ 3 : 0},
      {'type': 'flyer', 'count': currentWave > 3 ? baseCount ~/ 3 : 0},
      {'type': 'healer', 'count': currentWave > 4 ? baseCount ~/ 4 : 0},
    ];

    if (isBossWave) {
      currentWaveEnemies.add({'type': 'boss', 'count': 1});
    }

    enemiesLeftToSpawn = currentWaveEnemies.fold(
      0,
      (sum, enemy) => sum + (enemy['count'] as int),
    );
  }

  void _generateEndlessWave() {
    final waveNumber = currentWave + 1;
    final baseCount = 5 + (waveNumber * 2);

    currentWaveEnemies = [
      {'type': 'basic', 'count': baseCount + (waveNumber < 3 ? 5 : 0)},
      {'type': 'scout', 'count': waveNumber > 1 ? baseCount ~/ 2 : 0},
      {'type': 'tank', 'count': waveNumber > 2 ? baseCount ~/ 3 : 0},
      {'type': 'flyer', 'count': waveNumber > 3 ? baseCount ~/ 3 : 0},
      {'type': 'healer', 'count': waveNumber > 4 ? baseCount ~/ 4 : 0},
      {'type': 'boss', 'count': waveNumber > 5 && waveNumber % 5 == 0 ? 1 : 0},
    ];

    enemiesLeftToSpawn = currentWaveEnemies.fold(
      0,
      (sum, enemy) => sum + (enemy['count'] as int),
    );
  }

  @override
  void update(double dt) {
    if (isDoubleSpeed) {
      dt *= 2;
    }

    super.update(dt);

    if (waveTimer > 0) {
      waveTimer -= dt;
      if (waveTimer <= 0) {
        spawnTimer = 0;
      }
    } else if (enemiesLeftToSpawn > 0) {
      spawnTimer -= dt;
      if (spawnTimer <= 0) {
        _spawnNextEnemy();
        spawnTimer = 1.0;
      }
    } else if (enemies.isEmpty && waveTimer <= 0) {
      if (!level.isEndless && currentWave >= (level.waves ?? 0) - 1) {
        if (!isVictoryAnimationShown) {
          _showVictoryAnimation();
          isVictoryAnimationShown = true;
          _saveLevelProgress();
        }
      } else {
        currentWave++;
        difficultyMultiplier += level.isEndless ? 0.3 : 0.2;
        waveTimer = 5.0;
        if (level.isEndless) {
          _generateEndlessWave();
        } else {
          _generateWaveEnemies();
        }
      }
    }

    for (final tower in towers) {
      tower.findTarget(enemies);
    }

    // Projektil-Logik zentral verarbeiten
    for (final projectile in [...projectiles]) {
      final hitEnemy = projectile.checkHit(enemies);
      if (hitEnemy != null) {
        _handleProjectileHit(projectile, hitEnemy);
        projectiles.remove(projectile);
        projectile.removeFromParent();
      }
    }

    for (final enemy in [...enemies]) {
      if (enemy.reachedEnd) {
        lives -= enemy.damage;
        enemy.removeFromParent();

        // Finde das nächste EndBuilding und füge Schaden hinzu
        EndBuilding? closestBuilding;
        double closestDistance = double.infinity;

        for (final building in endBuildings) {
          final distance = (building.position - enemy.position).length;
          if (distance < closestDistance) {
            closestDistance = distance;
            closestBuilding = building;
          }
        }

        if (closestBuilding != null) {
          closestBuilding.takeDamage(enemy.damage);
        }

        enemies.remove(enemy);

        if (onEnemyReachEnd != null) {
          onEnemyReachEnd!();
        }

        if (lives <= 0 && !isGameOverAnimationShown) {
          _gameOver();
        }
      }
    }
  }

  void _handleProjectileHit(Projectile projectile, Enemy enemy) {
    // Effekte vor Schaden anwenden
    if (projectile.config.special != null) {
      switch (projectile.config.special!.type) {
        case EffectType.frost:
          enemy.applyFrostEffect(projectile.config.special!.duration);
          break;
        case EffectType.poison:
          enemy.applyPoisonEffect(
            projectile.config.special!.damagePerSecond!,
            projectile.config.special!.duration,
          );
          break;
      }
    }

    // Schaden anwenden und Gegner entfernen wenn tot
    if (enemy.takeDamage(projectile.damage)) {
      resources += enemy.reward;
      enemies.remove(enemy);
      enemy.removeFromParent();
    }
  }

  void _spawnNextEnemy() {
    if (enemiesLeftToSpawn <= 0) return;

    String? typeToSpawn;
    for (final enemyType in currentWaveEnemies) {
      if (enemyType['count'] > 0) {
        typeToSpawn = enemyType['type'];
        enemyType['count'] = enemyType['count'] - 1;
        break;
      }
    }

    if (typeToSpawn != null) {
      // Wähle einen zufälligen Pfad für den Spawn
      final random = Random();
      final pathIndex = random.nextInt(gameMap.paths.length);
      final path = gameMap.paths[pathIndex];
      
      final enemy = Enemy.create(
        type: typeToSpawn,
        position: path.first.clone(), // Benutze den Startpunkt des gewählten Pfads
        path: path,
        difficultyMultiplier: difficultyMultiplier,
      );

      enemies.add(enemy);
      add(enemy);
      enemiesLeftToSpawn--;
    }
  }

  Future<void> _saveLevelProgress() async {
    if (!level.isEndless) {
      final gameRepository = GetIt.instance<GameRepository>();
      final levelId = int.tryParse(level.id);
      if (levelId != null) {
        await gameRepository.saveGameProgress(
          levelId,
          resources,
          3,
        );
      }
    }
  }

  void _showVictoryAnimation() {
    final victoryEffect = VictoryEffect();
    add(victoryEffect);

    Future.delayed(const Duration(seconds: 3), () {
      pauseEngine();
      overlays.add('victoryMenu');
    });
  }

  void _gameOver() {
    isGameOverAnimationShown = true;
    final gameOverEffect = GameOverEffect();
    add(gameOverEffect);

    Future.delayed(const Duration(seconds: 2), () {
      pauseEngine();
      overlays.add('gameOverMenu');
    });
  }

  void toggleSpeed() {
    isDoubleSpeed = !isDoubleSpeed;
  }

  void selectTower(String? towerId) {
    selectedTowerId = towerId;
  }

  @override
  bool onTapDown(TapDownEvent event) {
    Tower? tappedTower;
    for (final tower in towers) {
      if ((tower.position - event.canvasPosition).length < 20) {
        tappedTower = tower;
        break;
      }
    }

    if (tappedTower != null && selectedTowerId == null) {
      final upgradeCost =
          (TowerConfigs.towers[tappedTower.config.id]!.cost * 0.5).round();
      if (onShowUpgradeDialog != null) {
        onShowUpgradeDialog!(tappedTower, upgradeCost);
      }
      return true;
    }

    if (selectedTowerId != null) {
      final config = TowerConfigs.towers[selectedTowerId!]!;
      if (resources >= config.cost) {
        resources -= config.cost;
        final tower = Tower.create(
          type: selectedTowerId!,
          position: event.canvasPosition,
        );
        towers.add(tower);
        add(tower);
      } else {
        if (buildContext != null) {
          showDialog(
            context:
                buildContext!,
            builder: (context) => AlertDialog(
              title: const Text("Zu teuer!"),
              content: const Text(
                  "Du hast nicht genug Ressourcen, um diesen Turm zu bauen."),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("OK"),
                ),
              ],
            ),
          );
        }
      }
    }

    return true;
  }

  void upgradeTower(Tower tower) {
    final upgradeCost =
        (TowerConfigs.towers[tower.config.id]!.cost * 0.5).round();
    if (resources >= upgradeCost) {
      resources -= upgradeCost;
      tower.upgrade();
    }
  }

  double getWaveTimer() => waveTimer;
  int getCurrentWave() => currentWave + 1;
  bool isWaveInProgress() =>
      waveTimer <= 0 && (enemiesLeftToSpawn > 0 || enemies.isNotEmpty);
  bool getIsDoubleSpeed() => isDoubleSpeed;
}
