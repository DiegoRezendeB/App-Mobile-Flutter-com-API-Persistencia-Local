import 'package:flutter/material.dart';

class AppTheme {
  static const Color azulPrimario = Color(0xFF1E3A8A);
  static const Color azulSecundario = Color(0xFF3B82F6);
  static const Color azulClaro = Color(0xFF93C5FD);
  static const Color cinzaEscuro = Color(0xFF0F172A);
  static const Color cinzaMedio = Color(0xFF334155);
  static const Color branco = Color(0xFFF8FAFC);

  static ThemeData get theme {
    return ThemeData(
      scaffoldBackgroundColor: cinzaEscuro,
      primaryColor: azulPrimario,
      colorScheme: const ColorScheme(
        primary: azulPrimario,
        secondary: azulSecundario,
        surface: cinzaEscuro,
        background: cinzaEscuro,
        error: Colors.red,
        onPrimary: branco,
        onSecondary: branco,
        onSurface: branco,
        onBackground: branco,
        onError: branco,
        brightness: Brightness.dark,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: azulPrimario,
        foregroundColor: branco,
        elevation: 0,
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: branco),
        bodyMedium: TextStyle(color: branco),
        bodySmall: TextStyle(color: cinzaMedio),
        titleLarge: TextStyle(color: branco, fontWeight: FontWeight.bold),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: azulSecundario,
          foregroundColor: branco,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      cardColor: azulClaro.withOpacity(0.1),
      dividerColor: cinzaMedio,
    );
  }
}
