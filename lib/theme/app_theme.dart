import 'package:flutter/material.dart';

import 'app_colors.dart'; // Verifica que esta importación sea correcta

class AppTheme {
  static ThemeData buildTheme() {
    return ThemeData(
      primaryColor: AppColors.primaryColor,
      scaffoldBackgroundColor: AppColors.backgroundLight,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.accentColor,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 5, // Añadir sombra
        ),
      ),
    );
  }
}
