import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class MorseDotDashPreview extends StatelessWidget {
  const MorseDotDashPreview({super.key});

  static const double _dotSize = 4.0;
  static const double _dashWidth = 13.0;
  static const double _dashHeight = 3.0;
  static const double _symbolSpacing = 4.0;
  static const double _borderRadius = 3.0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: _dotSize,
          height: _dotSize,
          decoration: const BoxDecoration(
            color: AppColors.textPrimary,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: _symbolSpacing),
        Container(
          width: _dashWidth,
          height: _dashHeight,
          decoration: const BoxDecoration(
            color: AppColors.textPrimary,
            borderRadius: BorderRadius.all(Radius.circular(_borderRadius)),
          ),
        ),
      ],
    );
  }
}
