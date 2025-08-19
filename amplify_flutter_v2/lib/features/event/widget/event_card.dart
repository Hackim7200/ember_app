import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final DateTime dateTime;

  const EventCard({
    super.key,
    required this.icon,
    required this.title,
    required this.dateTime,
  });

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
            child: Icon(icon, color: Colors.black87, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
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
    final DateTime eventDate = dateTime;
    final Duration difference = eventDate.difference(now);

    if (difference.isNegative) {
      return 'Event passed';
    }
    final int days = difference.inDays;
    final int hours = difference.inHours % 24;
    final int minutes = difference.inMinutes % 60;

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
