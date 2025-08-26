import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:ember/models/Event.dart';


class EventService {
  
  // Get single event by ID
  static Future<Event?> getById(String eventId) async {
    try {
      final request = ModelQueries.get(
        Event.classType, 
        EventModelIdentifier(id: eventId)
      );
      
      final response = await Amplify.API.query(request: request).response;
      return response.data;
      
    } on ApiException catch (e) {
      safePrint('Get event failed: $e');
      return null;
    }
  }


  // List all past events (events with date before now) using predicate
  static Future<List<Event>> getAllPastEvents() async {
    try {
      final DateTime now = DateTime.now().toUtc();
      final request = ModelQueries.list(
        Event.classType,
        where: Event.DATE.lt(now.toIso8601String()),
      );
      final response = await Amplify.API.query(request: request).response;
      return response.data?.items.whereType<Event>().toList() ?? [];
    } on ApiException catch (e) {
      safePrint('List past events failed: $e');
      return [];
    }
  }

  // List all events
  static Future<List<Event>> getAll() async {
    try {
      final request = ModelQueries.list(Event.classType);
      final response = await Amplify.API.query(request: request).response;
      
      return response.data?.items.whereType<Event>().toList() ?? [];
      
    } on ApiException catch (e) {
      safePrint('List events failed: $e');
      return [];
    }
  }

  // // Create new event
  // static Future<Event?> create({
  //   required String title,
  //   String? description,
  // }) async {
  //   try {
  //     final event = Event(
  //       icon: 'icon',
  //       title: title,
  //       date: DateTime.now(),
  //     );
      
  //     final request = ModelMutations.create(event);
  //     final response = await Amplify.API.mutate(request: request).response;
      
  //     return response.data;
      
  //   } on ApiException catch (e) {
  //     safePrint('Create event failed: $e');
  //     return null;
  //   }
  // }

  // Update event
  static Future<Event?> update(Event event) async {
    try {
      final request = ModelMutations.update(event);
      final response = await Amplify.API.mutate(request: request).response;
      
      return response.data;
      
    } on ApiException catch (e) {
      safePrint('Update event failed: $e');
      return null;
    }
  }

  // Delete event
  static Future<bool> delete(Event event) async {
    try {
      final request = ModelMutations.delete(event);
      final response = await Amplify.API.mutate(request: request).response;
      
      return response.data != null;
      
    } on ApiException catch (e) {
      safePrint('Delete event failed: $e');
      return false;
    }
  }
}