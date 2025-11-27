import 'package:flutter/material.dart';

class first_launcher_widget extends StatefulWidget {
  const first_launcher_widget({
    super.key,
    required AnimationController pulseController,
    required this.cs,
  }) : _pulseController = pulseController;

  final AnimationController _pulseController;
  final ColorScheme cs;

  @override
  State<first_launcher_widget> createState() => _first_launcher_widgetState();
}

class _first_launcher_widgetState extends State<first_launcher_widget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RotationTransition(
            turns: widget._pulseController,
            child: Icon(
              Icons.location_searching,
              size: 80,
              color: widget.cs.primary.withOpacity(0.6),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "Finding your location...",
            style: TextStyle(
              fontSize: 20,
              color: widget.cs.onBackground.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }
}