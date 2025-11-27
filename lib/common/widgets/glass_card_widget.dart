import 'dart:ui';

import 'package:flutter/material.dart';

class GlassCard extends StatelessWidget {
  const GlassCard({
    super.key,
    required this.cs,
    required this.child,
  });

  final ColorScheme cs;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(28),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: cs.surface.withOpacity(0.7),
            borderRadius: BorderRadius.circular(28),
            border: Border.all(color: cs.outline.withOpacity(0.2)),
          ),
          child: child,
        ),
      ),
    );
  }
}