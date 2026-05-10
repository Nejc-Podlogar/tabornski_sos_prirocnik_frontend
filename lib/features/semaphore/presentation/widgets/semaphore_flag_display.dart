import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../core/constants/app_colors.dart';

class SemaphoreFlagDisplay extends StatelessWidget {
  const SemaphoreFlagDisplay({
    super.key,
    required this.flagImagePath,
    this.size = 80,
  });

  final String flagImagePath;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Image.asset(
        flagImagePath,
        width: size,
        height: size,
        fit: BoxFit.contain,
        errorBuilder: (_, __, ___) => _Placeholder(size: size),
      ),
    );
  }
}

class _Placeholder extends StatelessWidget {
  const _Placeholder({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: HugeIcon(
          icon: HugeIcons.strokeRoundedFlag01,
          color: AppColors.textTertiary,
          size: size * 0.5,
        ),
      ),
    );
  }
}
