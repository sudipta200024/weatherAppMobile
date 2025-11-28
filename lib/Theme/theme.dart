import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  brightness: Brightness.light,
  useMaterial3: true,
  primaryColor: const Color(0xFF4A7BFF),
  scaffoldBackgroundColor: Colors.transparent,

  colorScheme: ColorScheme.light(
    primary: Color(0xFF4A7BFF),
    secondary: Color(0xFF6B9AFF),
    background: Color(0x99E3F2FD),
    surface: Color(0xFFF8FDFF),
    onPrimary: Colors.white,
    onBackground: Color(0xFF0F172A),
    onSurface: Color(0xFF1A1A2E),
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white.withOpacity(0.78),
    hintStyle: const TextStyle(color: Colors.black38, fontSize: 17),
    prefixIconColor: const Color(0xFF4A7BFF),
    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),

    // All borders: NO visible outline by default
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide.none,
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide.none,
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide.none,
    ),
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF4A7BFF),
      foregroundColor: Colors.white,
      elevation: 12,
      shadowColor: const Color(0xFF4A7BFF).withOpacity(0.4),
      padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 18),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
    ),
  ),

  cardTheme: CardThemeData(
    color: Colors.white.withOpacity(0.92),
    elevation: 0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
  ),
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  useMaterial3: true,
  primaryColor: const Color(0xFF8B7AFF),
  scaffoldBackgroundColor: Colors.transparent,

  colorScheme: const ColorScheme.dark(
    primary: Color(0xFF8B7AFF),
    secondary: Color(0xFFA395FF),
    background: Color(0xB31E1B4B),
    surface: Color(0xFF1E1B4B),
    onPrimary: Colors.white,
    onBackground: Colors.white,
    onSurface: Colors.white70,
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white.withOpacity(0.11),
    hintStyle: const TextStyle(color: Colors.white70, fontSize: 17),
    prefixIconColor: const Color(0xFFA395FF),
    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),

    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide.none,
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide.none,
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide.none,
    ),
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF8B7AFF),
      foregroundColor: Colors.white,
      elevation: 12,
      shadowColor: const Color(0xFF8B7AFF).withOpacity(0.5),
      padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 18),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
    ),
  ),

  cardTheme: CardThemeData(
    color: Colors.white.withOpacity(0.10),
    elevation: 0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
  ),
);