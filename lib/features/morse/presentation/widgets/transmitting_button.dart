import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../core/constants/app_colors.dart';
import 'morse_button_constants.dart';
import 'squiggly_wave_painter.dart';

class TransmittingButton extends StatelessWidget {
  const TransmittingButton({
    super.key,
    required this.animation,
    required this.progress,
    required this.morseSequence,
  });

  final Animation<double> animation;
  final double progress;
  final String morseSequence;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (_, child) {
        final pulse = (math.sin(animation.value * 2 * math.pi) + 1) / 2;
        return Container(
          height: MorseButtonConstants.buttonHeight,
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(MorseButtonConstants.buttonRadius),
            border: Border.all(color: AppColors.primaryDark, width: 1),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(
                  alpha: MorseButtonConstants.pulseMin +
                      MorseButtonConstants.pulseMax * pulse,
                ),
                blurRadius: MorseButtonConstants.glowBlurBase +
                    MorseButtonConstants.glowBlurPulse * pulse,
                spreadRadius: pulse * MorseButtonConstants.glowSpreadFactor,
              ),
            ],
          ),
          child: child,
        );
      },
      child: Row(
        children: [
          const SizedBox(width: MorseButtonConstants.spacerLarge),
          const HugeIcon(
            icon: HugeIcons.strokeRoundedVolumeHigh,
            color: AppColors.primaryLight,
            size: MorseButtonConstants.volumeIconSize,
          ),
          const SizedBox(width: MorseButtonConstants.spacerSmall),
          Container(
            width: MorseButtonConstants.separatorWidth,
            height: MorseButtonConstants.iconSize,
            color: AppColors.primaryLight
                .withValues(alpha: MorseButtonConstants.separatorAlpha),
          ),
          const SizedBox(width: MorseButtonConstants.spacerSmall),
          Expanded(
            child: SizedBox.expand(
              child: CustomPaint(
                painter: SquigglyWavePainter(
                  animation: animation,
                  progress: progress,
                  color: AppColors.primaryLight,
                  morseSequence: morseSequence,
                ),
              ),
            ),
          ),
          const SizedBox(width: MorseButtonConstants.spacerLarge),
        ],
      ),
    );
  }
}
