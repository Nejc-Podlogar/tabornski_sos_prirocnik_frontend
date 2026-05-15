import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_typography.dart';
import '../../domain/entities/morse_exercise.dart';
import '../../../../core/domain/value_objects/exercise_enums.dart';
import '../providers/morse_exercise_provider.dart';
import 'morse_pattern_display.dart';

class LearningCardsWidget extends ConsumerWidget {
  const LearningCardsWidget({
    super.key,
    required this.exercises,
    required this.currentIndex,
  });

  final List<MorseExercise> exercises;
  final int currentIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch provider state directly so this widget reacts to isComplete
    // before CardSwiper can attempt to render with cardsCount == 0.
    final state = ref.watch(morseExerciseProvider).valueOrNull;
    if (state == null || state.isComplete || exercises.isEmpty) {
      return const SizedBox.shrink();
    }

    final remaining = exercises.length - currentIndex;
    if (remaining <= 0) return const SizedBox.shrink();

    return Column(
      children: [
        const SizedBox(height: AppSpacing.base),
        Text(
          'Podrsaj desno = pravilno  •  levo = napačno',
          style: AppTypography.caption.copyWith(color: AppColors.textTertiary),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.base),

        Expanded(
          child: Builder(
            builder: (context) {
              // Defensive boundary: re-check remaining inside Builder so that
              // any mid-animation state change cannot produce cardsCount < 1.
              if (remaining < 1) return const SizedBox.shrink();

              return CardSwiper(
                // key forces a fresh swiper whenever the deck advances
                key: ValueKey(currentIndex),
                cardsCount: remaining,
                // Always display exactly 1 card — prevents the assertion
                // 'numberOfCardsDisplayed >= 1 && numberOfCardsDisplayed <= cardsCount'
                // from firing when remaining drops to 1 on the last card.
                numberOfCardsDisplayed: 1,
                cardBuilder: (context, index, _, __) {
                  final exercise = exercises[currentIndex + index];
                  return _ExerciseCard(exercise: exercise);
                },
                onSwipe: (_, __, direction) {
                  final isLastCard = currentIndex >= exercises.length - 1;
                  ref.read(morseExerciseProvider.notifier).swipeCard(
                        direction == CardSwiperDirection.right,
                      );
                  // Return false on the last card so CardSwiper does not
                  // attempt to advance to a non-existent next card.
                  return !isLastCard;
                },
              );
            },
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.xxl,
            vertical: AppSpacing.xl,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _SwipeHint(
                icon: HugeIcons.strokeRoundedCancel01,
                color: AppColors.danger,
                label: 'Napačno',
              ),
              Text(
                '${currentIndex + 1} / ${exercises.length}',
                style: AppTypography.caption
                    .copyWith(color: AppColors.textTertiary),
              ),
              _SwipeHint(
                icon: HugeIcons.strokeRoundedCheckmarkCircle01,
                color: AppColors.correct,
                label: 'Pravilno',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ExerciseCard extends StatelessWidget {
  const _ExerciseCard({required this.exercise});

  final MorseExercise exercise;

  @override
  Widget build(BuildContext context) {
    final prompt = exercise.exerciseValues[0];
    final isMorsePrompt =
        exercise.direction == TranslationDirection.morseToText;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.base),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.primaryDark, width: 1),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xxl),
          child: isMorsePrompt
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    MorsePatternDisplay(morseSequence: prompt),
                    const SizedBox(height: AppSpacing.base),
                    Text(
                      prompt,
                      style: AppTypography.morseSequence.copyWith(
                        fontSize: 18,
                        color: AppColors.accentLight,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                )
              : Text(
                  prompt,
                  style: AppTypography.screenTitle.copyWith(
                    fontSize: 72,
                    fontWeight: FontWeight.w900,
                  ),
                  textAlign: TextAlign.center,
                ),
        ),
      ),
    );
  }
}

class _SwipeHint extends StatelessWidget {
  const _SwipeHint({
    required this.icon,
    required this.color,
    required this.label,
  });

  final List<List<dynamic>> icon;
  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
            border: Border.all(color: color, width: 1.5),
          ),
          child: Center(
            child: HugeIcon(icon: icon, color: color, size: 22),
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          label,
          style: AppTypography.caption.copyWith(color: color),
        ),
      ],
    );
  }
}
