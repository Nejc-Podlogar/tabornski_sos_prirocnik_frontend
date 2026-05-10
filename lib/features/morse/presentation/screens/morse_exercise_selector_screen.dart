import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/routing/route_names.dart';
import '../../../../core/widgets/app_header_bar.dart';
import '../../../../core/widgets/filter_chip_row.dart';
import '../../../../core/widgets/primary_cta_button.dart';
import '../../../../core/widgets/segmented_control.dart'; // direction only
import '../../../../core/domain/value_objects/exercise_enums.dart';
import '../providers/morse_exercise_provider.dart';

class MorseExerciseSelectorScreen extends ConsumerStatefulWidget {
  const MorseExerciseSelectorScreen({super.key});

  @override
  ConsumerState<MorseExerciseSelectorScreen> createState() =>
      _MorseExerciseSelectorScreenState();
}

class _MorseExerciseSelectorScreenState
    extends ConsumerState<MorseExerciseSelectorScreen> {
  int _directionIndex = 0;
  int _contentIndex = 0;
  int _modeIndex = 0;
  int _repetitionIndex = 1;

  static const _counts = [1, 5, 10, 20];

  ExerciseContentType get _contentType => switch (_contentIndex) {
        1 => ExerciseContentType.words,
        2 => ExerciseContentType.sentences,
        _ => ExerciseContentType.letters,
      };

  TranslationDirection get _direction =>
      _directionIndex == 0
          ? TranslationDirection.textToMorse
          : TranslationDirection.morseToText;

  InteractionType get _interactionType => switch (_modeIndex) {
        1 => InteractionType.keyboard,
        2 => InteractionType.tokens,
        _ => InteractionType.cards,
      };

  Future<void> _start() async {
    await ref.read(morseExerciseProvider.notifier).startExercise(
          _contentType,
          _direction,
          _interactionType,
          _counts[_repetitionIndex],
        );
    if (mounted) context.goNamed(RouteNames.morseExerciseSession);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppHeaderBar(
        title: 'Nastavi Urjenje',
        showBackButton: true,
        onSettingsPressed: () => context.goNamed(RouteNames.settings),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.base),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _SectionLabel('SMER PREVAJANJA'),
            const SizedBox(height: AppSpacing.sm),
            SegmentedControl(
              options: const ['Oddajanje', 'Sprejemanje'],
              selectedIndex: _directionIndex,
              onChanged: (i) => setState(() => _directionIndex = i),
            ),
            const SizedBox(height: AppSpacing.xl),

            _SectionLabel('VSEBINA'),
            const SizedBox(height: AppSpacing.sm),
            FilterChipRow(
              options: const ['Črke', 'Besede', 'Stavki'],
              selectedIndex: _contentIndex,
              onSelected: (i) => setState(() => _contentIndex = i),
            ),
            const SizedBox(height: AppSpacing.xl),

            _SectionLabel('NAČIN VADBE'),
            const SizedBox(height: AppSpacing.sm),
            FilterChipRow(
              options: const ['Kartice', 'Tipkovnica', 'Žetoni'],
              selectedIndex: _modeIndex,
              onSelected: (i) => setState(() => _modeIndex = i),
            ),
            const SizedBox(height: AppSpacing.xl),

            _SectionLabel('ŠTEVILO PONOVITEV'),
            const SizedBox(height: AppSpacing.sm),
            FilterChipRow(
              options: _counts.map((c) => c.toString()).toList(),
              selectedIndex: _repetitionIndex,
              onSelected: (i) => setState(() => _repetitionIndex = i),
            ),
            const SizedBox(height: AppSpacing.xxxl),

            PrimaryCtaButton(
              label: 'Začni Urjenje',
              onPressed: _start,
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppTypography.overline.copyWith(color: AppColors.textTertiary),
    );
  }
}
