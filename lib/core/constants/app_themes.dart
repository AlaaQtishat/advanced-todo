import 'package:flutter/material.dart';

class AppThemes {
  static final Color primaryPurple = Color(0xFF7F22FE);
  static final Color lightGrey = Colors.grey.shade300;
  static final Color darkGrey = Colors.grey.shade700;
  static final Color highPriorityRed = Color(0xFFFB2C36);
  static final Color mediumPriorityOrange = Color(0xFFFE9A00);
  static final Color lowPriorityBlue = Colors.cyan[700]!;
  static final Color primaryGreen = Color(0xFF009966);
  static final LinearGradient gradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF7F22FE), Color(0xFF615FFF)],
  );

  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Color(0xFFF8FAFC),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: Colors.black45,
        textStyle: TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Color(0xFF1D293D)),
      bodySmall: TextStyle(color: Color(0xFF1D293D)),
      bodyMedium: TextStyle(color: Color(0xFF1D293D)),
    ),
    cardColor: Colors.white,

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey[100],
        foregroundColor: Colors.black87,
      ),
    ),
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(
        foregroundColor: darkGrey,
        backgroundColor: Color(0xFFF1F5F9),
        side: BorderSide(color: Colors.transparent),
      ),
    ),
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF09090B),
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
    cardColor: Color(0xFF18181B),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF171717),
        foregroundColor: Colors.white,
      ),
    ),
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(
        foregroundColor: lightGrey,
        backgroundColor: Color(0xFF1C1C1E),
        side: BorderSide(color: lightGrey),
      ),
    ),
  );
}
