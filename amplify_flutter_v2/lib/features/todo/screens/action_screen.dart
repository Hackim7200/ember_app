import 'dart:async';

import 'package:ember/features/todo/forms/task_breakdown_bottom_sheet.dart';
import 'package:ember/features/todo/provider/todo_provider.dart';
import 'package:ember/features/todo/widget/pomodoro_todo.dart';
import 'package:ember/models/BreakdownItem.dart';
import 'package:ember/models/Todo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ActionScreen extends ConsumerStatefulWidget {
  final Todo todo;

  const ActionScreen({super.key, required this.todo});

  @override
  ConsumerState<ActionScreen> createState() => _ActionScreenState();
}

class _ActionScreenState extends ConsumerState<ActionScreen> {
  int? selectedIndex;
  Timer? _timer;
  Duration remainingTime = Duration.zero;
  bool isRunning = false;
  static const Duration pomodoroDuration = Duration(minutes: 25);

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _toggleTimer({required int index, required List<BreakdownItem> tasks}) {
    if (isRunning && selectedIndex == index) {
      // Pause the timer
      _pauseTimer();
    } else {
      // Start or resume the timer
      _startTimer(index: index, tasks: tasks);
    }
  }

  void _startTimer({required int index, required List<BreakdownItem> tasks}) {
    _timer?.cancel();

    setState(() {
      selectedIndex = index;
      isRunning = true;
      // Use the current remainingTime if we're resuming the same task
      // Otherwise, calculate from the breakdown item's minutesElapsed
      if (selectedIndex == index && remainingTime > Duration.zero) {
        // We're resuming the same task, keep the current remainingTime
      } else {
        final int minutesElapsed = tasks[index].minutesElapsed;
        if (minutesElapsed < pomodoroDuration.inMinutes) {
          remainingTime = Duration(
            minutes: pomodoroDuration.inMinutes - minutesElapsed,
          );
        } else {
          remainingTime = Duration.zero;
        }
      }
    });

    if (remainingTime.inSeconds <= 0) {
      setState(() {
        isRunning = false;
      });
      return;
    }

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }

      setState(() {
        if (remainingTime.inSeconds > 0) {
          remainingTime = remainingTime - const Duration(seconds: 1);
          final int minutesElapsed =
              pomodoroDuration.inMinutes - remainingTime.inMinutes;
          _updateTaskTimeElapsed(index, minutesElapsed);

          if (minutesElapsed % 2 == 0) {}
        }
        if (remainingTime.inSeconds == 0) {
          timer.cancel();
          isRunning = false;
        }
      });
    });
  }

  void _pauseTimer() {
    _timer?.cancel();
    setState(() {
      isRunning = false;
    });
  }

  void _updateTaskTimeElapsed(int index, int minutesElapsed) {
    final todosAsync = ref.read(todoNotifierProvider);
    final List<Todo> todos = todosAsync.valueOrNull ?? <Todo>[];
    final int todoIndex = todos.indexWhere((t) => t.id == widget.todo.id);

    if (todoIndex == -1) {
      return;
    }

    final Todo updatedTodo = todos[todoIndex].copyWith(
      breakdown: todos[todoIndex].breakdown?.asMap().entries.map((entry) {
        if (entry.key == index) {
          return entry.value.copyWith(minutesElapsed: minutesElapsed);
        }
        return entry.value;
      }).toList(),
    );
    if (minutesElapsed % 2 == 0) {
      // update db every alternating minute
      ref.read(todoNotifierProvider.notifier).updateTodo(updatedTodo);
    }
  }

  void _onFocus(int index, List<BreakdownItem> tasks) {
    if (selectedIndex != index) {
      _timer?.cancel();
      setState(() {
        selectedIndex = index;
        isRunning = false;
        final int minutesElapsed = tasks[index].minutesElapsed;
        remainingTime = minutesElapsed < pomodoroDuration.inMinutes
            ? Duration(minutes: pomodoroDuration.inMinutes - minutesElapsed)
            : Duration.zero;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final todosAsync = ref.watch(todoNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Breakdown'), centerTitle: true),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) => TaskBreakdownBottomSheet(
              taskName: widget.todo.content, // Use dynamic task name
              todo: widget.todo,
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.read(todoNotifierProvider.notifier).refresh(),
        child: todosAsync.when(
          data: (todos) {
            final Todo currentTodo = todos.firstWhere(
              (todo) => todo.id == widget.todo.id,
              orElse: () => widget.todo,
            );
            final List<BreakdownItem> tasks =
                currentTodo.breakdown ?? <BreakdownItem>[];

            if (tasks.isEmpty) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.task_alt, size: 64, color: Colors.grey),
                    SizedBox(height: 16),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Text(
                        'Add an action to get started',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Text(
                      'Pull down to refresh',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              );
            }

            return Column(
              children: [
                const SizedBox(height: 16),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),

                    child: ListView.builder(
                      itemCount: tasks.length,
                      itemBuilder: (BuildContext context, int index) {
                        final bool isSelected = selectedIndex == index;

                        // Calculate the current time display
                        final Duration currentTime = isSelected
                            ? pomodoroDuration -
                                  remainingTime // Show remaining time with seconds
                            : Duration(
                                minutes: tasks[index].minutesElapsed,
                              ); // Show elapsed time for non-selected

                        return PomodoroTodo(
                          isSelected: isSelected,
                          title: tasks[index].activity,
                          currentTime: currentTime,
                          maxTime: pomodoroDuration,
                          onfocus: () => _onFocus(index, tasks),
                          type: tasks[index].type,
                          isRunning: isSelected ? isRunning : false,
                          onPlay: () =>
                              _toggleTimer(index: index, tasks: tasks),
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 64, color: Colors.red),
                const SizedBox(height: 16),
                const Text('Failed to load tasks'),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () => ref.refresh(todoNotifierProvider),
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
