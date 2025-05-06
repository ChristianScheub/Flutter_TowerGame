import 'package:flutter/material.dart';
import '../../../l10n/gen_l10n/app_localizations.dart';

class PauseDialog extends StatelessWidget {
  final VoidCallback onResume;
  final VoidCallback onQuit;

  const PauseDialog({
    Key? key,
    required this.onResume,
    required this.onQuit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);

    return AlertDialog(
      title: Text(local.pauseTitle),
      content: Text(local.pauseContent),
      actions: [
        TextButton(
          onPressed: onResume,
          child: Text(local.resume),
        ),
        TextButton(
          onPressed: onQuit,
          child: Text(local.quit),
        ),
      ],
    );
  }
}
