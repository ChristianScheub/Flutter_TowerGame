import 'package:flutter/material.dart';

class LevelCard extends StatelessWidget {
  final int levelNumber;
  final bool isLocked;
  final bool isCompleted;
  final VoidCallback? onTap;

  const LevelCard({
    Key? key,
    required this.levelNumber,
    required this.isLocked,
    this.isCompleted = false,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isLocked 
              ? Colors.grey.shade800.withOpacity(0.5)
              : Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isLocked 
                ? Colors.grey.shade700
                : isCompleted
                    ? Colors.green.shade300
                    : Colors.white30,
            width: isCompleted ? 2 : 1,
          ),
        ),
        child: Stack(
          children: [
            if (!isLocked)
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white.withOpacity(0.1),
                        Colors.white.withOpacity(0.05),
                      ],
                    ),
                  ),
                ),
              ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    levelNumber.toString(),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: isLocked ? Colors.grey : Colors.white,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Container(
                    width: 24,
                    height: 2,
                    decoration: BoxDecoration(
                      color: isLocked 
                          ? Colors.grey.withOpacity(0.3)
                          : Colors.white.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(1),
                    ),
                  ),
                  if (isCompleted)
                    const Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 16,
                    ),
                ],
              ),
            ),
            if (isLocked)
              Positioned(
                top: 4,
                right: 4,
                child: Icon(
                  Icons.lock,
                  color: Colors.grey.shade400,
                  size: 12,
                ),
              ),
          ],
        ),
      ),
    );
  }
}