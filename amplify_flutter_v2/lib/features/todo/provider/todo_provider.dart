import 'package:ember/features/todo/services/todo_service.dart';
import 'package:ember/models/Todo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

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
    final current = state.valueOrNull ?? [];

    try {
      final saved = await TodoService.create(todo);
      if (saved != null) {
        state = AsyncData([...current, saved]);
      }
    } catch (e) {
      // Keep current state, handle error appropriately
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

  /// Refresh todos from the server
  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(TodoService.getAll);
  }
}
