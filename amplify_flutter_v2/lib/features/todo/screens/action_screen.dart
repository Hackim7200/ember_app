import 'package:ember/features/todo/widget/pomodoro_todo.dart';

import 'package:flutter/material.dart';

class ActionScreen extends StatefulWidget {
  const ActionScreen({super.key});

  @override
  State<ActionScreen> createState() => _ActionScreenState();
}

class _ActionScreenState extends State<ActionScreen> {
  // Move tasks to be a state variable
  final List<Map<String, dynamic>> tasks = [
    {"title": "Read the book and ", "isCompleted": true, "timeElapsed": 20},
    {"title": "Watch the video", "isCompleted": false, "timeElapsed": 0},
    {"title": "Write the summary", "isCompleted": false, "timeElapsed": 0},
    {"title": "Review the notes", "isCompleted": true, "timeElapsed": 4},
    {"title": "Review the video", "isCompleted": false, "timeElapsed": 14},
    {"title": "Review the book", "isCompleted": true, "timeElapsed": 20},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Action')),
      body: Column(
        children: [
          SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (BuildContext context, int index) {
                return PomodoroTodo(
                  title: tasks[index]['title'],
                  currentProgress: tasks[index]['timeElapsed'],
                  totalProgress: 20,
                  onTap: () {
                    setState(() {
                      print("tapp exectuted");
                      tasks[index]['timeElapsed'] =
                          tasks[index]['timeElapsed'] + 1;
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
