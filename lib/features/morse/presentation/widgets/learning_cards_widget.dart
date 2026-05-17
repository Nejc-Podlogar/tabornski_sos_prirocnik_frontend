import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'card_swiper_stub.dart'
    if (dart.library.io) 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_icons.dart';
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
const double _actionButtonSize = 96.0;
const double _buttonIconSize = 40.0;
const double _buttonBorder = 1.5;
const double _swipePercentageDivisor = 100.0;

class LearningCardsWidget extends ConsumerStatefulWidget {
  const LearningCardsWidget({
    super.key,
    required this.exercises,
    required this.currentIndex,
  });

  final List<MorseExercise> exercises;
  final int currentIndex;

  @override
  ConsumerState<LearningCardsWidget> createState() =>
      _LearningCardsWidgetState();
}

class _LearningCardsWidgetState extends ConsumerState<LearningCardsWidget> {
  late CardSwiperController _controller;

  @override
  void initState() {
    super.initState();
    _controller = CardSwiperController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(morseExerciseProvider).valueOrNull;
    if (state == null || state.isComplete || widget.exercises.isEmpty) {
      return const SizedBox.shrink();
    }

    final remaining = widget.exercises.length - widget.currentIndex;
    if (remaining <= 0) return const SizedBox.shrink();

    final dotResults = state.sessionResults
        .map((r) => r == null ? null : r == ExerciseValidation.correct)
        .toList();

    return Column(
      children: [
        const SizedBox(height: AppSpacing.base),
        ProgressDotsRow(
          total: widget.exercises.length,
          currentIndex: widget.currentIndex,
          results: dotResults,
        ),
        const SizedBox(height: AppSpacing.base),
        Expanded(
          child: Builder(
            builder: (context) {
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
                key: ValueKey(widget.currentIndex),
                controller: _controller,
                cardsCount: remaining,
                numberOfCardsDisplayed: 1,
                cardBuilder:
                    (context, index, horizontalThresholdPercentage, __) {
                  final exercise =
                      widget.exercises[widget.currentIndex + index];
                  final swipeProgress =
                      (horizontalThresholdPercentage / _swipePercentageDivisor)
                          .clamp(-1.0, 1.0);
                  return _ExerciseCard(
                    exercise: exercise,
                    swipeProgress: swipeProgress,
                  );
                },
                onSwipe: (_, __, direction) {
                  final isLastCard =
                      widget.currentIndex >= widget.exercises.length - 1;
                  ref.read(morseExerciseProvider.notifier).swipeCard(
                        direction == CardSwiperDirection.right,
                      );
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                customBorder: const CircleBorder(),
                onTap: () => _controller.swipe(CardSwiperDirection.left),
                child: Container(
                  width: _actionButtonSize,
                  height: _actionButtonSize,
                  decoration: BoxDecoration(
                    color: AppColors.danger.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: AppColors.danger, width: _buttonBorder),
                  ),
                  child: Center(
                    child: HugeIcon(
                      icon: AppIcons.wrong,
                      color: AppColors.danger,
                      size: _buttonIconSize,
                    ),
                  ),
                ),
              ),
              InkWell(
                customBorder: const CircleBorder(),
                onTap: () => _controller.swipe(CardSwiperDirection.right),
                child: Container(
                  width: _actionButtonSize,
                  height: _actionButtonSize,
                  decoration: BoxDecoration(
                    color: AppColors.correct.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: AppColors.correct, width: _buttonBorder),
                  ),
                  child: Center(
                    child: HugeIcon(
                      icon: AppIcons.correct,
                      color: AppColors.correct,
                      size: _buttonIconSize,
                    ),
                  ),
                ),
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
  final double swipeProgress;

  @override
  Widget build(BuildContext context) {
    final isMorsePrompt =
        exercise.direction == TranslationDirection.morseToText;
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
                          exercise.translatedValues[0],
                          style: AppTypography.screenTitle.copyWith(
                            fontSize: _letterFontSize,
                            fontWeight: FontWeight.w900,
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
          if (overlayOpacity > 0) ...[
            Positioned.fill(
              child: Container(
                color: (isSwipingRight ? AppColors.primary : AppColors.danger)
                    .withValues(alpha: overlayOpacity * 0.3),
              ),
            ),
            Positioned(
              top: AppSpacing.base,
              left: isSwipingRight ? null : AppSpacing.base,
              right: isSwipingRight ? AppSpacing.base : null,
              child: Opacity(
                opacity: overlayOpacity,
                child: HugeIcon(
                  icon: isSwipingRight ? AppIcons.correct : AppIcons.wrong,
                  color: isSwipingRight ? AppColors.primary : AppColors.danger,
                  size: _overlayIconSize,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
