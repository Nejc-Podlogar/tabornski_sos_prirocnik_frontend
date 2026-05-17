import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

import '../constants/app_colors.dart';
import '../constants/app_icons.dart';
import '../constants/app_spacing.dart';

const double _resultDotSize = 20.0;
const double _currentDotSize = 14.0;
const double _upcomingDotSize = 16.0;
const double _currentDotBorder = 1.5;
const double _upcomingDotBorder = 1.0;

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
      crossAxisAlignment: CrossAxisAlignment.center,
      children: List.generate(total, (index) {
        final isCurrent = index == currentIndex;
        final result = index < results.length ? results[index] : null;

        final Widget dot;

        if (result == true) {
          dot = HugeIcon(
            icon: AppIcons.correct,
            color: AppColors.correct,
            size: _resultDotSize,
          );
        } else if (result == false) {
          dot = HugeIcon(
            icon: AppIcons.wrong,
            color: AppColors.wrong,
            size: _resultDotSize,
          );
        } else if (isCurrent) {
          dot = Container(
            width: _currentDotSize,
            height: _currentDotSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                  color: AppColors.textSecondary, width: _currentDotBorder),
            ),
          );
        } else {
          dot = Container(
            width: _upcomingDotSize,
            height: _upcomingDotSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                  color: AppColors.textTertiary, width: _upcomingDotBorder),
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs / 2),
          child: dot,
        );
      }),
    );
  }
}
