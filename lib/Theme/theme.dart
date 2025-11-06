import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: const Color(0xFFE9F4FF), // very light blue background
  primaryColor: const Color(0xFF0A2540), // deep navy text color
  colorScheme: const ColorScheme.light(
    primary: Color(0xFF0A2540),      // dark navy for main text
    secondary: Color(0xFF74B9FF),    // soft blue accent
    surface: Colors.white,           // white card surfaces
    onPrimary: Color(0xFFE9F4FF),    // background tint
    onSecondary: Color(0xFF0A2540),  // text on accent
    onSurface: Color(0xFF1E2A3A),    // normal readable text
  ),
);
final darkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: const Color(0xFF0A2540), // deep navy background
  primaryColor: Colors.white,
  colorScheme: const ColorScheme.dark(
    primary: Colors.white,           // light text
    secondary: Color(0xFF74B9FF),    // same blue accent
    surface: Color(0xFF1C2B3A),      // card background
    onPrimary: Color(0xFF0A2540),    // dark on light
    onSecondary: Colors.white,       // text on blue accent
    onSurface: Colors.white70,       // readable grayish white text
  ),
);
