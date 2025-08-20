// lib/pages/counter_page.dart
import 'package:ember/features/event/provider/counter_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class PastSection extends ConsumerWidget {
  const PastSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the counter value
    final counter = ref.watch(counterProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riverpod Counter'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Counter Value:',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              '$counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => ref.read(counterProvider.notifier).decrement(),
                  child: const Icon(Icons.remove),
                ),
                ElevatedButton(
                  onPressed: () => ref.read(counterProvider.notifier).reset(),
                  child: const Icon(Icons.refresh),
                ),
                ElevatedButton(
                  onPressed: () => ref.read(counterProvider.notifier).increment(),
                  child: const Icon(Icons.add),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}