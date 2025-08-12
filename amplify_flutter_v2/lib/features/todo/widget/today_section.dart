import 'package:ember/features/todo/model/task.dart';
import 'package:ember/features/todo/widget/task_item.dart';
import 'package:flutter/material.dart';

class TodaySection extends StatefulWidget {
  const TodaySection({super.key});

  @override
  State<TodaySection> createState() => _TodaySectionState();
}

class _TodaySectionState extends State<TodaySection> {
  late final List<Task> dummyDataTasks;

  @override
  void initState() {
    super.initState();
    _initializeTodos();
  }

  void _initializeTodos() {
    dummyDataTasks = [
      Task(title: 'Morning exercise', isCompleted: false),
      Task(title: 'Read news', isCompleted: false),
      Task(title: 'Plan day', isCompleted: false),
      Task(title: 'Lunch meeting', isCompleted: false),
      Task(title: 'Review documents', isCompleted: false),
      Task(title: 'Team standup', isCompleted: false),
      Task(title: 'Dinner preparation', isCompleted: false),
      Task(title: 'Evening walk', isCompleted: false),
      Task(title: 'Plan tomorrow', isCompleted: false),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return ReorderableListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: dummyDataTasks.length,
      onReorder: (oldIndex, newIndex) {
        setState(() {
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }
          final item = dummyDataTasks.removeAt(oldIndex);
          dummyDataTasks.insert(newIndex, item);
        });
      },
      itemBuilder: (context, index) {
        return TaskItem(
          key: ValueKey(dummyDataTasks[index].title),
          todo: dummyDataTasks[index],
          onTap: () => {
            setState(() {
              dummyDataTasks[index].isCompleted =
                  !dummyDataTasks[index].isCompleted;
            }),
          },
        );
      },
    );
  }
}
