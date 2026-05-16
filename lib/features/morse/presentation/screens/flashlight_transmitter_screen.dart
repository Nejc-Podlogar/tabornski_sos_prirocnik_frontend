import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/platform/platform_features_provider.dart';
import '../../../../core/platform/torch/torch_service_provider.dart';
import '../../../../core/routing/route_names.dart';

class FlashlightTransmitterScreen extends ConsumerStatefulWidget {
  const FlashlightTransmitterScreen({
    super.key,
    this.initialMorse = '',
  });

  final String initialMorse;

  @override
  ConsumerState<FlashlightTransmitterScreen> createState() =>
      _FlashlightTransmitterScreenState();
}

class _FlashlightTransmitterScreenState
    extends ConsumerState<FlashlightTransmitterScreen> {
  late String _morse;
  bool _isLooping = false;
  bool _isTransmitting = false;
  bool _torchOn = false;
  late bool _isSheetExpanded;

  @override
  void initState() {
    super.initState();
    _morse = widget.initialMorse;
    _isSheetExpanded = _morse.isNotEmpty;
  }

  @override
  void dispose() {
    _isTransmitting = false;
    unawaited(ref.read(torchServiceProvider).stop());
    super.dispose();
  }

  Future<void> _toggleTorch() async {
    final newState = !_torchOn;
    setState(() => _torchOn = newState);
    await ref.read(torchServiceProvider).setTorch(newState);
  }

  Future<void> _transmit() async {
    if (_morse.isEmpty || _isTransmitting) return;
    setState(() => _isTransmitting = true);
    try {
      await ref.read(torchServiceProvider).transmit(_morse, loop: _isLooping);
    } finally {
      if (mounted) setState(() => _isTransmitting = false);
    }
  }

  void _stop() {
    unawaited(ref.read(torchServiceProvider).stop());
    if (mounted) setState(() => _isTransmitting = false);
  }

  void _appendMorse(String char) {
    if (_isTransmitting) return;
    HapticFeedback.lightImpact();
    setState(() {
      if (char == ' ' && (_morse.isEmpty || _morse.endsWith(' '))) return;
      _morse += char;
    });
  }

  void _backspace() {
    if (_isTransmitting || _morse.isEmpty) return;
    HapticFeedback.lightImpact();
    setState(() => _morse = _morse.substring(0, _morse.length - 1));
  }

  void _clearMorse() {
    if (_isTransmitting) return;
    setState(() => _morse = '');
  }

  @override
  Widget build(BuildContext context) {
    final isAvailable = ref.watch(platformFeaturesProvider).isTorchAvailable;

    return Scaffold(
      backgroundColor: AppColors.backgroundPure,
      body: SafeArea(
        child: Column(
          children: [
            // Torch area — expands to fill remaining space
            Expanded(
              child: Stack(
                children: [
                  // Back button
                  Positioned(
                    top: 8,
                    left: 4,
                    child: IconButton(
                      onPressed: () {
                        if (context.canPop()) {
                          context.pop();
                        } else {
                          context.goNamed(RouteNames.morse);
                        }
                      },
                      icon: const HugeIcon(
                        icon: HugeIcons.strokeRoundedArrowLeft02,
                        color: AppColors.textTertiary,
                        size: 22,
                      ),
                    ),
                  ),

                  // Torch circle
                  Center(
                    child: isAvailable
                        ? GestureDetector(
                            onTap: _isTransmitting ? null : _toggleTorch,
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 80),
                              width: 160,
                              height: 160,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _torchOn
                                    ? AppColors.torchGlow
                                    : AppColors.surface,
                                boxShadow: _torchOn
                                    ? [
                                        BoxShadow(
                                          color: AppColors.torchGlow
                                              .withValues(alpha: 0.4),
                                          blurRadius: 48,
                                          spreadRadius: 12,
                                        ),
                                      ]
                                    : null,
                              ),
                              child: Center(
                                child: HugeIcon(
                                  icon: HugeIcons.strokeRoundedFlashlight,
                                  color: _torchOn
                                      ? AppColors.backgroundPure
                                      : AppColors.textTertiary,
                                  size: 56,
                                ),
                              ),
                            ),
                          )
                        : Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const HugeIcon(
                                icon: HugeIcons.strokeRoundedFlashlight,
                                color: AppColors.textTertiary,
                                size: 48,
                              ),
                              const SizedBox(height: AppSpacing.md),
                              Text(
                                'Svetilka ni na voljo\nna tej napravi.',
                                style: AppTypography.body
                                    .copyWith(color: AppColors.textTertiary),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                  ),
                ],
              ),
            ),

            // Bottom panel — content-sized
            _buildSheet(),
          ],
        ),
      ),
    );
  }

  Widget _buildSheet() {
    return GestureDetector(
      onVerticalDragEnd: (details) {
        final v = details.primaryVelocity ?? 0;
        if (v < -80) {
          setState(() => _isSheetExpanded = true);
        } else if (v > 80) {
          setState(() => _isSheetExpanded = false);
        }
      },
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.base,
          AppSpacing.sm,
          AppSpacing.base,
          AppSpacing.base,
        ),
        child: AnimatedSize(
          duration: const Duration(milliseconds: 280),
          curve: Curves.easeOutCubic,
          alignment: Alignment.bottomCenter,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Drag handle — always visible
              GestureDetector(
                onTap: () =>
                    setState(() => _isSheetExpanded = !_isSheetExpanded),
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: const EdgeInsets.only(
                      bottom: AppSpacing.xl, top: AppSpacing.sm),
                  child: Center(
                    child: Container(
                      width: 36,
                      height: 4,
                      decoration: BoxDecoration(
                        color: AppColors.textTertiary.withValues(alpha: 0.35),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                ),
              ),

              if (_isSheetExpanded) ...[
                Row(
                  children: [
                    Expanded(child: _buildMorseDisplay()),
                    const SizedBox(width: AppSpacing.sm),
                    _buildTrashButton(),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
                _buildMorseKeyboard(),
                const SizedBox(height: AppSpacing.xxl),
                const SizedBox(height: AppSpacing.xxl),
                _buildModeSelector(),
                const SizedBox(height: AppSpacing.md),
                _buildTransmitButton(),
              ] else ...[
                Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      HugeIcon(
                        icon: HugeIcons.strokeRoundedTextSelect,
                        color: AppColors.textSecondary,
                        size: 24,
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Text(
                        'Oddajanje besedila',
                        style: AppTypography.cardTitle
                            .copyWith(color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMorseDisplay() {
    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _morse.isEmpty
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
            _morse.isEmpty ? 'Vnesi morsejevo abecedo' : _morse,
            style: _morse.isEmpty
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
    final active = _morse.isNotEmpty && !_isTransmitting;
    return GestureDetector(
      onTap: active ? _clearMorse : null,
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

  Widget _buildTransmitButton() {
    final canTransmit = _morse.isNotEmpty;
    final disabledColor = AppColors.textTertiary.withValues(alpha: 0.35);
    return GestureDetector(
      onTap: canTransmit ? (_isTransmitting ? _stop : _transmit) : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        height: 52,
        decoration: BoxDecoration(
          color: !canTransmit
              ? AppColors.background
              : _isTransmitting
                  ? AppColors.danger
                  : AppColors.primary,
          borderRadius: BorderRadius.circular(12),
          border:
              !canTransmit ? Border.all(color: disabledColor, width: 1) : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            HugeIcon(
              icon: _isTransmitting
                  ? HugeIcons.strokeRoundedStop
                  : HugeIcons.strokeRoundedFlashlight,
              color: canTransmit ? Colors.white : disabledColor,
              size: 20,
            ),
            const SizedBox(width: AppSpacing.sm),
            Text(
              _isTransmitting ? 'Ustavi' : 'Oddaj',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: canTransmit ? Colors.white : disabledColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMorseKeyboard() {
    return Row(
      children: [
        _MorseKey(
          label: ' ',
          onTap: () => _appendMorse(' '),
          muted: true,
          icon: HugeIcons.strokeRoundedLetterSpacing,
          sublabel: 'črka',
        ),
        const SizedBox(width: AppSpacing.sm),
        _MorseKey(label: '·', onTap: () => _appendMorse('.')),
        const SizedBox(width: AppSpacing.sm),
        _MorseKey(label: '—', onTap: () => _appendMorse('-'), flex: 2),
        const SizedBox(width: AppSpacing.sm),
        _MorseKey(
          label: '/',
          onTap: () => _appendMorse('/'),
          muted: true,
          icon: HugeIcons.strokeRoundedText,
          sublabel: 'beseda',
        ),
        const SizedBox(width: AppSpacing.sm),
        _MorseKey(
          label: '',
          onTap: _backspace,
          muted: true,
          icon: HugeIcons.strokeRoundedEraser01,
          rotateIcon: true,
        ),
      ],
    );
  }

  Widget _buildModeSelector() {
    return Row(
      children: [
        Expanded(
          child: _ModeChip(
            label: 'Enkratno',
            isSelected: !_isLooping,
            onTap: () => setState(() => _isLooping = false),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: _ModeChip(
            label: 'Zanki',
            isSelected: _isLooping,
            onTap: () => setState(() => _isLooping = true),
          ),
        ),
      ],
    );
  }
}

// ─── Morse keyboard key ───────────────────────────────────────────────────────

class _MorseKey extends StatelessWidget {
  const _MorseKey({
    required this.label,
    required this.onTap,
    this.flex = 1,
    this.muted = false,
    this.icon,
    this.sublabel,
    this.rotateIcon = false,
  });

  final String label;
  final VoidCallback onTap;
  final int flex;
  final bool muted;
  final List<List<dynamic>>? icon;
  final String? sublabel;
  final bool rotateIcon;

  @override
  Widget build(BuildContext context) {
    final color = muted ? AppColors.textSecondary : AppColors.primaryLight;

    Widget child;
    if (icon != null && sublabel != null) {
      child = Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          HugeIcon(icon: icon!, color: color, size: 18),
          const SizedBox(height: 2),
          Text(
            sublabel!,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      );
    } else if (icon != null) {
      final iconWidget = HugeIcon(icon: icon!, color: color, size: 22);
      child = rotateIcon
          ? RotatedBox(quarterTurns: 2, child: iconWidget)
          : iconWidget;
    } else {
      child = Text(
        label,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: color,
        ),
      );
    }

    return Expanded(
      flex: flex,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 56,
          decoration: BoxDecoration(
            color: muted
                ? AppColors.background
                : AppColors.primaryDark.withValues(alpha: 0.25),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: muted
                  ? AppColors.textTertiary.withValues(alpha: 0.25)
                  : AppColors.primaryDark,
              width: 1,
            ),
          ),
          child: Center(child: child),
        ),
      ),
    );
  }
}

// ─── Mode chip ────────────────────────────────────────────────────────────────

class _ModeChip extends StatelessWidget {
  const _ModeChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 44,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.background,
          borderRadius: BorderRadius.circular(22),
          border: isSelected
              ? null
              : Border.all(
                  color: AppColors.textTertiary.withValues(alpha: 0.35),
                  width: 1,
                ),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: AppTypography.filterChip.copyWith(
            color: isSelected ? AppColors.textPrimary : AppColors.textSecondary,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
