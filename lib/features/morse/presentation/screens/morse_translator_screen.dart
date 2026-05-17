import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/platform/audio/audio_morse_service_provider.dart';
import '../../../../core/platform/audio/i_audio_morse_service.dart';
import '../../../../core/platform/morse_timing_constants.dart';
import '../../../../core/platform/platform_features_provider.dart';
import '../../../../core/routing/route_names.dart';
import '../../../../core/widgets/app_header_bar.dart';
import '../../../../core/widgets/primary_cta_button.dart';
import '../../../../core/widgets/segmented_control.dart';
import '../../../../core/domain/value_objects/exercise_enums.dart';
import '../providers/morse_translation_provider.dart';
import '../widgets/direction_label.dart';
import '../widgets/morse_input_field.dart';
import '../widgets/morse_output_field.dart';
import '../widgets/stop_button.dart';
import '../widgets/transmitting_button.dart';

class MorseTranslatorScreen extends ConsumerStatefulWidget {
  const MorseTranslatorScreen({super.key});

  @override
  ConsumerState<MorseTranslatorScreen> createState() =>
      _MorseTranslatorScreenState();
}

class _MorseTranslatorScreenState extends ConsumerState<MorseTranslatorScreen>
    with SingleTickerProviderStateMixin {
  late final TextEditingController _controller;
  late final AnimationController _waveController;
  late final IAudioMorseService _audioService;
  late final ProviderContainer _container;
  bool _isTransmitting = false;
  double _transmitProgress = 0.0;
  String _transmittingMorse = '';
  StreamSubscription<double>? _progressSub;

  @override
  void initState() {
    super.initState();
    _container = ProviderScope.containerOf(context, listen: false);
    _audioService = ref.read(audioMorseServiceProvider);
    _controller = TextEditingController(
      text: ref.read(morseTranslationProvider).inputText,
    );
    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: MorseTimingConstants.waveAnimationMs),
    );
  }

  @override
  void dispose() {
    _progressSub?.cancel();
    unawaited(_audioService.stop());
    _container.read(morseTranslationProvider.notifier).clear();
    _waveController.dispose();
    _controller.dispose();
    super.dispose();
  }

  Future<void> _transmit(String morseOutput) async {
    if (morseOutput.isEmpty || _isTransmitting) return;
    setState(() {
      _isTransmitting = true;
      _transmitProgress = 0.0;
      _transmittingMorse = morseOutput;
    });
    _waveController.repeat();
    _progressSub = ref.read(audioMorseServiceProvider).progress.listen((p) {
      if (!mounted) return;
      setState(() => _transmitProgress = p);
      if (p >= 1.0) {
        _waveController.stop();
      } else if (p == 0.0 && !_waveController.isAnimating) {
        _waveController.repeat();
      }
    });
    try {
      await ref.read(audioMorseServiceProvider).transmit(morseOutput);
    } finally {
      await _progressSub?.cancel();
      _progressSub = null;
      if (mounted) {
        _waveController
          ..stop()
          ..reset();
        setState(() {
          _isTransmitting = false;
          _transmitProgress = 0.0;
          _transmittingMorse = '';
        });
      }
    }
  }

  void _stop() {
    _progressSub?.cancel();
    _progressSub = null;
    unawaited(ref.read(audioMorseServiceProvider).stop());
    if (mounted) {
      _waveController
        ..stop()
        ..reset();
      setState(() {
        _isTransmitting = false;
        _transmitProgress = 0.0;
        _transmittingMorse = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<MorseTranslationState>(morseTranslationProvider, (prev, next) {
      if (next.inputText != _controller.text) {
        _controller.text = next.inputText;
        _controller.selection =
            TextSelection.collapsed(offset: next.inputText.length);
      }
    });

    final state = ref.watch(morseTranslationProvider);
    final isTorchAvailable =
        ref.watch(platformFeaturesProvider).isTorchAvailable;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppHeaderBar(
        title: 'Prevajalnik',
        showBackButton: true,
        showSettingsButton: false,
        onSettingsPressed: () => context.goNamed(RouteNames.settings),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.base),
        child: Column(
          children: [
            // Direction toggle
            SegmentedControl(
              selectedIndex:
                  state.direction == TranslationDirection.textToMorse ? 0 : 1,
              onChanged: (_) =>
                  ref.read(morseTranslationProvider.notifier).swapDirection(),
              children: const [
                DirectionLabel(textFirst: true),
                DirectionLabel(textFirst: false),
              ],
            ),
            const SizedBox(height: AppSpacing.base),

            // Input field
            Expanded(
              child: MorseInputField(
                controller: _controller,
                label: state.direction == TranslationDirection.textToMorse
                    ? 'BESEDILO'
                    : 'MORSE',
                hintText: 'Vnesi besedilo...',
                onClear: () =>
                    ref.read(morseTranslationProvider.notifier).clear(),
                onChanged: (text) =>
                    ref.read(morseTranslationProvider.notifier).setInput(text),
              ),
            ),
            const SizedBox(height: AppSpacing.md),

            // Output field
            Expanded(
              child: MorseOutputField(
                text: state.outputText,
                label: state.direction == TranslationDirection.textToMorse
                    ? 'MORSE'
                    : 'BESEDILO',
                onCopy: () =>
                    Clipboard.setData(ClipboardData(text: state.outputText)),
              ),
            ),
            const SizedBox(height: AppSpacing.base),

            // Action buttons
            Row(
              children: [
                if (!_isTransmitting && isTorchAvailable) ...[
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => context.pushNamed(
                        RouteNames.morseFlashlight,
                        extra: state.direction ==
                                TranslationDirection.textToMorse
                            ? state.outputText
                            : '',
                      ),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppColors.primary),
                        shape: const StadiumBorder(),
                        padding:
                            const EdgeInsets.symmetric(vertical: AppSpacing.md),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const HugeIcon(
                            icon: HugeIcons.strokeRoundedFlashlight,
                            color: AppColors.primary,
                            size: 18,
                          ),
                          const SizedBox(width: AppSpacing.xs),
                          Text(
                            'BLISKANJE',
                            style: AppTypography.filterChip.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                ],
                if (_isTransmitting) ...[
                  Expanded(
                    child: TransmittingButton(
                      animation: _waveController,
                      progress: _transmitProgress,
                      morseSequence: _transmittingMorse,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  StopButton(onPressed: _stop),
                ] else
                  Expanded(
                    child: PrimaryCtaButton(
                      label: 'Predvajaj',
                      onPressed: state.outputText.isNotEmpty
                          ? () => _transmit(state.outputText)
                          : null,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
