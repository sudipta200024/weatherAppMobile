// weather_detail_tile.dart
import 'package:flutter/material.dart';

class WeatherDetailTile extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color iconColor;

  const WeatherDetailTile({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Column(
      children: [
        Icon(icon, color: iconColor, size: 30),
        const SizedBox(height: 12),
        Text(
          value,
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.bold,
            color: cs.onSurface,
          ),
        ),
        Text(
          label,
          style: TextStyle(fontSize: 14, color: cs.onSurface.withOpacity(0.8)),
        ),
      ],
    );
  }
}