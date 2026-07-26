import 'package:flutter/material.dart';

class AppThemes {
  static final LinearGradient gradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF8046D5), Color(0xFF7EA6FD), Color(0xFF7E9BF9)],
  );

  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: const Color(0xFFEAEAEA).withOpacity(0.95),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: Colors.black45,
        textStyle: TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.black87),
      bodySmall: TextStyle(color: Colors.black87),
      bodyMedium: TextStyle(color: Colors.black87),
    ),
    cardColor: Colors.white,

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey[100],
        foregroundColor: Colors.black87,
      ),
    ),
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF161622),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: Colors.white70,
        textStyle: TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white),
      bodySmall: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white),
    ),
    cardColor: Color(0xFF25273D),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF171717),
        foregroundColor: Colors.white,
      ),
    ),
  );
}
