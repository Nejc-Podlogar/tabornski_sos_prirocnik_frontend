import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../core/constants/app_colors.dart';

class MorseKey extends StatelessWidget {
  const MorseKey({
    super.key,
    required this.onTap,
    this.label = '',
    this.icon,
    this.sublabel,
    this.isWide = false,
    this.muted = false,
    this.rotateIcon = false,
  });

  final VoidCallback onTap;
  final String label;
  final List<List<dynamic>>? icon;
  final String? sublabel;
  final bool isWide;
  final bool muted;
  final bool rotateIcon;

  @override
  Widget build(BuildContext context) {
    final color = muted ? AppColors.textSecondary : AppColors.primaryLight;

    Widget child;
    if (icon != null && sublabel != null) {
      child = Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          HugeIcon(icon: icon!, color: color, size: 18),
          const SizedBox(height: 2),
          Text(
            sublabel!,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      );
    } else if (icon != null) {
      final iconWidget = HugeIcon(icon: icon!, color: color, size: 22);
      child = rotateIcon
          ? RotatedBox(quarterTurns: 2, child: iconWidget)
          : iconWidget;
    } else {
      child = Text(
        label,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: color,
        ),
      );
    }

    return Expanded(
      flex: isWide ? 2 : 1,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 56,
          decoration: BoxDecoration(
            color: muted
                ? AppColors.background
                : AppColors.primaryDark.withValues(alpha: 0.25),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: muted
                  ? AppColors.textTertiary.withValues(alpha: 0.25)
                  : AppColors.primaryDark,
              width: 1,
            ),
          ),
          child: Center(child: child),
        ),
      ),
    );
  }
}
