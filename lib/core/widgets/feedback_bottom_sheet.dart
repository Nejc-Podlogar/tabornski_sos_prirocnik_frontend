import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_spacing.dart';
import '../constants/app_typography.dart';
import 'primary_cta_button.dart';

class FeedbackBottomSheet extends StatelessWidget {
  const FeedbackBottomSheet({
    super.key,
    required this.isCorrect,
    required this.correctAnswer,
    required this.onNext,
  });

  final bool isCorrect;
  final String correctAnswer;
  final VoidCallback onNext;

  static Future<void> show({
    required BuildContext context,
    required bool isCorrect,
    required String correctAnswer,
    required VoidCallback onNext,
  }) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => FeedbackBottomSheet(
        isCorrect: isCorrect,
        correctAnswer: correctAnswer,
        onNext: onNext,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final color = isCorrect ? AppColors.correct : AppColors.accent;
    final icon = isCorrect ? Icons.shield : Icons.close;
    final title = isCorrect ? 'Pravilen odgovor!' : 'Napačen odgovor';

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: EdgeInsets.fromLTRB(
        AppSpacing.xl,
        AppSpacing.sm,
        AppSpacing.xl,
        AppSpacing.xl + MediaQuery.of(context).padding.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle
          Container(
            width: 32,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.textTertiary,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: AppSpacing.xl),

          // Icon circle
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppColors.textPrimary, size: 24),
          ),
          const SizedBox(height: AppSpacing.base),

          // Title
          Text(title,
              style: AppTypography.cardTitle.copyWith(
                  fontSize: 20, color: color)),
          const SizedBox(height: AppSpacing.sm),

          // Correct answer (shown when wrong)
          if (!isCorrect) ...[
            Text('Pravilen odgovor:',
                style: AppTypography.cardSubtitle),
            const SizedBox(height: AppSpacing.xs),
            Text(correctAnswer,
                style: AppTypography.body
                    .copyWith(color: AppColors.textPrimary),
                textAlign: TextAlign.center),
            const SizedBox(height: AppSpacing.base),
          ],

          const SizedBox(height: AppSpacing.lg),

          PrimaryCtaButton(
            label: 'Nadaljuj',
            onPressed: () {
              Navigator.of(context).pop();
              onNext();
            },
          ),
        ],
      ),
    );
  }
}
