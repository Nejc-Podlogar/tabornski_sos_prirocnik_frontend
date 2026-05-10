import 'package:flutter/painting.dart';

abstract class AppColors {
  AppColors._();

  // Brand
  static const Color primary = Color(0xFF5E8C61);
  static const Color primaryLight = Color(0xFF8DB88F);
  static const Color primaryDark = Color(0xFF3A5C3C);
  static const Color accent = Color(0xFF622599);
  static const Color accentLight = Color(0xFF9B6CC7);
  static const Color olive = Color(0xFF656839);

  // Surfaces
  static const Color surface = Color(0xFF1A2A1A);
  static const Color background = Color(0xFF0F1A0F);
  static const Color backgroundAlt = Color(0xFF192219);

  // Text
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFF8DB88F);
  static const Color textTertiary = Color(0xFF5A7A5C);

  // Utility
  static const Color transparent = Color(0x00000000);

  // Decorative
  static const Color mountainSilhouette = Color(0xFF050505);
  static const Color backgroundPure = Color(0xFF000000);
  static const Color torchGlow = Color(0xFFFFFFCC);

  // Feedback
  static const Color danger = Color(0xFFC0392B);
  static const Color dangerSurface = Color(0xFF3D1010);
  static const Color correct = Color(0xFF5E8C61); // same as primary
  static const Color wrong = Color(0xFF622599);   // same as accent
}
