// import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:ember/features/event/widget/add_event_bottom_sheet.dart';
import 'package:ember/features/event/widget/future_section.dart';
import 'package:ember/features/event/widget/past_section.dart';
import 'package:flutter/material.dart';

class EventScreen extends StatelessWidget {
  const EventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Fixed: Changed from 3 to 2 to match the number of tabs
      child: Scaffold(
        appBar: AppBar(title: Text("Event"), centerTitle: true),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (context) => const AddEventBottomSheet(),
            );
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
