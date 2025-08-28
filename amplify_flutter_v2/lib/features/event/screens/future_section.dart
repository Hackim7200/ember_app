import 'package:ember/features/event/provider/event_provider.dart';
import 'package:ember/features/event/widget/event_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FutureSection extends ConsumerWidget {
  const FutureSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventsAsync = ref.watch(eventNotifierProvider);

    return RefreshIndicator(
      onRefresh: () => ref.read(eventNotifierProvider.notifier).refresh(),
      child: eventsAsync.when(
        // Show events when loaded
        data: (events) {
          // Handle empty state
          if (events.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.event_note, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text('No events yet', style: TextStyle(fontSize: 18)),
                  Text(
                    'Pull down to refresh',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          // Show events list
          return ListView.builder(
            itemCount: events.length,
            itemBuilder: (context, index) {
              return EventCard(
                key: ValueKey(
                  events[index].id,
                ), // Add key for better performance
                event: events[index],
              );
            },
          );
        },

        // Show loading spinner
        loading: () => const Center(child: CircularProgressIndicator()),

        // Show error with retry option
        error: (error, stackTrace) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              const Text('Failed to load events'),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () => ref.refresh(eventNotifierProvider),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
