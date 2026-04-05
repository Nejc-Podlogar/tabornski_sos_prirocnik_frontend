import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

import '../constants/app_colors.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  static const _navBarColor = Color(0xFF1A2A1A);
  static const _borderColor = Color(0xFF2A3A2A);
  static const _navBarHeight = 64.0;

  static const _icons = [
    HugeIcons.strokeRoundedHome09,
    HugeIcons.strokeRoundedWifi01,
    HugeIcons.strokeRoundedFlag01,
    HugeIcons.strokeRoundedCompass,
  ];

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Container(
      height: _navBarHeight + bottomPadding,
      decoration: const BoxDecoration(
        color: _navBarColor,
        border: Border(
          top: BorderSide(color: _borderColor, width: 1),
        ),
      ),
      padding: EdgeInsets.only(bottom: bottomPadding),
      child: Row(
        children: List.generate(_icons.length, (index) {
          final isActive = index == currentIndex;
          return Expanded(
            child: GestureDetector(
              onTap: () => onTap(index),
              behavior: HitTestBehavior.opaque,
              child: SizedBox(
                height: _navBarHeight,
                child: Center(
                  child: HugeIcon(
                    icon: _icons[index],
                    color: isActive
                        ? AppColors.accent
                        : AppColors.textTertiary,
                    size: isActive ? 28.0 : 26.0,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
