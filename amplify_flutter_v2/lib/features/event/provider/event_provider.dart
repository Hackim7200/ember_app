import 'package:ember/features/event/services/event_service.dart';
import 'package:ember/models/Event.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'event_provider.g.dart';

/// Base provider managing all events
@riverpod
class EventNotifier extends _$EventNotifier {
  @override
  Future<List<Event>> build() async {
    return EventService.getAll();
  }

  /// Refresh the event list
  Future<void> refresh() async {
    final events = await EventService.getAll();
    state = AsyncValue.data(events);
  }

  /// Add a new event
  void addEvent(Event event) {
    final currentEvents = state.valueOrNull ?? [];
    state = AsyncValue.data([...currentEvents, event]);
  }

  /// Update an existing event
  void updateEvent(Event event) {
    final currentEvents = state.valueOrNull ?? [];
    final index = currentEvents.indexWhere((e) => e.id == event.id);
    if (index != -1) {
      final updatedEvents = List<Event>.from(currentEvents);
      updatedEvents[index] = event;
      state = AsyncValue.data(updatedEvents);
    }
  }

  /// Remove an event
  void removeEvent(String eventId) {
    final currentEvents = state.valueOrNull ?? [];
    final filteredEvents = currentEvents.where((e) => e.id != eventId).toList();
    state = AsyncValue.data(filteredEvents);
  }

  /// Clear all events
  void clear() {
    state = AsyncValue.data([]);
  }
}

/// Derived provider: future events
@riverpod
List<Event> futureEvents(Ref ref) {
  final eventsAsync = ref.watch(eventNotifierProvider);
  final now = DateTime.now();

  return eventsAsync.valueOrNull
          ?.where((event) => event.date.getDateTimeInUtc().isAfter(now))
          .toList() ??
      [];
}
