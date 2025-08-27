// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$futureEventsHash() => r'e8827d1779eb793fd7fc02d2086f62402222d8d2';

/// Derived provider: future events
///
/// Copied from [futureEvents].
@ProviderFor(futureEvents)
final futureEventsProvider = AutoDisposeProvider<List<Event>>.internal(
  futureEvents,
  name: r'futureEventsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$futureEventsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FutureEventsRef = AutoDisposeProviderRef<List<Event>>;
String _$eventNotifierHash() => r'2f00a60843a3b1e7840e9d8e2da2e3992c4fec9b';

/// Base provider managing all events
///
/// Copied from [EventNotifier].
@ProviderFor(EventNotifier)
final eventNotifierProvider =
    AutoDisposeAsyncNotifierProvider<EventNotifier, List<Event>>.internal(
      EventNotifier.new,
      name: r'eventNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$eventNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$EventNotifier = AutoDisposeAsyncNotifier<List<Event>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
