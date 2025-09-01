import 'package:amplify_api/amplify_api.dart';
import 'package:ember/features/todo/widget/add_task_bottom_sheet.dart';
import 'package:ember/features/todo/widget/todo_card.dart';

import 'package:ember/models/Todo.dart';
import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

class TodaySection extends StatefulWidget {
  const TodaySection({super.key});

  @override
  State<TodaySection> createState() => _TodaySectionState();
}

class _TodaySectionState extends State<TodaySection> {
  late final List<Todo> dummyTodos;
  List<Todo> _todos = [];

  @override
  void initState() {
    super.initState();
    _initializeDummyData();
    _refreshTodos();
  }

  void _initializeDummyData() {
    dummyTodos = [
      Todo(id: '1', content: 'Morning exercise', isDone: false),
      Todo(id: '2', content: 'Read news', isDone: false),
      Todo(id: '3', content: 'Plan day', isDone: false),
      Todo(id: '4', content: 'Lunch meeting', isDone: false),
      Todo(id: '5', content: 'Review documents', isDone: false),
      Todo(id: '6', content: 'Team standup', isDone: false),
      Todo(id: '7', content: 'Dinner preparation', isDone: false),
      Todo(id: '8', content: 'Evening walk', isDone: false),
      Todo(id: '9', content: 'Plan tomorrow', isDone: false),
    ];
  }

  Future<void> _refreshTodos() async {
    try {
      final request = ModelQueries.list(Todo.classType);
      final response = await Amplify.API.query(request: request).response;

      final todos = response.data?.items;
      if (response.hasErrors) {
        safePrint('errors: ${response.errors}');
        return;
      }

      // Check if widget is still mounted before calling setState
      if (mounted) {
        setState(() {
          _todos = todos!.whereType<Todo>().toList();
        });
      }
    } on ApiException catch (e) {
      safePrint('Query failed: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          final newTodo = await showModalBottomSheet<Todo>(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) => AddTaskBottomSheet(),
          );
          if (!mounted) return;
          if (newTodo != null) {
            await _refreshTodos();
          }
        },
      ),
      body: RefreshIndicator(
        // this provides refresh when pull down
        onRefresh: _refreshTodos,
        child: ReorderableListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: _todos.length,
          onReorder: (oldIndex, newIndex) {
            // Check if widget is still mounted before calling setState
            if (mounted) {
              setState(() {
                if (oldIndex < newIndex) {
                  newIndex -= 1;
                }
                final item = _todos.removeAt(oldIndex);
                _todos.insert(newIndex, item);
              });
            }
          },
          itemBuilder: (context, index) {
            return TodoCard(
              key: ValueKey(_todos[index].id),
              todo: _todos[index],
              onTap: () {
                // Check if widget is still mounted before calling setState
                if (mounted) {
                  setState(() {
                    final currentTodo = _todos[index];
                    final updatedTodo = Todo(
                      id: currentTodo.id,
                      content: currentTodo.content,
                      isDone: !(currentTodo.isDone ?? false),
                      pomodoros: currentTodo.pomodoros,
                    );
                    _todos[index] = updatedTodo;
                  });
                }
              },
            );
          },
        ),
      ),
    );
  }
}
