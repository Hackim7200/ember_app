import 'package:ember/features/todo/widget/pomodoro_timer.dart';
import 'package:ember/features/todo/widget/task_breakdown.dart';
import 'package:flutter/material.dart';

class ActionScreen extends StatelessWidget {
  const ActionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [PomodoroTimer(), TaskBreakdown()]);
  }
}
