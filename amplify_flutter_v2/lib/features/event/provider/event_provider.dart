import 'package:ember/features/event/services/event_service.dart';
import 'package:ember/models/Event.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'event_provider.g.dart';

// SOLUTION: Add keepAlive to prevent data from being disposed
@Riverpod(keepAlive: true) // This keeps the data alive between tab switches
class EventNotifier extends _$EventNotifier {
  @override
  Future<List<Event>> build() => EventService.getAll();

  // Simple optimistic updates - UI responds instantly

  Future<void> addEvent(Event event) async {
    final current = state.valueOrNull ?? [];

    // Show immediately in UI
    state = AsyncData([...current, event]);

    // Save to server in background
    try {
      final saved = await EventService.create(event);
      // Update with server version
      state = AsyncData([...current, saved!]);
    } catch (e) {
      // Remove from UI if save failed
      state = AsyncData(current);
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
    try {
      final saved = await EventService.update(event);
      updated[index] = saved!;
      state = AsyncData(updated);
    } catch (e) {
      // Revert on error
      state = AsyncData(current);
      rethrow;
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
    state = await AsyncValue.guard(() => EventService.getAll());
  }
}
