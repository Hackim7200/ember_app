import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:ember/core/app_icons.dart';
import 'package:ember/features/event/provider/event_provider.dart';
import 'package:ember/models/ModelProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Add this import

class AddEventBottomSheet extends ConsumerStatefulWidget {
  const AddEventBottomSheet({super.key});

  @override
  ConsumerState<AddEventBottomSheet> createState() =>
      _AddEventBottomSheetState();
}

class _AddEventBottomSheetState extends ConsumerState<AddEventBottomSheet> {
  final _eventNameController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  int _selectedIcon = 0;
  bool _isLoading = false;

  @override
  void dispose() {
    _eventNameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      // Allow 1 year in the past
      lastDate: DateTime.now().add(const Duration(days: 365)),

      // Allow 1 year in the future
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  Future<void> onAddEvent() async {
    // Validate input
    if (_eventNameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter an event name')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Combine date and time into a single DateTime
      final eventDateTime = DateTime(
        _selectedDate.year,
        _selectedDate.month,
        _selectedDate.day,
        _selectedTime.hour,
        _selectedTime.minute,
      );

      // Create the event with proper field mapping
      final newEvent = Event(
        title: _eventNameController.text.trim(),
        // description: _descriptionController.text.trim().isNotEmpty
        //     ? _descriptionController.text.trim()
        //     : null, // Add description if provided
        date: TemporalDateTime(eventDateTime),
        icon: _selectedIcon,
      );

      // Use the provider to add the event
      await ref.read(eventNotifierProvider.notifier).addEvent(newEvent);

      // If we get here, the event was added successfully
      if (mounted) {
        Navigator.of(context).pop(newEvent); // Return the created event
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Event created successfully')),
        );
      }
    } catch (e) {
      safePrint('Error creating event: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to create event: ${e.toString()}'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  bool get _isToday {
    final now = DateTime.now();
    return _selectedDate.year == now.year &&
        _selectedDate.month == now.month &&
        _selectedDate.day == now.day;
  }

  bool get _isCurrentTime {
    final now = TimeOfDay.now();
    return _selectedTime.hour == now.hour && _selectedTime.minute == now.minute;
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
            child: Text(
              'New event',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
            ),
          ),

          // Event name input
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: TextField(
              controller: _eventNameController,
              decoration: InputDecoration(
                hintText: 'Event name',
                filled: true,
                fillColor: theme.colorScheme.onSurface.withValues(alpha: 0.05),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
              ),
            ),
          ),

          // Description input
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: TextField(
              controller: _descriptionController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Description (optional)',
                filled: true,
                fillColor: theme.colorScheme.onSurface.withValues(alpha: 0.05),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
              ),
            ),
          ),

          // Date input
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: InkWell(
              onTap: () => _selectDate(context),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                      size: 20,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      _isToday
                          ? 'Today'
                          : '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                      style: TextStyle(
                        color: _isToday
                            ? theme.colorScheme.onSurface.withValues(alpha: 0.5)
                            : theme.colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Time input
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: InkWell(
              onTap: () => _selectTime(context),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                      size: 20,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      _isCurrentTime
                          ? 'Select time'
                          : _selectedTime.format(context),
                      style: TextStyle(
                        color: _isCurrentTime
                            ? theme.colorScheme.onSurface.withValues(alpha: 0.5)
                            : theme.colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Icon selection section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Icon',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 150,
                  child: GridView.builder(
                    shrinkWrap: true,

                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 1.2,
                        ),
                    itemCount: AppIcons.all.length,
                    itemBuilder: (BuildContext context, int index) {
                      final IconData iconData = AppIcons.all[index];
                      final bool isSelected = _selectedIcon == index;

                      return InkWell(
                        onTap: () {
                          setState(() {
                            _selectedIcon = index;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: isSelected
                                ? theme.colorScheme.primary.withValues(
                                    alpha: 0.1,
                                  )
                                : theme.colorScheme.onSurface.withValues(
                                    alpha: 0.05,
                                  ),
                            borderRadius: BorderRadius.circular(12),
                            border: isSelected
                                ? Border.all(
                                    color: theme.colorScheme.primary,
                                    width: 2,
                                  )
                                : null,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                iconData,
                                size: 28,
                                color: isSelected
                                    ? theme.colorScheme.primary
                                    : theme.colorScheme.onSurface,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          // Action buttons
          Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: _isLoading
                        ? null
                        : () => Navigator.of(context).pop(),
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
                    onPressed: _isLoading ? null : onAddEvent,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.primary,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: _isLoading
                        ? SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                theme.colorScheme.onPrimary,
                              ),
                            ),
                          )
                        : Text(
                            'Create Event',
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
