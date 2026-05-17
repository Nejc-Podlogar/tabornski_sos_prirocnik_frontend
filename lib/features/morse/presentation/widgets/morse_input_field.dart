import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_typography.dart';

class MorseInputField extends StatelessWidget {
  const MorseInputField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.label,
    required this.onClear,
    required this.onChanged,
  });

  final TextEditingController controller;
  final String hintText;
  final String label;
  final VoidCallback onClear;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.md),
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
                    .copyWith(color: AppColors.textTertiary),
              ),
              const Spacer(),
              GestureDetector(
                onTap: onClear,
                child: const HugeIcon(
                  icon: HugeIcons.strokeRoundedDelete02,
                  color: AppColors.textTertiary,
                  size: 20,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Expanded(
            child: TextField(
              controller: controller,
              maxLines: null,
              expands: true,
              textAlignVertical: TextAlignVertical.top,
              style: AppTypography.body.copyWith(color: AppColors.textPrimary),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: const TextStyle(color: AppColors.textTertiary),
              ),
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}
