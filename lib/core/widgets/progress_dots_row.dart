import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_spacing.dart';

class ProgressDotsRow extends StatelessWidget {
  const ProgressDotsRow({
    super.key,
    required this.total,
    required this.currentIndex,
    required this.results,
  });

  /// Total number of questions.
  final int total;

  /// Index of the current (active) question.
  final int currentIndex;

  /// Result for each question. null = upcoming, true = correct, false = wrong.
  final List<bool?> results;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(total, (index) {
        final isCurrent = index == currentIndex;
        final result = index < results.length ? results[index] : null;

        final Color color;
        final double size;

        if (isCurrent) {
          color = AppColors.textSecondary;
          size = 12;
        } else if (result == true) {
          color = AppColors.correct;
          size = 10;
        } else if (result == false) {
          color = AppColors.wrong;
          size = 10;
        } else {
          color = Colors.transparent;
          size = 10;
        }

        final bool isUpcoming = !isCurrent && result == null;

        return Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.xs / 2),
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: isUpcoming ? Colors.transparent : color,
              shape: BoxShape.circle,
              border: isUpcoming
                  ? Border.all(color: AppColors.textTertiary, width: 1)
                  : null,
            ),
          ),
        );
      }),
    );
  }
}
