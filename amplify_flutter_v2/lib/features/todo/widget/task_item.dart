import 'package:ember/features/todo/widget/custom_checkbox.dart';
import 'package:ember/models/Todo.dart';
import 'package:flutter/material.dart';

class TaskItem extends StatelessWidget {
  final Todo todo;
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
                    todo.content!,
                    style: TextStyle(
                      fontSize: 16,
                      decoration: todo.isDone!
                          ? TextDecoration.lineThrough
                          : null,
                      color: todo.isDone! ? Colors.grey[600] : Colors.black87,
                    ),
                  ),
                ),
                customCheckbox(context, todo.isDone!),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
