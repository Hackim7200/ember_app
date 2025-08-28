import 'package:amplify_flutter/amplify_flutter.dart';

import 'package:ember/features/event/services/event_service.dart'
    show EventService;

import 'package:ember/features/event/widget/event_card.dart';
import 'package:ember/models/ModelProvider.dart';
import 'package:flutter/material.dart';

class PastSection extends StatefulWidget {
  const PastSection({super.key});

  @override
  State<PastSection> createState() => _PastSectionState();
}

class _PastSectionState extends State<PastSection> {
  List<Event> _futureEvents = [];
  bool _isDisposed = false;

  Future<void> _refreshEvent() async {
    try {
      final List<Event?> events = await EventService.getAllPastEvents();

      if (!_isDisposed && mounted) {
        setState(() {
          _futureEvents = events.whereType<Event>().toList();
        });
      }
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
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount:
          _futureEvents.length, // Number of items to display in the list.
      // Builds each item in the list dynamically based on the index.
      itemBuilder: (BuildContext context, int index) {
        return EventCard(event: _futureEvents[index]);
      },
    );
  }
}
