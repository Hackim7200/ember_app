import 'package:ember/features/todo/model/task.dart';
import 'package:ember/features/todo/widget/custom_checkbox.dart';
import 'package:flutter/material.dart';

class TaskItem extends StatelessWidget {
  final Task todo;
  final VoidCallback onTap;

  const TaskItem({super.key, required this.todo, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        elevation: 2,
        shadowColor: Colors.grey.withAlpha(26),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    todo.title,
                    style: TextStyle(
                      fontSize: 16,
                      decoration: todo.isCompleted
                          ? TextDecoration.lineThrough
                          : null,
                      color: todo.isCompleted
                          ? Colors.grey[600]
                          : Colors.black87,
                    ),
                  ),
                ),
                customCheckbox(context, todo.isCompleted),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
