import 'package:ember/app/theme.dart';
import 'package:flutter/material.dart';

class FutureSection extends StatelessWidget {
  const FutureSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildListItem(
          icon: Icons.groups,
          title: "Team Meeting",
          duration: "1d",
        ),
        const SizedBox(height: 12),
        _buildListItem(
          icon: Icons.assessment,
          title: "Project Review",
          duration: "2d",
        ),
        const SizedBox(height: 12),
        _buildListItem(
          icon: Icons.assignment,
          title: "Task Planning",
          duration: "3d",
        ),
        const SizedBox(height: 12),
        _buildListItem(icon: Icons.event, title: "Client Call", duration: "5d"),
      ],
    );
  }

  Widget _buildListItem({
    required IconData icon,
    required String title,
    required String duration,
  }) {
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
                  duration,
                  style: TextStyle(
                    fontSize: 14,
                    color: lightTheme.colorScheme.primary,
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
}
