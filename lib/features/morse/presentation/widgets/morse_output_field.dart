import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_typography.dart';

class MorseOutputField extends StatelessWidget {
  const MorseOutputField({
    super.key,
    required this.text,
    required this.label,
    required this.onCopy,
  });

  final String text;
  final String label;
  final VoidCallback onCopy;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.md),
        border: Border.all(color: AppColors.primaryDark, width: 1),
      ),
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Text(
                label,
                style: AppTypography.overline
                    .copyWith(color: AppColors.primaryLight),
              ),
              const Spacer(),
              GestureDetector(
                onTap: text.isEmpty ? null : onCopy,
                child: const HugeIcon(
                  icon: HugeIcons.strokeRoundedCopy01,
                  color: AppColors.textTertiary,
                  size: 20,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Expanded(
            child: SingleChildScrollView(
              child: Text(
                text.isEmpty ? 'Prevod se pojavi tukaj...' : text,
                style: text.isEmpty
                    ? AppTypography.body.copyWith(color: AppColors.textTertiary)
                    : AppTypography.morseSequence
                        .copyWith(fontSize: 16, color: AppColors.primaryLight),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
