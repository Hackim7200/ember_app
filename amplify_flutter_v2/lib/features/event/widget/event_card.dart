import 'package:ember/core/app_icons.dart';
import 'package:ember/models/Event.dart';
import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  final Event event;

  const EventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              AppIcons.all[event.icon],
              color: Colors.black87,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _getTimeDifferenceText(),
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getTimeDifferenceText() {
    final DateTime now = DateTime.now();
    final DateTime eventDate = event.date.getDateTimeInUtc().toLocal();
    final Duration difference = eventDate.difference(now);

    final int days = difference.inDays;
    final int hours = difference.inHours % 24;
    final int minutes = difference.inMinutes % 60;

    if (difference.isNegative) {
      if (days.abs() > 1) {
        return '${days.abs()} days ago';
      } else if (days.abs() == 1) {
        return '1 day ${hours.abs()} hours ago';
      } else if (hours.abs() > 0) {
        return '${hours.abs()} hours ${minutes.abs()} minutes ago';
      } else if (minutes.abs() > 0) {
        return '${minutes.abs()} minutes ago';
      } else {
        return 'Less than a minute ago';
      }
    } else {
      if (days > 1) {
        return '$days days';
      } else if (days == 1) {
        return '1 day $hours hours';
      } else if (hours > 0) {
        return '$hours hours $minutes minutes';
      } else if (minutes > 0) {
        return '$minutes minutes';
      } else {
        return 'Less than a minute';
      }
    }
  }
}
