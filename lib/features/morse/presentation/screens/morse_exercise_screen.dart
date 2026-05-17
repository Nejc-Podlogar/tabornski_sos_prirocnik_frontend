import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/domain/value_objects/exercise_enums.dart';
import '../../../../core/domain/value_objects/exercise_validation.dart';
import '../../../../core/routing/route_names.dart';
import '../../../../core/widgets/app_header_bar.dart';
import '../../domain/entities/morse_exercise.dart';
import '../../domain/helpers/morse_string_utils.dart';
import '../providers/morse_exercise_provider.dart';
import '../widgets/learning_cards_widget.dart';
import '../widgets/learning_keyboard_widget.dart';
import '../widgets/morse_pattern_display.dart';

const double _scoreCircleSize = 140.0;
const double _scoreCircleBorder = 4.0;
const double _scoreFontSize = 36.0;
const double _breakdownIconSize = 20.0;
const double _dividerHeight = 1.0;

class MorseExerciseScreen extends ConsumerWidget {
  const MorseExerciseScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncState = ref.watch(morseExerciseProvider);

    ref.listen(morseExerciseProvider, (previous, next) {
      final wasComplete = previous?.valueOrNull?.isComplete == true;
      final isComplete = next.valueOrNull?.isComplete == true;
      if (!wasComplete && isComplete) {
        ref
            .read(morseExerciseProvider.notifier)
            .saveSession(completedAt: DateTime.now());
      }
    });

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppHeaderBar(
        title: 'Urjenje',
        showBackButton: true,
        onSettingsPressed: () => context.goNamed(RouteNames.settings),
      ),
      body: asyncState.when(
        data: (state) {
          if (state == null) {
            return Center(
              child: Text(
                'Ni aktivne vaje.',
                style:
                    AppTypography.body.copyWith(color: AppColors.textTertiary),
              ),
            );
          }

          if (state.isComplete) {
            final correct = state.sessionResults
                .where((r) => r == ExerciseValidation.correct)
                .length;
            final total = state.exercises.length;
            final percentage = total > 0 ? correct / total : 0.0;
            final results = state.sessionResults
                .map((r) =>
                    r == null ? null : r == ExerciseValidation.correct)
                .toList();
            return _CompletionView(
              correct: correct,
              total: total,
              percentage: percentage,
              exercises: state.exercises,
              results: results,
            );
          }

          final exercise = state.exercises[state.currentIndex];
          return switch (exercise.interactionType) {
            InteractionType.cards => LearningCardsWidget(
                exercises: state.exercises,
                currentIndex: state.currentIndex,
              ),
            InteractionType.keyboard ||
            InteractionType.tokens =>
              LearningKeyboardWidget(
                exercise: exercise,
                currentIndex: state.currentIndex,
                total: state.exercises.length,
              ),
          };
        },
        loading: () => const Center(
          child: CircularProgressIndicator(color: AppColors.primary),
        ),
        error: (e, _) => Center(
          child: Text(
            'Napaka: $e',
            style: AppTypography.body.copyWith(color: AppColors.danger),
          ),
        ),
      ),
    );
  }
}

class _CompletionView extends ConsumerWidget {
  const _CompletionView({
    required this.correct,
    required this.total,
    required this.percentage,
    required this.exercises,
    required this.results,
  });

  final int correct;
  final int total;
  final double percentage;
  final List<MorseExercise> exercises;
  final List<bool?> results;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scoreColor = percentage >= 0.8
        ? AppColors.primary
        : percentage >= 0.5
            ? AppColors.accent
            : AppColors.danger;

    return Padding(
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Column(
        children: [
          const SizedBox(height: AppSpacing.xl),
          Text(
            'Urjenje končano!',
            style: AppTypography.screenTitle,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.xxl),

          Container(
            width: _scoreCircleSize,
            height: _scoreCircleSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: scoreColor, width: _scoreCircleBorder),
              color: scoreColor.withValues(alpha: 0.1),
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${(percentage * 100).round()}%',
                    style: AppTypography.screenTitle.copyWith(
                      color: scoreColor,
                      fontSize: _scoreFontSize,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    '$correct / $total',
                    style: AppTypography.caption.copyWith(
                      color: AppColors.textTertiary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.xxl),

          Expanded(
            child: ListView.separated(
              itemCount: exercises.length,
              separatorBuilder: (_, __) => const Divider(
                color: AppColors.primaryDark,
                height: _dividerHeight,
              ),
              itemBuilder: (context, i) {
                final exercise = exercises[i];
                final isCorrect = i < results.length && results[i] == true;
                final itemColor =
                    isCorrect ? AppColors.correct : AppColors.wrong;
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: AppSpacing.sm),
                  child: Row(
                    children: [
                      HugeIcon(
                        icon: isCorrect ? AppIcons.correct : AppIcons.wrong,
                        color: itemColor,
                        size: _breakdownIconSize,
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            if (MorseStringUtils.isMorseSequence(
                                exercise.exerciseValues[0]))
                              Flexible(
                                child: MorsePatternDisplay(
                                  morseSequence: exercise.exerciseValues[0],
                                ),
                              )
                            else
                              Text(
                                exercise.exerciseValues[0],
                                style: AppTypography.body
                                    .copyWith(color: AppColors.textPrimary),
                              ),
                            Text(
                              '  →  ',
                              style: AppTypography.body
                                  .copyWith(color: AppColors.textTertiary),
                            ),
                            if (MorseStringUtils.isMorseSequence(
                                exercise.translatedValues[0]))
                              Flexible(
                                child: MorsePatternDisplay(
                                  morseSequence: exercise.translatedValues[0],
                                ),
                              )
                            else
                              Text(
                                exercise.translatedValues[0],
                                style: AppTypography.body
                                    .copyWith(color: AppColors.textPrimary),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: AppSpacing.base),

          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => context.goNamed(RouteNames.morse),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.primary),
                    shape: const StadiumBorder(),
                    padding: const EdgeInsets.symmetric(
                        vertical: AppSpacing.md),
                  ),
                  child: Text(
                    'NAZAJ',
                    style: AppTypography.buttonLabel
                        .copyWith(color: AppColors.primary),
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: ElevatedButton(
                  onPressed: exercises.isEmpty
                      ? null
                      : () {
                          final e = exercises.first;
                          ref
                              .read(morseExerciseProvider.notifier)
                              .startExercise(
                                e.contentType,
                                e.direction,
                                e.interactionType,
                                exercises.length,
                              );
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: const StadiumBorder(),
                    padding: const EdgeInsets.symmetric(
                        vertical: AppSpacing.md),
                  ),
                  child: Text(
                    'POSKUSI ZNOVA',
                    style: AppTypography.buttonLabel,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.base),
        ],
      ),
    );
  }
}
