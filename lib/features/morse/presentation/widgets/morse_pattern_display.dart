import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

/// Renders a morse sequence (e.g. ".-" or "-.." ) as visual dot/dash shapes.
///
/// Dots   → 8×8 dp circles     (AppColors.accent)
/// Dashes → 24×8 dp rounded rectangles (AppColors.accent)
/// Spaces → letter-gap (8 dp)
/// '/'    → word-gap  (20 dp)
class MorsePatternDisplay extends StatelessWidget {
  const MorsePatternDisplay({
    super.key,
    required this.morseSequence,
  });

  final String morseSequence;

  static const _dotSize = 8.0;
  static const _dashWidth = 24.0;
  static const _dashHeight = 8.0;
  static const _symbolSpacing = 4.0;
  static const _letterGap = 8.0;
  static const _wordGap = 20.0;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: _symbolSpacing,
      runSpacing: _symbolSpacing,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: _buildSymbols(),
    );
  }

  List<Widget> _buildSymbols() {
    final result = <Widget>[];
    for (final char in morseSequence.split('')) {
      switch (char) {
        case '.':
          result.add(_dot());
        case '-':
          result.add(_dash());
        case '/':
          result.add(const SizedBox(width: _wordGap));
        case ' ':
          result.add(const SizedBox(width: _letterGap));
      }
    }
    return result;
  }

  Widget _dot() => Container(
        width: _dotSize,
        height: _dotSize,
        decoration: const BoxDecoration(
          color: AppColors.textPrimary,
          shape: BoxShape.circle,
        ),
      );

  Widget _dash() => Container(
        width: _dashWidth,
        height: _dashHeight,
        decoration: BoxDecoration(
          color: AppColors.textPrimary,
          borderRadius: BorderRadius.circular(4),
        ),
      );
}
