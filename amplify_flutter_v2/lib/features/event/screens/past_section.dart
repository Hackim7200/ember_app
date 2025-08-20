import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:ember/core/app_icons.dart';
import 'package:ember/features/event/widget/event_card.dart';
import 'package:ember/models/ModelProvider.dart';
import 'package:flutter/material.dart';

class PastSection extends StatefulWidget {
  const PastSection({super.key});

  @override
  State<PastSection> createState() => _PastSectionState();
}

class _PastSectionState extends State<PastSection> {
  @override
  Widget build(BuildContext context) {
    final List<Event> futureEvents = [
      Event(
        title: 'Team Meeting',
        icon: 0, // calendar_today
        date: TemporalDateTime(DateTime.now().add(const Duration(days: 2))),
      ),
      Event(
        title: 'Doctor Appointment',
        icon: 13, // health_and_safety
        date: TemporalDateTime(
          DateTime.now().add(const Duration(days: 5, hours: 3)),
        ),
      ),
      Event(
        title: 'Birthday Party',
        icon: 7, // cake
        date: TemporalDateTime(
          DateTime.now().add(const Duration(days: 10, hours: 18)),
        ),
      ),
      Event(
        title: 'Flight to NYC',
        icon: 9, // flight_takeoff
        date: TemporalDateTime(
          DateTime.now().add(const Duration(days: 15, hours: 6)),
        ),
      ),
      Event(
        title: 'Project Deadline',
        icon: 18, // check_circle
        date: TemporalDateTime(DateTime.now().add(const Duration(days: 20))),
      ),
    ];

    // final DateTime dateTime = ;
    return ListView.builder(
      itemCount: futureEvents.length, // Number of items to display in the list.
      // Builds each item in the list dynamically based on the index.
      itemBuilder: (BuildContext context, int index) {
        return EventCard(
          icon: AppIcons.all[futureEvents[index].icon],
          title: futureEvents[index].title,
          dateTime: futureEvents[index].date.getDateTimeInUtc().toLocal(),
        );
      },
    );
  }
}
