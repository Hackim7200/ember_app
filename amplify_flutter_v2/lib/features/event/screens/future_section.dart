import 'package:ember/features/event/provider/event_provider.dart';

import 'package:ember/features/event/widget/event_card.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FutureSection extends ConsumerStatefulWidget {
  const FutureSection({super.key});

  @override
  ConsumerState<FutureSection> createState() => _FutureSectionState();
}

class _FutureSectionState extends ConsumerState<FutureSection> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final events = ref.watch(futureEventsProvider);

    return RefreshIndicator(
      onRefresh: () => ref.read(eventNotifierProvider.notifier).refresh(),
      child: ListView.builder(
        itemCount: events.length,
        itemBuilder: (_, index) => EventCard(event: events[index]),
      ),
    );
  }
}
