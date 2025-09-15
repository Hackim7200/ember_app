import 'package:ember/features/todo/services/todo_service.dart';
import 'package:ember/models/BreakdownItem.dart';
import 'package:ember/models/Todo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

part 'todo_provider.g.dart';

/// Notifier provider for managing todo state
/// Can mutate the state and handle CRUD operations
@riverpod
class TodoNotifier extends _$TodoNotifier {
  @override
  Future<List<Todo>> build() async {
    // Fetch initial data
    return TodoService.getAll();
  }

  /// Add a new todo with optimistic updates
  Future<void> addTodo(Todo todo) async {
    final List<Todo> current = state.valueOrNull ?? [];

    try {
      final saved = await TodoService.create(todo);
      if (saved != null) {
        state = AsyncData([...current, saved]);
      } else {
        // Handle the case where create returns null
        throw Exception('Failed to create todo: API returned null');
      }
    } catch (e) {
      // Revert to original state and rethrow the error
      state = AsyncData(current);
      rethrow;
    }
  }

  /// Update an existing todo with optimistic updates
  Future<void> updateTodo(Todo todo) async {
    final current = state.valueOrNull ?? [];
    final index = current.indexWhere((e) => e.id == todo.id);

    if (index == -1) return;

    // Update UI immediately (optimistic update)
    final updated = [...current];
    updated[index] = todo;
    state = AsyncData(updated);

    // Save to server
    try {
      final saved = await TodoService.update(todo);
      if (saved != null) {
        updated[index] = saved;
        state = AsyncData(updated);
      } else {
        // Revert to original state if update failed
        state = AsyncData(current);
      }
    } catch (e) {
      // Revert to original state on error
      state = AsyncData(current);
      rethrow;
    }
  }

  /// Remove a todo with optimistic updates
  Future<void> removeTodo(Todo todo) async {
    final current = state.valueOrNull ?? [];

    // Remove from UI immediately (optimistic update)
    final filtered = current.where((e) => e.id != todo.id).toList();
    state = AsyncData(filtered);

    // Delete from server
    try {
      await TodoService.delete(todo);
    } catch (e) {
      // Restore original state if delete failed
      state = AsyncData(current);
      rethrow;
    }
  }

  Future<void> addBreakdownItem(Todo todo) async {
    final current = state.valueOrNull ?? [];
    final index = current.indexWhere((e) => e.id == todo.id);

    if (index == -1) return;

    // Update UI immediately (optimistic update)
    final updated = [...current];
    updated[index] = todo;
    state = AsyncData(updated);

    // Save to server
    try {
      final saved = await TodoService.update(todo);
      if (saved != null) {
        updated[index] = saved;
        state = AsyncData(updated);
      } else {
        // Revert to original state if update failed
        state = AsyncData(current);
      }
    } catch (e) {
      // Revert to original state on error
      state = AsyncData(current);
      rethrow;
    }
  }

  /// Refresh todos from the server
  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(TodoService.getAll);
  }
}

//Derived providers
//Derived providers are providers that are computed based on the value of other providers.
//They are not stored in the state, but are computed on the fly.
//Cannot mutate — returns a computed value only
//Computes/filter/transforms data from other providers

final todayTaskProvider = Provider<List<Todo>>((ref) {
  final List<Todo> todos = ref.watch(todoNotifierProvider).valueOrNull ?? [];

  final DateTime now = DateTime.now();
  final DateTime todayStart = DateTime(now.year, now.month, now.day, 0, 0, 0);
  final DateTime todayEnd = DateTime(now.year, now.month, now.day, 23, 59, 59);

  final List<Todo> todayTodos = todos.where((Todo todo) {
    final TemporalDateTime temporalDate = todo.date;
    final DateTime todoDate = temporalDate.getDateTimeInUtc().toLocal();
    return todoDate.isAfter(todayStart.subtract(const Duration(seconds: 1))) &&
        todoDate.isBefore(todayEnd.add(const Duration(seconds: 1)));
  }).toList();

  safePrint('Today provider - Fil tered todos: ${todayTodos.length}');

  return todayTodos;
});

// Derived provider: tomorrow tasks
final tomorrowTaskProvider = Provider<List<Todo>>((ref) {
  final List<Todo> todos = ref.watch(todoNotifierProvider).valueOrNull ?? [];

  final DateTime now = DateTime.now();
  final DateTime todayEnd = DateTime(now.year, now.month, now.day, 23, 59, 59);
  final DateTime tomorrowEnd = todayEnd.add(const Duration(days: 1));

  final List<Todo> tomorrowTodos = todos.where((Todo todo) {
    final TemporalDateTime temporalDate = todo.date;

    final DateTime todoDate = temporalDate.getDateTimeInUtc().toLocal();
    return todoDate.isAfter(todayEnd) &&
        todoDate.isBefore(tomorrowEnd.add(const Duration(seconds: 1)));
  }).toList();

  safePrint('Tomorrow provider - Filtered todos: ${tomorrowTodos.length}');

  return tomorrowTodos;
});
