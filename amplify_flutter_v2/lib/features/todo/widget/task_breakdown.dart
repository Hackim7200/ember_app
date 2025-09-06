import 'package:flutter/material.dart';

class TaskBreakdown extends StatelessWidget {
  const TaskBreakdown({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> tasks = [
      {"title": "Read the book and take notes", "isCompleted": true},
      {"title": "Watch the video", "isCompleted": false},
      {"title": "Write the summary", "isCompleted": false},
      {"title": "Review the notes", "isCompleted": true},
      {"title": "Review the video", "isCompleted": false},
      {"title": "Review the book", "isCompleted": true},
    ];

    return Expanded(
      child: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: const EdgeInsets.only(bottom: 8),
            child: Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              elevation: 2,
              shadowColor: Colors.grey.withAlpha(26),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        tasks[index]['title'].toString(),
                        style: TextStyle(
                          decoration: tasks[index]['isCompleted'] == true
                              ? TextDecoration.lineThrough
                              : null,
                          fontSize: 16,
                          color: tasks[index]['isCompleted'] == true
                              ? Colors.grey[600]
                              : Colors.black87,
                        ),
                      ),
                    ),
                    if (tasks[index]['isCompleted'] == true)
                      const Icon(Icons.check, color: Colors.green),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
