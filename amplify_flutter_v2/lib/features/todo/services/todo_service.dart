import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:ember/models/ModelProvider.dart';
import 'package:ember/models/Todo.dart';

class TodoService {
  // Get single todo by ID
  static Future<Todo?> getById(String todoId) async {
    try {
      final request = ModelQueries.get(
        Todo.classType,
        TodoModelIdentifier(id: todoId),
      );

      final response = await Amplify.API.query(request: request).response;
      return response.data;
    } on ApiException catch (e) {
      safePrint('Get todo failed: $e');
      return null;
    }
  }

  // List all todos
  static Future<List<Todo>> getAll() async {
    try {
      final request = ModelQueries.list(Todo.classType);
      final response = await Amplify.API.query(request: request).response;

      return response.data?.items.whereType<Todo>().toList() ?? [];
    } on ApiException catch (e) {
      safePrint('List todos failed: $e');
      return [];
    }
  }

  // Create new todo
  static Future<Todo?> create(Todo todo) async {
    try {
      final request = ModelMutations.create(todo);
      final response = await Amplify.API.mutate(request: request).response;

      return response.data;
    } on ApiException catch (e) {
      safePrint('Create todo failed: $e');
      // Instead of returning null, throw the exception so the provider can handle it
      rethrow;
    }
  }

  // Update todo
  static Future<Todo?> update(Todo todo) async {
    try {
      final request = ModelMutations.update(todo);
      final response = await Amplify.API.mutate(request: request).response;

      return response.data;
    } on ApiException catch (e) {
      safePrint('Update todo failed: $e');
      return null;
    }
  }
  // Update todo

  // Delete todo
  static Future<bool> delete(Todo todo) async {
    try {
      final request = ModelMutations.delete(todo);
      final response = await Amplify.API.mutate(request: request).response;

      return response.data != null;
    } on ApiException catch (e) {
      safePrint('Delete todo failed: $e');
      return false;
    }
  }

  // Update todo
  static Future<Todo?> addBreakdownItem(
    Todo existingTodo,
    BreakdownItem breakdownItem,
  ) async {
    try {
      // Get current breakdown items or empty list
      final currentBreakdown = existingTodo.breakdown ?? <BreakdownItem>[];

      final updatedBreakdown = [...currentBreakdown, breakdownItem];

      // Create updated todo
      final updatedTodo = existingTodo.copyWith(breakdown: updatedBreakdown);
      // Takes the existingTodo object
      // Creates a completely new Todo instance
      // Copies all existing field values from existingTodo
      // Overwrites only the breakdown field with updatedBreakdown
      // Keeps everything else identical (content, isDone, pomodoros, date, id, etc.)


 
    // Update in database
 
      final request = ModelMutations.update(updatedTodo);
      final response = await Amplify.API.mutate(request: request).response;



      return response.data;
    } on ApiException catch (e) {
      safePrint('Update todo failed: $e');
      return null;
    }
  }
}
