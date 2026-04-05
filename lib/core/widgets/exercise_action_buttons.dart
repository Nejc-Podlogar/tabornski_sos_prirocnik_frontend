import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_spacing.dart';
import '../constants/app_typography.dart';

class ExerciseActionButtons extends StatelessWidget {
  const ExerciseActionButtons({
    super.key,
    required this.onWrong,
    required this.onHelp,
    required this.onCorrect,
  });

  final VoidCallback onWrong;
  final VoidCallback onHelp;
  final VoidCallback onCorrect;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _ActionButton(
          size: 56,
          backgroundColor: AppColors.surface,
          icon: Icons.close,
          iconColor: AppColors.danger,
          onPressed: onWrong,
        ),
        const SizedBox(width: AppSpacing.xl),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _ActionButton(
              size: 64,
              backgroundColor: AppColors.accent,
              icon: Icons.help_outline,
              iconColor: AppColors.textPrimary,
              onPressed: onHelp,
            ),
            const SizedBox(height: AppSpacing.xs),
            Text('POMOČ',
                style: AppTypography.caption
                    .copyWith(color: AppColors.accent)),
          ],
        ),
        const SizedBox(width: AppSpacing.xl),
        _ActionButton(
          size: 56,
          backgroundColor: AppColors.surface,
          icon: Icons.check,
          iconColor: AppColors.primary,
          onPressed: onCorrect,
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.size,
    required this.backgroundColor,
    required this.icon,
    required this.iconColor,
    required this.onPressed,
  });

  final double size;
  final Color backgroundColor;
  final IconData icon;
  final Color iconColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: iconColor, size: size * 0.4),
      ),
    );
  }
}
