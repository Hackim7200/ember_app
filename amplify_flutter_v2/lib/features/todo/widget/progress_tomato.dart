import 'package:ember/app/theme.dart';
import 'package:flutter/material.dart';

class ProgressTomato extends StatelessWidget {
  final double percentage;
  final VoidCallback onTap;
  final bool isRunning;

  const ProgressTomato({
    super.key,
    required this.percentage,
    required this.onTap,
    required this.isRunning,
  });

  @override
  Widget build(BuildContext context) {
    if (percentage >= 1.0) {
      // Completed: show green check
      return GestureDetector(
        onTap: onTap,
        child: Container(
          width: 24,
          height: 24,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.pomodoroGreen,
          ),
          child: const Center(
            child: Icon(Icons.check, color: Colors.white, size: 16),
          ),
        ),
      );
    }
    if (percentage == 0) {
      // Not started: show red play
      return GestureDetector(
        onTap: onTap,
        child: Container(
          width: 24,
          height: 24,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.pomodoroRed,
          ),
          child: const Center(
            child: Icon(Icons.play_arrow, color: Colors.white, size: 16),
          ),
        ),
      );
    }
    // In progress: show progress indicator with play/pause icon
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 24,
        height: 24,
        child: Stack(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey[300]!, width: 2),
              ),
            ),
            SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                value: percentage,
                strokeWidth: 2,
                backgroundColor: Colors.transparent,
                valueColor: const AlwaysStoppedAnimation<Color>(
                  AppColors.pomodoroRed,
                ),
              ),
            ),
            // Add play/pause icon overlay
            Center(
              child: Icon(
                isRunning ? Icons.pause : Icons.play_arrow,
                color: AppColors.pomodoroRed,
                size: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
