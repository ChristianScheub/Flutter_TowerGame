import 'package:flutter/material.dart';
import '../../../l10n/gen_l10n/app_localizations.dart';
import 'package:tower_defense_game/presentation/game/components/tower.dart';
import 'package:tower_defense_game/presentation/game/tower_defense_game.dart';

class UpgradeDialog extends StatelessWidget {
  final Tower tower;
  final int cost;
  final TowerDefenseGame game;

  const UpgradeDialog({
    Key? key,
    required this.tower,
    required this.cost,
    required this.game,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);

    return AlertDialog(
      title: Text(local.upgradeTower),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(local.currentLevel(tower.level)),
          const SizedBox(height: 8),
          Text(local.upgradeCost(cost)),
          const SizedBox(height: 16),
          Text(local.upgradeWill),
          Text(local.upgradeEffect1),
          Text(local.upgradeEffect2),
          Text(local.upgradeEffect3),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(local.cancel),
        ),
        ElevatedButton(
          onPressed: (game.resources >= cost && tower.level < 7)
              ? () {
                  game.upgradeTower(tower);
                  Navigator.pop(context);
                }
              : null,
          child: Text(local.upgrade),
        ),
      ],
    );
  }
}
