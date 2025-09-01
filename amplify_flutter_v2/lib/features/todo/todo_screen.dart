// import 'package:amplify_authenticator/amplify_authenticator.dart';

import 'package:ember/features/todo/screens/today_section.dart';
import 'package:ember/features/todo/screens/tommorow_section.dart';
import 'package:ember/features/todo/widget/add_task_bottom_sheet.dart';
import 'package:ember/models/Todo.dart';

import 'package:flutter/material.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Fixed: Changed from 3 to 2 to match the number of tabs
      child: Scaffold(
        appBar: AppBar(title: Text("Todo"), centerTitle: true),
        //this puts the dialig sheet in front of the app
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () async {
            final newTodo = await showModalBottomSheet<Todo>(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (context) => AddTaskBottomSheet(
                // onAddTask:
                //     () {}, // optional: can be removed if you refactor the sheet
              ),
            );
            if (!mounted) return;
            if (newTodo != null) {
              // await _refreshTodos();
            }
          },
        ),

        body: Column(
          children: [
            TabBar(
              tabs: [
                Tab(text: "Today"),
                Tab(text: "Tommorow"),
              ],
            ),
            Expanded(
              child: TabBarView(children: [TodaySection(), TommorowSection()]),
            ),
          ],
        ),
      ),
    );
  }
}
