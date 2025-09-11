import 'package:ember/app/theme.dart';
import 'package:ember/features/todo/widget/progress_tomato.dart';
import 'package:flutter/material.dart';

class PomodoroTodo extends StatelessWidget {
  final String title;

  final int currentTime;
  final int maxTime;
  final VoidCallback onfocus;
  final VoidCallback onPlay;
  final bool isSelected;
  final String type;

  const PomodoroTodo({
    super.key,
    required this.title,
    required this.currentTime,
    required this.maxTime,
    required this.onfocus,
    required this.isSelected,
    required this.type,
    required this.onPlay,
  });

  @override
  Widget build(BuildContext context) {
    final double percentage = maxTime > 0 ? currentTime / maxTime : 0.0;

    return GestureDetector(
      onTap: onfocus,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? AppColors.pomodoroRed : Colors.transparent,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Material(
          color: type == "pomodoro"
              ? Colors.white
              : type == "long_break"
              ? const Color.fromARGB(255, 50, 255, 211)
              : const Color.fromARGB(255, 206, 255, 181),
          borderRadius: BorderRadius.circular(12),
          elevation: 2,
          shadowColor: Colors.grey.withAlpha(26),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ProgressTomato(percentage: percentage, onTap: onPlay),
                const SizedBox(width: 12),
                // Task title
                Expanded(
                  child: Row(
                    children: [
                      Text(
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
                      const SizedBox(width: 12),
                      Text(
                        "25 min",
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                    ],
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
