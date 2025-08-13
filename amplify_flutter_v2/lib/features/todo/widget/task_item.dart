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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              todo.content ?? '',
                              style: TextStyle(
                                fontSize: 16,
                                decoration: todo.isDone == true
                                    ? TextDecoration.lineThrough
                                    : null,
                                color: todo.isDone == true
                                    ? Colors.grey[600]
                                    : Colors.black87,
                              ),
                            ),
                          ),
                          if (todo.pomodoros != null && todo.pomodoros! > 0)
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Row(
                                children: [
                                  const Text(
                                    '🍅',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  const SizedBox(width: 2),
                                  Text(
                                    '${todo.pomodoros}',
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.redAccent,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                      if (todo.breakdown != null && todo.breakdown!.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            todo.breakdown!,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[700],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                customCheckbox(context, todo.isDone ?? false),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
