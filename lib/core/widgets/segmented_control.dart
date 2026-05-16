import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_spacing.dart';
import '../constants/app_typography.dart';

class SegmentedControl extends StatelessWidget {
  const SegmentedControl({
    super.key,
    this.options = const [],
    this.children,
    required this.selectedIndex,
    required this.onChanged,
  });

  final List<String> options;

  /// When provided, rendered directly instead of text from [options].
  final List<Widget>? children;

  final int selectedIndex;
  final ValueChanged<int> onChanged;

  int get _itemCount => children?.length ?? options.length;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: List.generate(_itemCount, (index) {
          final isSelected = index == selectedIndex;
          return Expanded(
            child: GestureDetector(
              onTap: () => onChanged(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: children != null
                    ? children![index]
                    : Text(
                        options[index],
                        style: isSelected
                            ? AppTypography.buttonLabel.copyWith(fontSize: 14)
                            : AppTypography.cardSubtitle.copyWith(fontSize: 14),
                      ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
