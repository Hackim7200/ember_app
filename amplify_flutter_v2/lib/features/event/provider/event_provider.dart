import 'package:ember/features/event/services/event_service.dart';
import 'package:ember/models/Event.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'event_provider.g.dart';

/// Notifier managing all events with optimistic updates
@riverpod
class EventNotifier extends _$EventNotifier {
  @override
  Future<List<Event>> build() => EventService.getAll();

  /// ===== Helpers =====
  void _setState(List<Event> events) => state = AsyncData(events);

  void _rollback(List<Event> previous, Object error, StackTrace st) {
    state = AsyncError(error, st);
    _setState(previous);
  }

  /// ===== Actions =====

  /// Reload all events from server
  Future<void> refresh() async {
    state = const AsyncLoading();
    try {
      _setState(await EventService.getAll());
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  /// Add a new event (optimistic update)
  Future<void> addEvent(Event event) async {
    final previous = state.valueOrNull ?? [];
    _setState([...previous, event]); // optimistic

    try {
      final saved = await EventService.create(event);
      _setState([...previous, saved!]); // sync with server
    } catch (e, st) {
      _rollback(previous, e, st);
    }
  }

  /// Update an event
  Future<void> updateEvent(Event event) async {
    final previous = state.valueOrNull ?? [];
    final index = previous.indexWhere((e) => e.id == event.id);
    if (index == -1) return;

    final optimistic = [...previous]..[index] = event;
    _setState(optimistic);

    try {
      final saved = await EventService.update(event);
      final synced = [...previous]..[index] = saved!;
      _setState(synced);
    } catch (e, st) {
      _rollback(previous, e, st);
    }
  }

  /// Remove an event
  Future<void> removeEvent(Event event) async {
    final previous = state.valueOrNull ?? [];
    _setState(previous.where((e) => e.id != event.id).toList()); // optimistic

    try {
      await EventService.delete(event);
    } catch (e, st) {
      _rollback(previous, e, st);
    }
  }
}

/// ===== Derived Providers =====

/// Only upcoming (future) events
@riverpod
List<Event> futureEvents(Ref ref) {
  final events = ref.watch(eventNotifierProvider.select((s) => s.valueOrNull));
  final now = DateTime.now();
  return events
          ?.where((e) => e.date.getDateTimeInUtc().isAfter(now))
          .toList() ??
      [];
}
