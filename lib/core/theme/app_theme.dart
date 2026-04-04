import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_typography.dart';

abstract class AppTheme {
  AppTheme._();

  static ThemeData dark() => ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: const ColorScheme(
          brightness: Brightness.dark,
          primary: AppColors.primary,
          onPrimary: AppColors.textPrimary,
          primaryContainer: AppColors.primaryDark,
          onPrimaryContainer: AppColors.textPrimary,
          secondary: AppColors.accent,
          onSecondary: AppColors.textPrimary,
          secondaryContainer: AppColors.surface,
          onSecondaryContainer: AppColors.textPrimary,
          surface: AppColors.surface,
          onSurface: AppColors.textPrimary,
          error: AppColors.danger,
          onError: AppColors.textPrimary,
          errorContainer: AppColors.dangerSurface,
          onErrorContainer: AppColors.danger,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.background,
          foregroundColor: AppColors.textPrimary,
          elevation: 0,
          titleTextStyle: AppTypography.cardTitle,
          iconTheme: IconThemeData(color: AppColors.textSecondary),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: AppColors.surface,
          selectedItemColor: AppColors.textPrimary,
          unselectedItemColor: AppColors.textTertiary,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          elevation: 0,
        ),
        cardTheme: const CardThemeData(
          color: AppColors.surface,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.textPrimary,
            textStyle: AppTypography.buttonLabel,
            shape: const StadiumBorder(),
            minimumSize: const Size.fromHeight(52),
          ),
        ),
        switchTheme: SwitchThemeData(
          thumbColor: WidgetStateProperty.all(AppColors.textPrimary),
          trackColor: WidgetStateProperty.resolveWith((states) {
            return states.contains(WidgetState.selected)
                ? AppColors.primary
                : AppColors.textTertiary;
          }),
        ),
        dividerColor: AppColors.surface,
        textTheme: const TextTheme(
          displayMedium: AppTypography.screenTitle,
          titleLarge: AppTypography.cardTitle,
          titleSmall: AppTypography.cardSubtitle,
          bodyLarge: AppTypography.body,
          bodySmall: AppTypography.caption,
          labelLarge: AppTypography.buttonLabel,
          labelSmall: AppTypography.overline,
        ),
      );

  static ThemeData light() => ThemeData(
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          brightness: Brightness.light,
          primary: AppColors.primary,
          secondary: AppColors.accent,
          error: AppColors.danger,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.primaryLight,
          foregroundColor: AppColors.textPrimary,
          elevation: 0,
          titleTextStyle: AppTypography.cardTitle,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.textPrimary,
            textStyle: AppTypography.buttonLabel,
            shape: const StadiumBorder(),
            minimumSize: const Size.fromHeight(52),
          ),
        ),
        switchTheme: SwitchThemeData(
          thumbColor: WidgetStateProperty.all(AppColors.textPrimary),
          trackColor: WidgetStateProperty.resolveWith((states) {
            return states.contains(WidgetState.selected)
                ? AppColors.primary
                : AppColors.textTertiary;
          }),
        ),
      );
}
