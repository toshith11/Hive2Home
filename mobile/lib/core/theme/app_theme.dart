import 'package:flutter/material.dart';

class AppTheme {
  static const Color honeyGold = Color(0xFFD99A00);
  static const Color darkBrown = Color(0xFF3B2A16);
  static const Color warmCream = Color(0xFFFFFAF0);
  static const Color lightHoney = Color(0xFFFFF3D2);
  static const Color verifiedGreen = Color(0xFF2E7D32);
  static const Color secondaryBrown = Color(0xFF6D5A3C);
  static const Color cardWhite = Color(0xFFFFFFFF);
  static const Color cardBorder = Color(0xFFEEE1C8);

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: warmCream,
    colorScheme: ColorScheme.fromSeed(
      seedColor: honeyGold,
      brightness: Brightness.light,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: warmCream,
      foregroundColor: darkBrown,
      elevation: 0,
      centerTitle: false,
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        color: darkBrown,
        fontWeight: FontWeight.bold,
      ),
      headlineMedium: TextStyle(
        color: darkBrown,
        fontWeight: FontWeight.bold,
      ),
      titleLarge: TextStyle(
        color: darkBrown,
        fontWeight: FontWeight.w700,
      ),
      titleMedium: TextStyle(
        color: darkBrown,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: TextStyle(
        color: darkBrown,
      ),
      bodyMedium: TextStyle(
        color: secondaryBrown,
      ),
    ),
    cardTheme: CardThemeData(
      color: cardWhite,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(
          color: cardBorder,
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: honeyGold,
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 14,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
  );
}