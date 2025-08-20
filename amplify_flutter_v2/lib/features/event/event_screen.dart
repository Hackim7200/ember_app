// import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:ember/features/event/screens/future_section.dart';
import 'package:ember/features/event/screens/past_section.dart';
import 'package:ember/features/event/widget/add_event_bottom_sheet.dart';
import 'package:ember/models/Event.dart';
import 'package:flutter/material.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({super.key});

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Fixed: Changed from 3 to 2 to match the number of tabs
      child: Scaffold(
        appBar: AppBar(title: Text("Event"), centerTitle: true),


        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () async {
            final newEvent = await showModalBottomSheet<Event>(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (context) => AddEventBottomSheet(
                // onAddTask:
                //     () {}, // optional: can be removed if you refactor the sheet
              ),
            );
            if (!mounted) return;
            if (newEvent != null) {
              // await _refreshTodos();
            }
          },
        ),


        

        body: Column(
          children: [
            TabBar(
              tabs: [
                Tab(text: "Past"),
                Tab(text: "Future"),
              ],
            ),
            Expanded(
              child: TabBarView(children: [PastSection(), FutureSection()]),
            ),
          ],
        ),
      ),
    );
  }
}
