import 'package:flutter/material.dart';
import 'package:tower_defense_game/core/constants/app_theme.dart';

class GameHUD extends StatelessWidget {
  final int lives;
  final int resources;
  final int wave;
  final double waveTimer;
  final bool isWaveInProgress;
  final VoidCallback onPausePressed;
  final bool isDoubleSpeed;
  final VoidCallback onSpeedToggle;

  const GameHUD({
    Key? key,
    required this.lives,
    required this.resources,
    required this.wave,
    required this.waveTimer,
    required this.isWaveInProgress,
    required this.onPausePressed,
    required this.isDoubleSpeed,
    required this.onSpeedToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 8.0,
      ),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.7),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _GameStatIndicator(
                  icon: Icons.favorite,
                  iconColor: AppTheme.errorColor,
                  value: lives.toString(),
                  label: 'Lives',
                ),
                
                Column(
                  children: [
                    _GameStatIndicator(
                      icon: Icons.waves,
                      iconColor: AppTheme.primaryColor,
                      value: 'Wave $wave',
                      label: '',
                    ),
                    if (!isWaveInProgress && waveTimer > 0)
                      Text(
                        'Next wave in ${waveTimer.toStringAsFixed(1)}s',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                  ],
                ),
                
                _GameStatIndicator(
                  icon: Icons.monetization_on,
                  iconColor: Colors.amber,
                  value: resources.toString(),
                  label: 'Gold',
                ),
                
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        isDoubleSpeed ? Icons.speed : Icons.speed_outlined,
                        color: isDoubleSpeed ? Colors.amber : Colors.white,
                        size: 24,
                      ),
                      onPressed: onSpeedToggle,
                      tooltip: '${isDoubleSpeed ? "Normal" : "Double"} Speed',
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.pause_circle_filled,
                        color: Colors.white,
                        size: 36,
                      ),
                      onPressed: onPausePressed,
                    ),
                  ],
                ),
              ],
            ),
            if (isWaveInProgress)
              const LinearProgressIndicator(
                backgroundColor: Colors.grey,
                valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primaryColor),
              ),
          ],
        ),
      ),
    );
  }
}

class _GameStatIndicator extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String value;
  final String label;

  const _GameStatIndicator({
    Key? key,
    required this.icon,
    required this.iconColor,
    required this.value,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: iconColor,
          size: 24,
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            if (label.isNotEmpty)
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                ),
              ),
          ],
        ),
      ],
    );
  }
}