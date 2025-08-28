// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$futureEventsHash() => r'c18e7a1f0ea515f991d335c690b7789960289ceb';

/// ===== Derived Providers =====
/// Only upcoming (future) events
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
String _$eventNotifierHash() => r'05b64227e76f0af4abfc99c87d5c2f64ce20db6a';

/// Notifier managing all events with optimistic updates
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
