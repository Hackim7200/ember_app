import 'package:ember/models/Todo.dart';
import 'package:flutter/material.dart';

class TodoCard extends StatelessWidget {
  final Todo todo;
  final VoidCallback onTap;

  const TodoCard({super.key, required this.todo, required this.onTap});

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
                          Row(
                            children: List.generate(
                              todo.pomodoros ?? 0,
                              (int i) => Padding(
                                padding: const EdgeInsets.only(left: 5.0),
                                child: Container(
                                  width: 18,
                                  height: 18,
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 251, 160, 160),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      // if (todo.breakdown != null && todo.breakdown!.isNotEmpty)
                      //   Padding(
                      //     padding: const EdgeInsets.only(top: 4),
                      //     child: Text(
                      //       todo.breakdown!,
                      //       style: TextStyle(
                      //         fontSize: 13,
                      //         color: Colors.grey[700],
                      //       ),
                      //     ),
                      //   ),
                    ],
                  ),
                ),
                // customCheckbox(context, todo.isDone ?? false),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
