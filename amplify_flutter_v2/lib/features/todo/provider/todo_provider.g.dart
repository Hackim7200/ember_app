// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$todoNotifierHash() => r'1e7986f99da2a8f341da7d4405a7a121746547ac';

/// Notifier provider for managing todo state
/// Can mutate the state and handle CRUD operations
///
/// Copied from [TodoNotifier].
@ProviderFor(TodoNotifier)
final todoNotifierProvider =
    AutoDisposeAsyncNotifierProvider<TodoNotifier, List<Todo>>.internal(
      TodoNotifier.new,
      name: r'todoNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$todoNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$TodoNotifier = AutoDisposeAsyncNotifier<List<Todo>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
