import 'package:flutter/painting.dart';

import 'app_colors.dart';

abstract class AppTypography {
  AppTypography._();

  // Screen title — 28sp, 700, textPrimary
  static const TextStyle screenTitle = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  // Section label / Overline — 11sp, 600, textSecondary, uppercase, ls 1.2
  static const TextStyle overline = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w600,
    color: AppColors.textSecondary,
    letterSpacing: 1.2,
  );

  // Card title — 18sp, 700, textPrimary
  static const TextStyle cardTitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  // Card subtitle — 13sp, 400, textSecondary
  static const TextStyle cardSubtitle = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  // Body text — 15sp, 400, textPrimary, line-height 1.5
  static const TextStyle body = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
    height: 1.5,
  );

  // Caption — 11sp, 400, textTertiary
  static const TextStyle caption = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w400,
    color: AppColors.textTertiary,
  );

  // Button label — 16sp, 600, textPrimary
  static const TextStyle buttonLabel = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  // Filter chip — 13sp, 500
  static const TextStyle filterChip = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w500,
  );

  // Morse sequence — 14sp, 400, accentLight, monospace
  static const TextStyle morseSequence = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.accentLight,
    fontFamily: 'JetBrainsMono-Regular',
  );
}
