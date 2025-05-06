import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:tower_defense_game/domain/repositories/level_repository.dart';
import 'package:tower_defense_game/presentation/game/components/tower.dart';
import 'package:tower_defense_game/presentation/game/tower_defense_game.dart';
import 'package:tower_defense_game/presentation/widgets/gameControls/game_control_panel.dart';
import 'package:tower_defense_game/presentation/widgets/gameControls/game_hud.dart';
import 'package:tower_defense_game/presentation/widgets/dialogs/upgrade_dialog.dart';
import 'package:tower_defense_game/presentation/widgets/dialogs/game_over_menu.dart';
import 'package:tower_defense_game/presentation/widgets/dialogs/victory_menu.dart';
import 'package:tower_defense_game/presentation/widgets/dialogs/pause_dialog.dart';

class GamePage extends StatefulWidget {
  final String levelId;

  const GamePage({Key? key, required this.levelId}) : super(key: key);

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  late final TowerDefenseGame _game;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeGame();
  }

  Future<void> _initializeGame() async {
    final levelRepository = GetIt.instance<LevelRepository>();
    final level = await levelRepository.getLevelById(widget.levelId);

    if (level != null) {
      _game = TowerDefenseGame(
        level: level,
        onEnemyReachEnd: _onEnemyReachEnd,
      );
      _game.onShowUpgradeDialog = _showUpgradeDialog;

      setState(() {
        _isLoading = false;
      });
    }
  }

  void _onEnemyReachEnd() {
    HapticFeedback.heavyImpact();
  }

  void _showUpgradeDialog(Tower tower, int cost) {
    showDialog(
      context: context,
      builder: (_) => UpgradeDialog(
        tower: tower,
        cost: cost,
        game: _game,
      ),
    );
  }

  void _onPausePressed() {
    _game.pauseEngine();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => PauseDialog(
        onResume: () {
          Navigator.of(context).pop();
          _game.resumeEngine();
        },
        onQuit: () {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        },
      ),
    );
  }

  void _onTowerSelected(String towerId) {
    setState(() {
      _game.selectTower(_game.selectedTowerId == towerId ? null : towerId);
    });
  }

  @override
  void dispose() {
    _game.pauseEngine();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    if (_isLoading) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          GameWidget(
            game: _game,
            overlayBuilderMap: {
              'gameOverMenu': (context, game) => GameOverMenu(
                    onReturnToMenu: () => Navigator.of(context).pop(),
                    onTryAgain: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_) => GamePage(levelId: widget.levelId)),
                      );
                    },
                  ),
              'victoryMenu': (context, game) => VictoryMenu(
                    onContinue: () => Navigator.of(context).pop(),
                    onPlayAgain: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_) => GamePage(levelId: widget.levelId)),
                      );
                    },
                  ),
            },
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: StreamBuilder<double>(
              stream: Stream.periodic(const Duration(milliseconds: 100), (_) => _game.getWaveTimer()),
              builder: (_, __) => GameHUD(
                lives: _game.lives,
                resources: _game.resources,
                wave: _game.getCurrentWave(),
                waveTimer: _game.getWaveTimer(),
                isWaveInProgress: _game.isWaveInProgress(),
                isDoubleSpeed: _game.getIsDoubleSpeed(),
                onPausePressed: _onPausePressed,
                onSpeedToggle: () => setState(() => _game.toggleSpeed()),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: GameControlPanel(
              onTowerSelected: _onTowerSelected,
              selectedTowerId: _game.selectedTowerId,
              availableResources: _game.resources,
            ),
          ),
        ],
      ),
    );
  }
}
