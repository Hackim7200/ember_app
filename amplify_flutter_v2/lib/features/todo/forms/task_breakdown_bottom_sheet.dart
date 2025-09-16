import 'package:ember/features/todo/provider/todo_provider.dart';
import 'package:ember/models/BreakdownItem.dart';
import 'package:ember/models/Todo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TaskBreakdownBottomSheet extends ConsumerStatefulWidget {
  final String taskName;
  final Todo todo;

  const TaskBreakdownBottomSheet({
    super.key,
    required this.taskName,
    required this.todo,
  });

  @override
  ConsumerState<TaskBreakdownBottomSheet> createState() =>
      _TaskBreakdownBottomSheetState();
}

class _TaskBreakdownBottomSheetState
    extends ConsumerState<TaskBreakdownBottomSheet> {
  final _breakdownController = TextEditingController();

  @override
  void dispose() {
    _breakdownController.dispose();
    super.dispose();
  }

  void _addBreakdown() async {
    // Validate input
    if (_breakdownController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a breakdown activity'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      final breakdown = _breakdownController.text.trim();
      // You add breakdown as if your changing a variable of the Todo

      final todo = widget.todo.copyWith(
        breakdown: [
          ...widget.todo.breakdown ?? [],
          BreakdownItem(
            activity: breakdown.trim(),
            minutesElapsed: 0,
            type: "pomodoro",
          ),
        ],
      );

      await ref.read(todoNotifierProvider.notifier).updateTodo(todo);

      // await TodoService.update(todo);

      // Close the bottom sheet and show success message
      if (mounted) {
        Navigator.of(context).pop(breakdown);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Breakdown activity added successfully'),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to add breakdown: ${e.toString()}'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Draggable handle
          Container(
            margin: const EdgeInsets.only(top: 12, bottom: 8),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: theme.colorScheme.outline.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Title
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              children: [
                Text(
                  'Add Breakdown',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'for "${widget.taskName}"',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          // Breakdown input
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: TextField(
              controller: _breakdownController,
              maxLines: 4,
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'Describe the breakdown activity...',
                filled: true,
                fillColor: theme.colorScheme.onSurface.withValues(alpha: 0.05),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: theme.colorScheme.primary,
                    width: 2,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
              ),
            ),
          ),

          // Helper text
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              'Break down your task into smaller, actionable steps',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
              ),
              textAlign: TextAlign.center,
            ),
          ),

          // Action buttons
          Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      side: BorderSide(color: theme.colorScheme.primary),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Cancel',
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _addBreakdown,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.primary,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Add Breakdown',
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: theme.colorScheme.onPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Bottom safe area
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }
}
