import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_spacing.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  static const _items = [
    (icon: Icons.home_outlined, activeIcon: Icons.home),
    (icon: Icons.wifi_outlined, activeIcon: Icons.wifi),
    (icon: Icons.flag_outlined, activeIcon: Icons.flag),
    (icon: Icons.explore_outlined, activeIcon: Icons.explore),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSpacing.bottomNavHeight +
          MediaQuery.of(context).padding.bottom,
      color: AppColors.surface,
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).padding.bottom,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(_items.length, (index) {
          final isActive = index == currentIndex;
          return GestureDetector(
            onTap: () => onTap(index),
            behavior: HitTestBehavior.opaque,
            child: SizedBox(
              width: 48,
              height: 48,
              child: Center(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  width: isActive ? 48 : 32,
                  height: isActive ? 48 : 32,
                  decoration: BoxDecoration(
                    color: isActive ? AppColors.accent : Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isActive
                        ? _items[index].activeIcon
                        : _items[index].icon,
                    color: isActive
                        ? AppColors.textPrimary
                        : AppColors.textTertiary,
                    size: 22,
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
