import 'package:flutter/material.dart';

class AppColors {
  static const background = Color(0xFF0B0B14);
  static const surface = Color(0xFF14142B);
  static const textPrimary = Colors.white;
  static const textSecondary = Color(0xFFB0B3C7);
  static const neonGreen = Color(0xFF39FF14);
  static const neonPink = Color(0xFFFF2E93);
  static const neonBlue = Color(0xFF00E5FF);
}

class AppSizes {
  static const double radius = 24; // единый радиус всех карточек
}

ThemeData buildTheme() => ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.background,
      useMaterial3: true,
    );
