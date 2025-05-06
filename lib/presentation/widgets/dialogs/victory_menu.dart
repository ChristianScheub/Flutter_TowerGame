import 'package:flutter/material.dart';
import '../../../l10n/gen_l10n/app_localizations.dart';

class VictoryMenu extends StatelessWidget {
  final VoidCallback onContinue;
  final VoidCallback onPlayAgain;

  const VictoryMenu({
    Key? key,
    required this.onContinue,
    required this.onPlayAgain,
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
          border: Border.all(color: Colors.yellow, width: 2),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              local.victory,
              style: const TextStyle(
                color: Colors.yellow,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: onContinue,
              child: Text(local.continueText),
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: onPlayAgain,
              child: Text(local.playAgain),
            ),
          ],
        ),
      ),
    );
  }
}
