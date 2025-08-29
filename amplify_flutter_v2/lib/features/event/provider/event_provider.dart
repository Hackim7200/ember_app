import 'package:ember/features/event/services/event_service.dart';
import 'package:ember/models/Event.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'event_provider.g.dart';

//Notifier providers
//Notifier providers stores the state of the data
//Can mutate the state
//

@riverpod
class EventNotifier extends _$EventNotifier {
  @override
  Future<List<Event>> build() async {
    // Keep data alive
    // ref.keepAlive();

    // Fetch initial data
    return EventService.getAll();
  }

  // Simple optimistic updates - UI responds instantly

  Future<void> addEvent(Event event) async {
    final current = state.valueOrNull ?? [];

    try {
      final saved = await EventService.create(event);
      if (saved != null) {
        state = AsyncData([...current, saved]);
      }
    } catch (e) {
      // Keep current state, handle error appropriately
      rethrow;
    }
  }

  Future<void> updateEvent(Event event) async {
    // Get the current list of events from state, or use empty list if state is null/loading/error
    final current = state.valueOrNull ?? [];

    // Find the position of the event we want to update in the list
    final index = current.indexWhere((e) => e.id == event.id);

    // If event doesn't exist in the list (indexWhere returns -1), exit early
    if (index == -1) return;

    // Update UI immediately
    final updated = [...current];
    updated[index] = event;
    state = AsyncData(updated);

    // Save to server
    final saved = await EventService.update(event);
    if (saved != null) {
      updated[index] = saved;
      state = AsyncData(updated);
    } else {
      state = AsyncData(current); // fallback
    }
  }

  Future<void> removeEvent(Event event) async {
    final current = state.valueOrNull ?? [];

    // Remove from UI immediately
    final filtered = current.where((e) => e.id != event.id).toList();
    state = AsyncData(filtered);

    // Delete from server
    try {
      await EventService.delete(event);
    } catch (e) {
      // Restore if delete failed
      state = AsyncData(current);
      rethrow;
    }
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(EventService.getAll);
  }
}

//Derived providers
//Derived providers are providers that are computed based on the value of other providers.
//They are not stored in the state, but are computed on the fly.
//Cannot mutate — returns a computed value only
//Computes/filter/transforms data from other providers

// Derived provider: future events

final futureEventsProvider = Provider<List<Event>>((ref) {
  final events = ref.watch(eventNotifierProvider).valueOrNull ?? [];
  final now = DateTime.now();
  return events.where((e) => e.date.getDateTimeInUtc().isAfter(now)).toList();
});

// Derived provider: past events

final pastEventsProvider = Provider<List<Event>>((ref) {
  final events = ref.watch(eventNotifierProvider).valueOrNull ?? [];
  final now = DateTime.now();
  return events.where((e) => e.date.getDateTimeInUtc().isBefore(now)).toList();
});
