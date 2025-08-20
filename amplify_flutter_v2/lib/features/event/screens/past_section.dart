import 'package:ember/features/event/provicer/counter_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PastSection extends ConsumerStatefulWidget {
  const PastSection({super.key});

  @override
  ConsumerState<PastSection> createState() => _PastSectionState();
}

class _PastSectionState extends ConsumerState<PastSection> {
  @override
  Widget build(BuildContext context) {
    final String value = ref.watch(counterProvider).counter.toString();

    return Column(
      children: [
        Text(value),
        ElevatedButton(
          onPressed: () {
            ref.read(counterProvider.notifier).increment();
          },
          child: const Text('Increment'),
        ),
        ElevatedButton(
          onPressed: () {
            ref.read(counterProvider.notifier).decrement();
          },
          child: const Text('Decrement'),
        ),
      ],
    );
  }
}
