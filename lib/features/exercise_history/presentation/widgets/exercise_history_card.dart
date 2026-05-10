import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_typography.dart';
import '../../domain/entities/exercise_session.dart';
import '../../domain/helpers/exercise_session_formatter.dart';
import '../../domain/value_objects/feature_type.dart';

class ExerciseHistoryCard extends StatelessWidget {
  const ExerciseHistoryCard({super.key, required this.session});

  final ExerciseSession session;

  @override
  Widget build(BuildContext context) {
    final pct = ExerciseSessionFormatter.percentage(
      session.correctCount,
      session.totalQuestions,
    );
    // clamp() is a defensive UI guard — the domain @Assert already enforces
    // correctCount <= totalQuestions, but LinearProgressIndicator requires [0,1].
    final progress = pct.clamp(0.0, 1.0);
    final pctLabel = ExerciseSessionFormatter.badgeLabel(pct);

    return Container(
      padding: const EdgeInsets.all(AppSpacing.base),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Feature icon
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: HugeIcon(
                icon: _iconFor(session.featureType),
                color: AppColors.primary,
                size: 22,
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.md),

          // Center content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        _titleFor(session.featureType),
                        style: AppTypography.body.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                    // Score badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.sm,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: _badgeColor(pct).withOpacity(0.15),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '${session.correctCount}/${session.totalQuestions}',
                        style: AppTypography.caption.copyWith(
                          color: _badgeColor(pct),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  ExerciseSessionFormatter.formatDate(session.sessionDate),
                  style: AppTypography.caption
                      .copyWith(color: AppColors.textTertiary),
                ),
                const SizedBox(height: AppSpacing.sm),

                // Progress bar
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 6,
                    backgroundColor: AppColors.background,
                    valueColor: AlwaysStoppedAnimation(_badgeColor(pct)),
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),

                // Label + duration row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      pctLabel,
                      style: AppTypography.caption.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      ExerciseSessionFormatter.formatDuration(
                          session.durationSeconds),
                      style: AppTypography.caption
                          .copyWith(color: AppColors.textTertiary),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Color decisions are UI concerns — kept as a private widget helper.
  static Color _badgeColor(double pct) {
    if (pct >= 0.8) return AppColors.correct;
    if (pct >= 0.5) return AppColors.primaryLight;
    return AppColors.accent;
  }

  static List<List<dynamic>> _iconFor(FeatureType type) => switch (type) {
        FeatureType.morse => HugeIcons.strokeRoundedWifi01,
        FeatureType.semaphore => HugeIcons.strokeRoundedFlag01,
        FeatureType.orientation => HugeIcons.strokeRoundedCompass,
      };

  static String _titleFor(FeatureType type) => switch (type) {
        FeatureType.morse => 'Morse',
        FeatureType.semaphore => 'Semafor',
        FeatureType.orientation => 'Orientacija',
      };
}
