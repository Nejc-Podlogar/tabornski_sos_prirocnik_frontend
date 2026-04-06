import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/routing/route_names.dart';
import '../../../../core/widgets/app_header_bar.dart';
import '../../domain/value_objects/interaction_type.dart';
import '../../domain/value_objects/morse_code_validation.dart';
import '../providers/morse_exercise_provider.dart';
import '../widgets/learning_cards_widget.dart';
import '../widgets/learning_keyboard_widget.dart';

class MorseExerciseScreen extends ConsumerWidget {
  const MorseExerciseScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncState = ref.watch(morseExerciseProvider);

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
                style: AppTypography.body
                    .copyWith(color: AppColors.textTertiary),
              ),
            );
          }

          if (state.isComplete) {
            final correctCount = state.sessionResults
                .where((r) => r == MorseCodeValidation.correct)
                .length;
            return _CompletionView(
              correct: correctCount,
              total: state.exercises.length,
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

class _CompletionView extends StatelessWidget {
  const _CompletionView({required this.correct, required this.total});

  final int correct;
  final int total;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Urjenje končano!',
              style: AppTypography.screenTitle,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.base),
            Text(
              '$correct / $total pravilnih',
              style: AppTypography.cardTitle.copyWith(
                color: AppColors.primaryLight,
              ),
            ),
            const SizedBox(height: AppSpacing.xxl),
            ElevatedButton(
              onPressed: () => context.goNamed(RouteNames.morse),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: const StadiumBorder(),
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.xxl, vertical: AppSpacing.md),
              ),
              child: Text('NAZAJ', style: AppTypography.buttonLabel),
            ),
          ],
        ),
      ),
    );
  }
}
