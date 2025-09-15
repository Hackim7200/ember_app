import 'package:ember/features/todo/provider/todo_provider.dart';
import 'package:ember/features/todo/screens/action_screen.dart';

import 'package:ember/features/todo/widget/todo_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TodaySection extends ConsumerWidget {
  const TodaySection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todosAsync = ref.watch(todoNotifierProvider);

    return RefreshIndicator(
      onRefresh: () => ref.read(todoNotifierProvider.notifier).refresh(),
      child: todosAsync.when(
        data: (_) {
          // Watch the derived todayTaskProvider
          final todayTodos = ref.watch(todayTaskProvider);

          if (todayTodos.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.task_alt, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text('No tasks for today', style: TextStyle(fontSize: 18)),
                  Text(
                    'Pull down to refresh',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            itemCount: todayTodos.length,
            itemBuilder: (context, index) {
              final todo = todayTodos[index];
              return TodoCard(
                key: ValueKey(todo.id),
                todo: todo,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ActionScreen(taskName: todo.content, todo: todo),
                    ),
                  );
                },
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              const Text('Failed to load todos'),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () => ref.refresh(todoNotifierProvider),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
