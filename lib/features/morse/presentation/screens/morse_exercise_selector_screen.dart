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

const double _chipRadius = 20.0;
const double _chipHeight = 36.0;
const double _chipRowHeight = 48.0;
const double _disabledOpacity = 0.35;

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

  bool get _isSentences => _contentIndex == 2;

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

  void _onContentSelected(int i) {
    setState(() {
      _contentIndex = i;
      // Cards not supported for sentences — auto-switch to keyboard.
      if (i == 2 && _modeIndex == 0) _modeIndex = 1;
    });
  }

  Future<void> _start() async {
    await ref.read(morseExerciseProvider.notifier).startExercise(
          _contentType,
          _direction,
          _interactionType,
          _counts[_repetitionIndex],
        );
    if (mounted) context.pushNamed(RouteNames.morseExerciseSession);
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
              onSelected: _onContentSelected,
            ),
            const SizedBox(height: AppSpacing.xl),

            _SectionLabel('NAČIN VADBE'),
            const SizedBox(height: AppSpacing.sm),
            _ModeChipRow(
              options: const ['Kartice', 'Tipkovnica', 'Žetoni'],
              selectedIndex: _modeIndex,
              disabledIndices: _isSentences ? const {0} : const {},
              onSelected: (i) => setState(() => _modeIndex = i),
            ),
            if (_isSentences) ...[
              const SizedBox(height: AppSpacing.sm),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.xl),
                child: Text(
                  'Stavki so na voljo samo v tipkovničnem načinu',
                  style: AppTypography.caption
                      .copyWith(color: AppColors.textTertiary),
                ),
              ),
            ],
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

class _ModeChipRow extends StatelessWidget {
  const _ModeChipRow({
    required this.options,
    required this.selectedIndex,
    required this.disabledIndices,
    required this.onSelected,
  });

  final List<String> options;
  final int selectedIndex;
  final Set<int> disabledIndices;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _chipRowHeight,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
        itemCount: options.length,
        separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.sm),
        itemBuilder: (_, index) {
          final isSelected = index == selectedIndex;
          final isDisabled = disabledIndices.contains(index);
          return SizedBox(
            height: _chipRowHeight,
            child: GestureDetector(
              onTap: isDisabled ? null : () => onSelected(index),
              child: Opacity(
                opacity: isDisabled ? _disabledOpacity : 1.0,
                child: Center(
                  child: Container(
                    height: _chipHeight,
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.base),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primary
                          : AppColors.surface,
                      borderRadius: BorderRadius.circular(_chipRadius),
                      border: isSelected
                          ? null
                          : Border.all(
                              color: AppColors.textTertiary, width: 1),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      options[index],
                      style: AppTypography.filterChip.copyWith(
                        color: isSelected
                            ? AppColors.textPrimary
                            : AppColors.textSecondary,
                        fontWeight: isSelected
                            ? FontWeight.w600
                            : FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
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
