import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'card_swiper_stub.dart'
    if (dart.library.io) 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/domain/value_objects/exercise_enums.dart';
import '../../../../core/domain/value_objects/exercise_validation.dart';
import '../../../../core/widgets/progress_dots_row.dart';
import '../../domain/entities/morse_exercise.dart';
import '../providers/morse_exercise_provider.dart';
import 'morse_pattern_display.dart';

const double _cardRadius = 24.0;
const double _cardBorder = 1.0;
const double _letterFontSize = 72.0;
const double _overlayIconSize = 80.0;
const double _hintIconSize = 22.0;
const double _hintBorder = 1.5;
const double _hintContainerSize = 48.0;
const double _swipePercentageDivisor = 100.0;

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

    final dotResults = state.sessionResults
        .map((r) => r == null ? null : r == ExerciseValidation.correct)
        .toList();

    return Column(
      children: [
        const SizedBox(height: AppSpacing.base),
        ProgressDotsRow(
          total: exercises.length,
          currentIndex: currentIndex,
          results: dotResults,
        ),
        const SizedBox(height: AppSpacing.base),

        Expanded(
          child: Builder(
            builder: (context) {
              // Defensive boundary: re-check remaining inside Builder so that
              // any mid-animation state change cannot produce cardsCount < 1.
              if (remaining < 1) return const SizedBox.shrink();

              if (kIsWeb) {
                return Center(
                  child: Text(
                    'Učenje s karticami ni na voljo na spletu.',
                    style: AppTypography.body
                        .copyWith(color: AppColors.textSecondary),
                    textAlign: TextAlign.center,
                  ),
                );
              }

              return CardSwiper(
                // key forces a fresh swiper whenever the deck advances
                key: ValueKey(currentIndex),
                cardsCount: remaining,
                // Always display exactly 1 card — prevents the assertion
                // 'numberOfCardsDisplayed >= 1 && numberOfCardsDisplayed <= cardsCount'
                // from firing when remaining drops to 1 on the last card.
                numberOfCardsDisplayed: 1,
                cardBuilder: (context, index, horizontalThresholdPercentage, __) {
                  final exercise = exercises[currentIndex + index];
                  final swipeProgress =
                      (horizontalThresholdPercentage / _swipePercentageDivisor)
                          .clamp(-1.0, 1.0);
                  return _ExerciseCard(
                    exercise: exercise,
                    swipeProgress: swipeProgress,
                  );
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
              ),
              _SwipeHint(
                icon: HugeIcons.strokeRoundedCheckmarkCircle01,
                color: AppColors.correct,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ExerciseCard extends StatelessWidget {
  const _ExerciseCard({required this.exercise, required this.swipeProgress});

  final MorseExercise exercise;
  final double swipeProgress; // -1.0 (left/incorrect) to 1.0 (right/correct)

  @override
  Widget build(BuildContext context) {
    final isMorsePrompt = exercise.direction == TranslationDirection.morseToText;
    final overlayOpacity = swipeProgress.abs().clamp(0.0, 1.0);
    final isSwipingRight = swipeProgress > 0;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.base),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(_cardRadius),
        border: Border.all(color: AppColors.primaryDark, width: _cardBorder),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSpacing.xxl),
            child: Center(
              child: isMorsePrompt
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        MorsePatternDisplay(
                          morseSequence: exercise.exerciseValues[0],
                        ),
                        const SizedBox(height: AppSpacing.xxl),
                        Text(
                          '?',
                          style: AppTypography.screenTitle.copyWith(
                            fontSize: _letterFontSize,
                            fontWeight: FontWeight.w900,
                            color: AppColors.textTertiary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    )
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          exercise.exerciseValues[0],
                          style: AppTypography.screenTitle.copyWith(
                            fontSize: _letterFontSize,
                            fontWeight: FontWeight.w900,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: AppSpacing.xl),
                        Text(
                          'Morsejeva koda:',
                          style: AppTypography.caption
                              .copyWith(color: AppColors.textTertiary),
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        MorsePatternDisplay(
                          morseSequence: exercise.translatedValues[0],
                        ),
                      ],
                    ),
            ),
          ),
          if (overlayOpacity > 0)
            Positioned.fill(
              child: Container(
                color: (isSwipingRight ? AppColors.primary : AppColors.danger)
                    .withValues(alpha: overlayOpacity * 0.3),
                child: Center(
                  child: HugeIcon(
                    icon: isSwipingRight
                        ? HugeIcons.strokeRoundedCheckmarkCircle01
                        : HugeIcons.strokeRoundedCancel01,
                    color:
                        isSwipingRight ? AppColors.primary : AppColors.danger,
                    size: _overlayIconSize,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _SwipeHint extends StatelessWidget {
  const _SwipeHint({
    required this.icon,
    required this.color,
  });

  final List<List<dynamic>> icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _hintContainerSize,
      height: _hintContainerSize,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        shape: BoxShape.circle,
        border: Border.all(color: color, width: _hintBorder),
      ),
      child: Center(
        child: HugeIcon(icon: icon, color: color, size: _hintIconSize),
      ),
    );
  }
}
