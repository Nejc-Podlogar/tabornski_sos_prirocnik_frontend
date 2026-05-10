import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_typography.dart';
import '../../domain/entities/semaphore_entry.dart';
import 'semaphore_flag_display.dart';

class SemaphoreListItem extends StatelessWidget {
  const SemaphoreListItem({super.key, required this.entry});

  final SemaphoreEntry entry;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.base,
        vertical: AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          // Character
          SizedBox(
            width: 36,
            child: Text(
              entry.character,
              style: AppTypography.cardTitle.copyWith(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: AppColors.primary,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          // Separator
          Container(
            width: 1,
            height: 28,
            color: AppColors.textTertiary.withOpacity(0.3),
            margin: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          ),

          // Flag image
          const Spacer(),
          SemaphoreFlagDisplay(
            flagImagePath: entry.flagImagePath,
            size: 64,
          ),
        ],
      ),
    );
  }
}
