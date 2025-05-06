import 'package:flutter/material.dart';
import 'package:tower_defense_game/core/constants/app_theme.dart';

/// Custom button widget for the game menu screens.
/// Provides consistent styling for menu navigation.
class MenuButton extends StatelessWidget {
  /// The text displayed on the button
  final String text;
  
  /// Callback function executed when the button is pressed
  final VoidCallback onPressed;
  
  /// Optional icon to display alongside text
  final IconData? icon;
  
  /// Creates a menu button with consistent styling.
  const MenuButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: AppTheme.primaryColor,
        minimumSize: const Size(240, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 3,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 24),
            const SizedBox(width: 8),
          ],
          Text(
            text,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}