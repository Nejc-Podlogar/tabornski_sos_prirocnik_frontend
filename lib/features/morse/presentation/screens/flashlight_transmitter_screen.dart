import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/platform/platform_features_provider.dart';
import '../../../../core/platform/torch/torch_service_provider.dart';
import '../../../../core/routing/route_names.dart';
import '../../../../core/widgets/app_header_bar.dart';
import '../providers/morse_translation_provider.dart';
import '../widgets/morse_pattern_display.dart';

class FlashlightTransmitterScreen extends ConsumerStatefulWidget {
  const FlashlightTransmitterScreen({super.key});

  @override
  ConsumerState<FlashlightTransmitterScreen> createState() =>
      _FlashlightTransmitterScreenState();
}

class _FlashlightTransmitterScreenState
    extends ConsumerState<FlashlightTransmitterScreen> {
  bool _isLooping = false;
  bool _isTransmitting = false;
  bool _torchOn = false;

  Future<void> _toggleTorch() async {
    final newState = !_torchOn;
    setState(() => _torchOn = newState);
    await ref.read(torchServiceProvider).setTorch(newState);
  }

  Future<void> _transmit(String morseOutput) async {
    if (morseOutput.isEmpty || _isTransmitting) return;
    setState(() => _isTransmitting = true);
    try {
      await ref
          .read(torchServiceProvider)
          .transmit(morseOutput, loop: _isLooping);
    } finally {
      if (mounted) setState(() => _isTransmitting = false);
    }
  }

  void _stop() {
    unawaited(ref.read(torchServiceProvider).stop());
    if (mounted) setState(() => _isTransmitting = false);
  }

  @override
  void dispose() {
    _isTransmitting = false;
    unawaited(ref.read(torchServiceProvider).stop()); // no setState
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isAvailable =
        ref.watch(platformFeaturesProvider).isTorchAvailable;
    final morseOutput =
        ref.watch(morseTranslationProvider.select((s) => s.outputText));

    return Scaffold(
      backgroundColor: AppColors.backgroundPure,
      appBar: AppHeaderBar(
        title: 'Bliskanje',
        showBackButton: true,
        onSettingsPressed: () => context.goNamed(RouteNames.settings),
      ),
      body: SafeArea(
        child: isAvailable
            ? _buildTorchControls(morseOutput)
            : _buildUnavailable(),
      ),
    );
  }

  Widget _buildUnavailable() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Text(
          'Svetilka ni na voljo\nna tej napravi.',
          style: AppTypography.body.copyWith(color: AppColors.textTertiary),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildTorchControls(String morseOutput) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Column(
        children: [
          const Spacer(),

          // Torch circle — tap to toggle manually
          GestureDetector(
            onTap: _isTransmitting ? null : _toggleTorch,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 80),
              width: 160,
              height: 160,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _torchOn ? AppColors.torchGlow : AppColors.surface,
                boxShadow: _torchOn
                    ? [
                        BoxShadow(
                          color: AppColors.torchGlow.withOpacity(0.4),
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
          ),
          const SizedBox(height: AppSpacing.base),
          Text(
            _torchOn ? 'VKLOPLJENO' : 'Tapni za preklop',
            style: AppTypography.caption.copyWith(
              color: _torchOn ? AppColors.torchGlow : AppColors.textTertiary,
              letterSpacing: 1.2,
            ),
          ),

          const Spacer(),

          // Morse sequence visual
          if (morseOutput.isNotEmpty) ...[
            Text(
              'ZAPOREDJE',
              style:
                  AppTypography.overline.copyWith(color: AppColors.textTertiary),
            ),
            const SizedBox(height: AppSpacing.sm),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSpacing.base),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(12),
              ),
              child: MorsePatternDisplay(morseSequence: morseOutput),
            ),
            const SizedBox(height: AppSpacing.xl),
          ],

          // Mode chips
          Text(
            'NAČIN',
            style:
                AppTypography.overline.copyWith(color: AppColors.textTertiary),
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _ModeChip(
                label: 'Enkratno',
                isSelected: !_isLooping,
                onTap: () => setState(() => _isLooping = false),
              ),
              const SizedBox(width: AppSpacing.sm),
              _ModeChip(
                label: 'Zanki',
                isSelected: _isLooping,
                onTap: () => setState(() => _isLooping = true),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xl),

          // Transmit / Stop button
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: morseOutput.isEmpty
                  ? null
                  : _isTransmitting
                      ? _stop
                      : () => _transmit(morseOutput),
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    _isTransmitting ? AppColors.danger : AppColors.primary,
                disabledBackgroundColor: AppColors.surface,
                shape: const StadiumBorder(),
              ),
              child: Text(
                _isTransmitting ? 'USTAVI' : 'POŠLJI',
                style: AppTypography.buttonLabel,
              ),
            ),
          ),

          const SizedBox(height: AppSpacing.base),
        ],
      ),
    );
  }
}

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
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.surface,
          borderRadius: BorderRadius.circular(24),
          border: isSelected
              ? null
              : Border.all(color: AppColors.textTertiary, width: 1),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: AppTypography.filterChip.copyWith(
            color: isSelected
                ? AppColors.textPrimary
                : AppColors.textSecondary,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
