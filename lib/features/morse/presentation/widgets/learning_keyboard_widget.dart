import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/domain/value_objects/exercise_enums.dart';
import '../../../../core/domain/value_objects/exercise_validation.dart';
import '../../../../core/widgets/primary_cta_button.dart';
import '../../../../core/widgets/progress_dots_row.dart';
import '../../domain/entities/morse_exercise.dart';
import '../providers/morse_exercise_provider.dart';
import 'morse_key.dart';
import 'morse_pattern_display.dart';

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
      setState(() => _controller.text = '');
    }
  }

  void _check() {
    if (_controller.text.trim().isEmpty) return;
    final notifier = ref.read(morseExerciseProvider.notifier);
    notifier.validateAnswer(_controller.text);
    notifier.nextExercise();
  }

  void _appendChar(String char) {
    HapticFeedback.lightImpact();
    setState(() {
      if (char == ' ' &&
          (_controller.text.isEmpty || _controller.text.endsWith(' '))) {
        return;
      }
      _controller.text += char;
    });
  }

  void _backspace() {
    if (_controller.text.isEmpty) return;
    HapticFeedback.lightImpact();
    setState(() {
      _controller.text =
          _controller.text.substring(0, _controller.text.length - 1);
    });
  }

  Widget _buildPromptCard() {
    const decoration = BoxDecoration(
      color: AppColors.surface,
      borderRadius: BorderRadius.all(Radius.circular(16)),
      border: Border.fromBorderSide(
          BorderSide(color: AppColors.primaryDark, width: 1)),
    );
    const padding = EdgeInsets.symmetric(
      horizontal: AppSpacing.xl,
      vertical: AppSpacing.xxl,
    );

    if (widget.exercise.direction == TranslationDirection.morseToText) {
      return Container(
        width: double.infinity,
        padding: padding,
        decoration: decoration,
        child: MorsePatternDisplay(
          morseSequence: widget.exercise.exerciseValues[0],
          color: AppColors.textPrimary,
        ),
      );
    }

    return Container(
      width: double.infinity,
      padding: padding,
      decoration: decoration,
      child: Text(
        widget.exercise.exerciseValues[0],
        style: AppTypography.screenTitle.copyWith(
          fontSize: 52,
          color: AppColors.textPrimary,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildMorseDisplay() {
    final text = _controller.text;
    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: text.isEmpty
              ? AppColors.textTertiary.withValues(alpha: 0.2)
              : AppColors.primaryDark,
          width: 1,
        ),
      ),
      child: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          reverse: true,
          child: Text(
            text.isEmpty ? 'Vnesi Morse zaporedje…' : text,
            style: text.isEmpty
                ? AppTypography.body.copyWith(color: AppColors.textTertiary)
                : AppTypography.morseSequence.copyWith(
                    fontSize: 17,
                    color: AppColors.primaryLight,
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildTrashButton() {
    final active = _controller.text.isNotEmpty;
    return GestureDetector(
      onTap: active ? () => setState(() => _controller.text = '') : null,
      child: Container(
        width: 52,
        height: 52,
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: active
                ? AppColors.danger
                : AppColors.textTertiary.withValues(alpha: 0.35),
            width: 1,
          ),
        ),
        child: Center(
          child: HugeIcon(
            icon: HugeIcons.strokeRoundedDelete02,
            color: active
                ? AppColors.danger
                : AppColors.textTertiary.withValues(alpha: 0.35),
            size: 20,
          ),
        ),
      ),
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

    if (widget.exercise.direction == TranslationDirection.morseToText) {
      return _buildTextLayout(boolResults);
    }
    return _buildMorseLayout(boolResults);
  }

  Widget _buildTextLayout(List<bool?> boolResults) {
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
          _buildPromptCard(),
          const SizedBox(height: AppSpacing.xl),
          TextField(
            controller: _controller,
            autofocus: true,
            style: AppTypography.body.copyWith(color: AppColors.textPrimary),
            textCapitalization: TextCapitalization.characters,
            decoration: InputDecoration(
              hintText: 'Vnesi črko ali besedo…',
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
          const Spacer(),
          PrimaryCtaButton(label: 'Preveri', onPressed: _check),
        ],
      ),
    );
  }

  Widget _buildMorseLayout(List<bool?> boolResults) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.base,
            AppSpacing.base,
            AppSpacing.base,
            0,
          ),
          child: ProgressDotsRow(
            total: widget.total,
            currentIndex: widget.currentIndex,
            results: boolResults,
          ),
        ),
        Expanded(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.base),
              child: _buildPromptCard(),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.base,
            0,
            AppSpacing.base,
            AppSpacing.md,
          ),
          child: Row(
            children: [
              Expanded(child: _buildMorseDisplay()),
              const SizedBox(width: AppSpacing.sm),
              _buildTrashButton(),
            ],
          ),
        ),
        _MorseInputKeyboard(
          onDot: () => _appendChar('.'),
          onDash: () => _appendChar('-'),
          onSpace: () => _appendChar(' '),
          onSlash: () => _appendChar('/'),
          onBackspace: _backspace,
          onCheck: _check,
        ),
      ],
    );
  }
}

class _MorseInputKeyboard extends StatelessWidget {
  const _MorseInputKeyboard({
    required this.onDot,
    required this.onDash,
    required this.onSpace,
    required this.onSlash,
    required this.onBackspace,
    required this.onCheck,
  });

  final VoidCallback onDot;
  final VoidCallback onDash;
  final VoidCallback onSpace;
  final VoidCallback onSlash;
  final VoidCallback onBackspace;
  final VoidCallback onCheck;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      padding: EdgeInsets.fromLTRB(
        AppSpacing.base,
        AppSpacing.base,
        AppSpacing.base,
        AppSpacing.base + MediaQuery.of(context).padding.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              MorseKey(
                icon: HugeIcons.strokeRoundedLetterSpacing,
                sublabel: 'črka',
                onTap: onSpace,
                muted: true,
              ),
              const SizedBox(width: AppSpacing.sm),
              MorseKey(label: '·', onTap: onDot),
              const SizedBox(width: AppSpacing.sm),
              MorseKey(label: '—', onTap: onDash, isWide: true),
              const SizedBox(width: AppSpacing.sm),
              MorseKey(
                icon: HugeIcons.strokeRoundedText,
                sublabel: 'beseda',
                onTap: onSlash,
                muted: true,
              ),
              const SizedBox(width: AppSpacing.sm),
              MorseKey(
                icon: HugeIcons.strokeRoundedEraser01,
                onTap: onBackspace,
                muted: true,
                rotateIcon: true,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xxxl),
          PrimaryCtaButton(label: 'Preveri', onPressed: onCheck),
        ],
      ),
    );
  }
}
