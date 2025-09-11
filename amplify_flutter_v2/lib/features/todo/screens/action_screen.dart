import 'dart:async';

import 'package:ember/features/todo/widget/pomodoro_todo.dart';

import 'package:flutter/material.dart';

class ActionScreen extends StatefulWidget {
  const ActionScreen({super.key});

  @override
  State<ActionScreen> createState() => _ActionScreenState();
}

class _ActionScreenState extends State<ActionScreen> {
  int? selectedIndex;
  // Move tasks to be a state variable
  final List<Map<String, dynamic>> tasks = [
    {"title": "Read the book and ", "timeElapsed": 0, "type": "pomodoro"},
    {"title": "Short break", "timeElapsed": 0, "type": "short_break"},
    {"title": "Watch the video", "timeElapsed": 0, "type": "pomodoro"},
    {"title": "Short break", "timeElapsed": 0, "type": "short_break"},
    {"title": "Write the summary", "timeElapsed": 0, "type": "pomodoro"},
    {"title": "Short break", "timeElapsed": 0, "type": "short_break"},
    {"title": "Review the notes", "timeElapsed": 0, "type": "pomodoro"},
    {"title": "Long break", "timeElapsed": 0, "type": "long_break"},
    {"title": "Review the video", "timeElapsed": 0, "type": "pomodoro"},
    {"title": "Long break", "timeElapsed": 0, "type": "long_break"},
    {"title": "Review the book", "timeElapsed": 0, "type": "pomodoro"},
  ];

  Timer? _timer;
  int duration = 25;

  void _startTimer(int index) {
    _timer?.cancel(); // stops the timer

    // Reset the current task's timer if switching to a different task
    if (selectedIndex != null && selectedIndex != index) {
      setState(() {
        tasks[selectedIndex!]['timeElapsed'] = 0;
      });
    }

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      //code runs every second
      if (tasks[index]['timeElapsed'] < duration) {
        //incriments until time is 25
        setState(() {
          tasks[index]['timeElapsed'] = tasks[index]['timeElapsed'] + 1;
        });
      } else {
        if (tasks.length > index) {
          index++;
          setState(() {
            selectedIndex = index;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

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
                bool isSelected = selectedIndex == index;

                return PomodoroTodo(
                  isSelected: isSelected,
                  title: tasks[index]['title'],
                  currentTime: tasks[index]['timeElapsed'],
                  maxTime: 25,
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                    _startTimer(index);
                  },
                  type: tasks[index]['type'],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
