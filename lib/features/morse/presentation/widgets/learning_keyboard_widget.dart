import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/widgets/feedback_bottom_sheet.dart';
import '../../../../core/widgets/primary_cta_button.dart';
import '../../../../core/widgets/progress_dots_row.dart';
import '../../domain/entities/morse_exercise.dart';
import '../../../../core/domain/value_objects/exercise_validation.dart';
import '../providers/morse_exercise_provider.dart';

class LearningKeyboardWidget extends ConsumerStatefulWidget {
  const LearningKeyboardWidget({
    super.key,
    required this.exercise,
    required this.currentIndex,
    required this.total,
  });

  final MorseExercise exercise;
  final int currentIndex;
  final int total;

  @override
  ConsumerState<LearningKeyboardWidget> createState() =>
      _LearningKeyboardWidgetState();
}

class _LearningKeyboardWidgetState
    extends ConsumerState<LearningKeyboardWidget> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(LearningKeyboardWidget old) {
    super.didUpdateWidget(old);
    if (old.currentIndex != widget.currentIndex) {
      _controller.clear();
    }
  }

  void _check() {
    if (_controller.text.trim().isEmpty) return;

    final notifier = ref.read(morseExerciseProvider.notifier);
    notifier.validateAnswer(_controller.text);

    // Read synchronously — validateAnswer() does a synchronous state update.
    final state = ref.read(morseExerciseProvider).valueOrNull;
    if (state == null || !mounted) return;

    final result = state.sessionResults[widget.currentIndex];
    final isCorrect = result == ExerciseValidation.correct;

    FeedbackBottomSheet.show(
      context: context,
      isCorrect: isCorrect,
      correctAnswer: widget.exercise.translatedValues[0],
      onNext: notifier.nextExercise,
    );
  }

  @override
  Widget build(BuildContext context) {
    final sessionResults = ref.watch(
      morseExerciseProvider
          .select((a) => a.valueOrNull?.sessionResults ?? const []),
    );

    final boolResults = sessionResults
        .map((r) => r == null ? null : r == ExerciseValidation.correct)
        .toList();

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.base,
        AppSpacing.base,
        AppSpacing.base,
        AppSpacing.xl,
      ),
      child: Column(
        children: [
          // Progress dots
          ProgressDotsRow(
            total: widget.total,
            currentIndex: widget.currentIndex,
            results: boolResults,
          ),
          const SizedBox(height: AppSpacing.xxl),

          // Prompt card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.xl,
              vertical: AppSpacing.xxl,
            ),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.primaryDark, width: 1),
            ),
            child: Text(
              widget.exercise.exerciseValues[0],
              style: AppTypography.screenTitle.copyWith(fontSize: 52),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: AppSpacing.xl),

          // Input field
          TextField(
            controller: _controller,
            autofocus: true,
            style: AppTypography.body.copyWith(color: AppColors.textPrimary),
            textCapitalization: TextCapitalization.characters,
            decoration: InputDecoration(
              hintText: 'Vnesi odgovor…',
              hintStyle:
                  AppTypography.body.copyWith(color: AppColors.textTertiary),
              filled: true,
              fillColor: AppColors.surface,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AppColors.primary),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.base,
                vertical: AppSpacing.md,
              ),
            ),
            onSubmitted: (_) => _check(),
          ),
          const SizedBox(height: AppSpacing.xl),

          // Preveri button
          PrimaryCtaButton(
            label: 'Preveri',
            onPressed: _check,
          ),

          const Spacer(),
        ],
      ),
    );
  }
}
