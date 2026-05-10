import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/domain/value_objects/exercise_enums.dart';
import '../../../../core/domain/value_objects/exercise_validation.dart';
import '../../../../core/routing/route_names.dart';
import '../../../../core/widgets/app_header_bar.dart';
import '../../../../core/widgets/feedback_bottom_sheet.dart';
import '../../../../core/widgets/primary_cta_button.dart';
import '../../../../core/widgets/progress_dots_row.dart';
import '../../domain/entities/orientation_sign.dart';
import '../providers/orientation_exercise_provider.dart';
import 'orientation_exercise_selector_screen.dart';

class OrientationExerciseScreen extends ConsumerWidget {
  const OrientationExerciseScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncState = ref.watch(orientationExerciseProvider);
    final interactionType = ref.watch(orientationInteractionTypeProvider);

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
            final correctCount = state.sessionResults
                .where((r) => r == ExerciseValidation.correct)
                .length;
            return _CompletionView(
              correct: correctCount,
              total: state.signs.length,
            );
          }

          return switch (interactionType) {
            InteractionType.cards => _CardExercise(
                signs: state.signs,
                currentIndex: state.currentIndex,
              ),
            InteractionType.keyboard ||
            InteractionType.tokens =>
              _KeyboardExercise(
                sign: state.signs[state.currentIndex],
                currentIndex: state.currentIndex,
                total: state.signs.length,
                sessionResults: state.sessionResults,
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

// ---------------------------------------------------------------------------
// Card swipe mode
// ---------------------------------------------------------------------------

class _CardExercise extends ConsumerWidget {
  const _CardExercise({
    required this.signs,
    required this.currentIndex,
  });

  final List<OrientationSign> signs;
  final int currentIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final remaining = signs.length - currentIndex;
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
          child: CardSwiper(
            key: ValueKey(currentIndex),
            cardsCount: remaining,
            cardBuilder: (context, index, _, __) {
              final sign = signs[currentIndex + index];
              return _SwipeCard(sign: sign);
            },
            onSwipe: (_, __, direction) {
              ref.read(orientationExerciseProvider.notifier).swipeCard(
                    direction == CardSwiperDirection.right,
                  );
              return true;
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
                '${currentIndex + 1} / ${signs.length}',
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

class _SwipeCard extends StatelessWidget {
  const _SwipeCard({required this.sign});

  final OrientationSign sign;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.base),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.primaryDark, width: 1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.xxl,
                AppSpacing.xxl,
                AppSpacing.xxl,
                AppSpacing.md,
              ),
              child: Image.asset(
                sign.imageLoc,
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) => const Icon(
                  Icons.map_outlined,
                  color: AppColors.textTertiary,
                  size: 80,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.xl,
              0,
              AppSpacing.xl,
              AppSpacing.xxl,
            ),
            child: Text(
              sign.name,
              style: AppTypography.cardTitle.copyWith(
                color: AppColors.textPrimary,
              ),
              textAlign: TextAlign.center,
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
        Text(label, style: AppTypography.caption.copyWith(color: color)),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Keyboard mode
// ---------------------------------------------------------------------------

class _KeyboardExercise extends ConsumerStatefulWidget {
  const _KeyboardExercise({
    required this.sign,
    required this.currentIndex,
    required this.total,
    required this.sessionResults,
  });

  final OrientationSign sign;
  final int currentIndex;
  final int total;
  final List<ExerciseValidation?> sessionResults;

  @override
  ConsumerState<_KeyboardExercise> createState() => _KeyboardExerciseState();
}

class _KeyboardExerciseState extends ConsumerState<_KeyboardExercise> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(_KeyboardExercise old) {
    super.didUpdateWidget(old);
    if (old.currentIndex != widget.currentIndex) {
      _controller.clear();
    }
  }

  void _check() {
    if (_controller.text.trim().isEmpty) return;

    final notifier = ref.read(orientationExerciseProvider.notifier);
    notifier.validateAnswer(_controller.text);

    final state = ref.read(orientationExerciseProvider).valueOrNull;
    if (state == null || !mounted) return;

    final result = state.sessionResults[widget.currentIndex];
    final isCorrect = result == ExerciseValidation.correct;

    FeedbackBottomSheet.show(
      context: context,
      isCorrect: isCorrect,
      correctAnswer: widget.sign.name,
      onNext: notifier.nextSign,
    );
  }

  @override
  Widget build(BuildContext context) {
    final boolResults = widget.sessionResults
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
          ProgressDotsRow(
            total: widget.total,
            currentIndex: widget.currentIndex,
            results: boolResults,
          ),
          const SizedBox(height: AppSpacing.xxl),

          // Sign image prompt
          Container(
            width: double.infinity,
            height: 200,
            padding: const EdgeInsets.all(AppSpacing.xl),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.primaryDark, width: 1),
            ),
            child: Image.asset(
              widget.sign.imageLoc,
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) => const Icon(
                Icons.map_outlined,
                color: AppColors.textTertiary,
                size: 64,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.xl),

          // Input field
          TextField(
            controller: _controller,
            autofocus: true,
            style: AppTypography.body.copyWith(color: AppColors.textPrimary),
            textCapitalization: TextCapitalization.words,
            decoration: InputDecoration(
              hintText: 'Ime znaka…',
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

          PrimaryCtaButton(label: 'Preveri', onPressed: _check),

          const Spacer(),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Completion view
// ---------------------------------------------------------------------------

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
              style:
                  AppTypography.cardTitle.copyWith(color: AppColors.primaryLight),
            ),
            const SizedBox(height: AppSpacing.xxl),
            ElevatedButton(
              onPressed: () => context.goNamed(RouteNames.orientation),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: const StadiumBorder(),
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.xxl,
                  vertical: AppSpacing.md,
                ),
              ),
              child: Text('NAZAJ', style: AppTypography.buttonLabel),
            ),
          ],
        ),
      ),
    );
  }
}
