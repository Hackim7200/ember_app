import 'package:flutter/material.dart';
import 'package:ember/app/theme.dart';

class BreakTimeMessage {
  static void showBreakTimeDialog({
    required BuildContext context,
    required String breakType,
    required int breakDuration,
    VoidCallback? onStartBreak,
    VoidCallback? onSkipBreak,
  }) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          contentPadding: const EdgeInsets.all(24),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Break time icon
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: breakType == 'long_break'
                      ? AppColors.pomodoroGreen.withOpacity(0.1)
                      : AppColors.pomodoroRed.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  breakType == 'long_break'
                      ? Icons.coffee_outlined
                      : Icons.pause_circle_outline,
                  size: 40,
                  color: breakType == 'long_break'
                      ? AppColors.pomodoroGreen
                      : AppColors.pomodoroRed,
                ),
              ),
              const SizedBox(height: 24),

              // Title
              Text(
                'Break Time!',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryText,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),

              // Message
              Text(
                'Rest your eyes and take a well-deserved break.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.primaryText.withOpacity(0.7),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),

              // Break duration
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: breakType == 'long_break'
                      ? AppColors.pomodoroGreen.withOpacity(0.1)
                      : AppColors.pomodoroRed.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${breakDuration} minutes',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: breakType == 'long_break'
                        ? AppColors.pomodoroGreen
                        : AppColors.pomodoroRed,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Action buttons
              Row(
                children: [
                  // Skip button
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(dialogContext).pop();
                        onSkipBreak?.call();
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Skip',
                        style: TextStyle(
                          color: AppColors.primaryText.withOpacity(0.6),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Start break button
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(dialogContext).pop();
                        onStartBreak?.call();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: breakType == 'long_break'
                            ? AppColors.pomodoroGreen
                            : AppColors.pomodoroRed,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Start Break',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  // Convenience method for short breaks
  static void showShortBreakDialog({
    required BuildContext context,
    VoidCallback? onStartBreak,
    VoidCallback? onSkipBreak,
  }) {
    showBreakTimeDialog(
      context: context,
      breakType: 'short_break',
      breakDuration: 5,
      onStartBreak: onStartBreak,
      onSkipBreak: onSkipBreak,
    );
  }

  // Convenience method for long breaks
  static void showLongBreakDialog({
    required BuildContext context,
    VoidCallback? onStartBreak,
    VoidCallback? onSkipBreak,
  }) {
    showBreakTimeDialog(
      context: context,
      breakType: 'long_break',
      breakDuration: 15,
      onStartBreak: onStartBreak,
      onSkipBreak: onSkipBreak,
    );
  }
}
