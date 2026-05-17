import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import 'morse_button_constants.dart';

class StopButton extends StatelessWidget {
  const StopButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: MorseButtonConstants.buttonHeight,
        height: MorseButtonConstants.buttonHeight,
        decoration: const BoxDecoration(
          color: AppColors.dangerSurface,
          borderRadius: BorderRadius.all(
            Radius.circular(AppSpacing.sm),
          ),
        ),
        child: const Center(
          child: HugeIcon(
            icon: HugeIcons.strokeRoundedStop,
            color: AppColors.danger,
            size: MorseButtonConstants.iconSize,
          ),
        ),
      ),
    );
  }
}
