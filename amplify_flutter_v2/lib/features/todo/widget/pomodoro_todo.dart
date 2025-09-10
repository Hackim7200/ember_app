import 'package:ember/features/todo/widget/progress_tomato.dart';
import 'package:flutter/material.dart';

class PomodoroTodo extends StatelessWidget {
  final String title;

  final int currentProgress;
  final int totalProgress;
  final VoidCallback onTap;

  const PomodoroTodo({
    super.key,
    required this.title,

    required this.currentProgress,
    required this.totalProgress,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final double percentage = totalProgress > 0
        ? currentProgress / totalProgress
        : 0.0;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        child: Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          elevation: 2,
          shadowColor: Colors.grey.withAlpha(26),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ProgressTomato(percentage: percentage),
                const SizedBox(width: 12),
                // Task title
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      decoration: percentage >= 1.0
                          ? TextDecoration.lineThrough
                          : null,
                      fontSize: 16,
                      color: percentage >= 1.0
                          ? Colors.grey[600]
                          : Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
