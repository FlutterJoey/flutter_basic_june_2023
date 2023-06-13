import 'package:flutter/material.dart';

class StoryEventCard extends StatelessWidget {
  const StoryEventCard({
    required this.name,
    required this.icon,
    required this.onPressed,
    super.key,
  });

  final String name;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: Colors.black54,
        ),
        color: const Color(0xFFD4E3FF),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(icon),
          ),
          Expanded(
            child: Text(name),
          ),
          IconButton.filledTonal(
            onPressed: onPressed,
            icon: const Icon(Icons.chevron_right_rounded),
          ),
        ],
      ),
    );
  }
}
