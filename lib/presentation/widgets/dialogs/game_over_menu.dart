import 'package:flutter/material.dart';
import '../../../l10n/gen_l10n/app_localizations.dart';

class GameOverMenu extends StatelessWidget {
  final VoidCallback onReturnToMenu;
  final VoidCallback onTryAgain;

  const GameOverMenu({
    Key? key,
    required this.onReturnToMenu,
    required this.onTryAgain,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);

    return Center(
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.8),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              local.gameOver,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: onReturnToMenu,
              child: Text(local.returnToMenu),
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: onTryAgain,
              child: Text(local.tryAgain),
            ),
          ],
        ),
      ),
    );
  }
}
