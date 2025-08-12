// import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:ember/features/todo/widget/add_task_bottom_sheet.dart';
import 'package:ember/features/todo/widget/today_section.dart';
import 'package:ember/features/todo/widget/tommorow_section.dart';
import 'package:flutter/material.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Fixed: Changed from 3 to 2 to match the number of tabs
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (context) => const AddTaskBottomSheet(),
            );
          },
        ),
        appBar: AppBar(title: Text("Todo"), centerTitle: true),
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
