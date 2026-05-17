import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import 'morse_dot_dash_preview.dart';

class DirectionLabel extends StatelessWidget {
  const DirectionLabel({super.key, required this.textFirst});

  final bool textFirst;

  @override
  Widget build(BuildContext context) {
    const textWidget = Text(
      'Besedilo',
      style: AppTypography.filterChip,
    );
    const arrowWidget = HugeIcon(
      icon: HugeIcons.strokeRoundedArrowRight02,
      color: AppColors.textPrimary,
      size: 14,
    );
    const morseWidget = MorseDotDashPreview();

    final items = textFirst
        ? [textWidget, arrowWidget, morseWidget]
        : [morseWidget, arrowWidget, textWidget];

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < items.length; i++) ...[
          if (i > 0) const SizedBox(width: 9),
          items[i],
        ],
      ],
    );
  }
}
