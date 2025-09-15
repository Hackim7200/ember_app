import 'dart:async';

import 'package:ember/features/todo/forms/task_breakdown_bottom_sheet.dart';

import 'package:ember/features/todo/widget/pomodoro_todo.dart';
import 'package:ember/models/BreakdownItem.dart';
import 'package:ember/models/Todo.dart';

import 'package:flutter/material.dart';

class ActionScreen extends StatefulWidget {
  final String taskName;
  final Todo todo;
  const ActionScreen({super.key, required this.taskName, required this.todo});

  @override
  State<ActionScreen> createState() => _ActionScreenState();
}

class _ActionScreenState extends State<ActionScreen> {
  int? selectedIndex;
  // Move tasks to be a state variable
  // final List<Map<String, dynamic>> tasks = [
  //   {"activity": "Read the book and ", "timeElapsed": 0, "type": "pomodoro"},
  //   // {"activity": "Short break", "timeElapsed": 0, "type": "short_break"},
  //   {"activity": "Watch the video", "timeElapsed": 0, "type": "pomodoro"},
  //   // {"activity": "Short break", "timeElapsed": 0, "type": "short_break"},
  //   {"activity": "Write the summary", "timeElapsed": 0, "type": "pomodoro"},
  //   // {"activity": "Short break", "timeElapsed": 0, "type": "short_break"},
  //   {"activity": "Review the notes", "timeElapsed": 0, "type": "pomodoro"},
  //   // {"activity": "Long break", "timeElapsed": 0, "type": "long_break"},
  //   {"activity": "Review the video", "timeElapsed": 0, "type": "pomodoro"},
  //   // {"activity": "Long break", "timeElapsed": 0, "type": "long_break"},
  //   {"activity": "Review the book", "timeElapsed": 0, "type": "pomodoro"},
  // ];
  late List<BreakdownItem> tasks;

  @override
  void initState() {
    super.initState();
    tasks = List<BreakdownItem>.from(
      widget.todo.breakdown ?? <BreakdownItem>[],
    );
  }

  Timer? _timer;
  int duration = 25;

  void _startTimer(int index) {
    _timer?.cancel(); // stops the timer

    // Reset the current task's timer if switching to a different task
    if (selectedIndex != null && selectedIndex != index) {
      setState(() {
        tasks[selectedIndex!] = tasks[selectedIndex!].copyWith(timeElapsed: 0);
        // you cant change the value of AWS model fields directly you have to use copyWith
      });
    }

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      //code runs every second
      if (tasks[index].timeElapsed < duration) {
        //incriments until time is 25
        setState(() {
          tasks[index] = tasks[index].copyWith(
            timeElapsed: tasks[index].timeElapsed + 1,
          );
        });
      } else {
        if (tasks.length > index) {
          index++;
          _timer?.cancel();
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
      appBar: AppBar(title: Text('Action Plan')),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) => TaskBreakdownBottomSheet(
              taskName: "Complete project documentation",
              todo: widget.todo,
              // onBreakdownAdded: (breakdown) {
              //   // Handle the breakdown text here
              //   // e.g., add to your task model, update database, etc.
              //   print("Breakdown added: $breakdown");
              // },
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
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
                  title: tasks[index].activity,
                  currentTime: tasks[index].timeElapsed,
                  maxTime: 25,
                  onfocus: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  type: tasks[index].type,
                  onPlay: () {
                    _startTimer(index);
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
