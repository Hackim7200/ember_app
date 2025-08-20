import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:ember/core/app_icons.dart';
import 'package:ember/features/event/widget/event_card.dart';
import 'package:ember/models/ModelProvider.dart';
import 'package:flutter/material.dart';

class FutureSection extends StatefulWidget {
  const FutureSection({super.key});

  @override
  State<FutureSection> createState() => _FutureSectionState();
}

class _FutureSectionState extends State<FutureSection> {
  List<Event> _futureEvents = [];

  Future<void> _refreshEvent() async {
    try {
      final request = ModelQueries.list(Event.classType);
      final response = await Amplify.API.query(request: request).response;

      final events = response.data?.items;
      if (response.hasErrors) {
        safePrint('errors: ${response.errors}');
        return;
      }
      setState(() {
        _futureEvents = events!.whereType<Event>().toList();
      });
    } on ApiException catch (e) {
      safePrint('Query failed: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _refreshEvent();
  }

  @override
  Widget build(BuildContext context) {
  
    return ListView.builder(
      itemCount:
          _futureEvents.length, // Number of items to display in the list.
      // Builds each item in the list dynamically based on the index.
      itemBuilder: (BuildContext context, int index) {
        return EventCard(
          icon: AppIcons.all[_futureEvents[index].icon],
          title: _futureEvents[index].title,
          dateTime: _futureEvents[index].date.getDateTimeInUtc().toLocal(),
        );
      },
    );
  }
}
