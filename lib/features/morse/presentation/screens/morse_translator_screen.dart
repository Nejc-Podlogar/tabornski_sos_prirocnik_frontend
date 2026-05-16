import 'dart:async';
import 'dart:math' as math;

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
import '../../../../core/platform/platform_features_provider.dart';
import '../../../../core/routing/route_names.dart';
import '../../../../core/widgets/app_header_bar.dart';
import '../../../../core/widgets/primary_cta_button.dart';
import '../../../../core/widgets/segmented_control.dart';
import '../../../../core/domain/value_objects/exercise_enums.dart';
import '../providers/morse_translation_provider.dart';

// ─── Direction toggle helpers ────────────────────────────────────────────────

class _DirectionLabel extends StatelessWidget {
  const _DirectionLabel({required this.textFirst});

  final bool textFirst;

  @override
  Widget build(BuildContext context) {
    const textWidget = Text(
      'Besedilo',
      style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
    );
    const arrowWidget = HugeIcon(
      icon: HugeIcons.strokeRoundedArrowRight02,
      color: AppColors.textPrimary,
      size: 14,
    );
    const morseWidget = _MorseDotDash();

    final items = textFirst
        ? [textWidget, arrowWidget, morseWidget]
        : [morseWidget, arrowWidget, textWidget];

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < items.length; i++) ...[
          if (i > 0) const SizedBox(width: 9),
          items[i],
        ],
      ],
    );
  }
}

class _MorseDotDash extends StatelessWidget {
  const _MorseDotDash();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 4,
          height: 4,
          decoration: const BoxDecoration(
            color: AppColors.textPrimary,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 4),
        Container(
          width: 13,
          height: 3,
          decoration: BoxDecoration(
            color: AppColors.textPrimary,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
      ],
    );
  }
}

// ─── Transmitting UI widgets ─────────────────────────────────────────────────

class _SquigglyWavePainter extends CustomPainter {
  _SquigglyWavePainter({
    required this.animation,
    required this.progress,
    required this.color,
    required this.morseSequence,
  }) : super(repaint: animation) {
    _buildSegments();
  }

  final Animation<double> animation;
  final double progress;
  final Color color;
  final String morseSequence;

  // (startMs, endMs, isDash)
  late final List<(int, int, bool)> _toneSegments;
  late final int _totalMs;

  static const double _silenceAmplitude = 1.5;
  static const double _dotAmplitude = 4.0;
  static const double _dashAmplitude = 9.0;
  static const double _wavelength = 20.0;
  // Fixed pixels-per-ms so curves never compress; long sequences scroll left.
  static const double _pxPerMs = 0.1;
  // Smoothstep fade window at each tone boundary (in ms = 8 px at _pxPerMs).
  static const double _fadeMs = 80.0;
  static const double _sepGap = 5.0;
  static const double _sepHalfH = 10.0;

  void _buildSegments() {
    final segs = <(int, int, bool)>[];
    var t = 0;
    for (final ch in morseSequence.split('')) {
      switch (ch) {
        case '.':
          segs.add((t, t + 200, false));
          t += 400;
        case '-':
          segs.add((t, t + 600, true));
          t += 800;
        case ' ':
          t += 400;
        case '/':
          t += 400;
      }
    }
    _toneSegments = segs;
    _totalMs = t == 0 ? 1 : t;
  }

  double _amplitudeAt(double ms) {
    var amp = _silenceAmplitude;
    for (final (start, end, isDash) in _toneSegments) {
      final s = start.toDouble();
      final e = end.toDouble();
      if (ms < s - _fadeMs || ms > e + _fadeMs) continue;

      // t: 0 = silence edge, 1 = fully inside tone
      double t;
      if (ms < s) {
        t = (ms - (s - _fadeMs)) / _fadeMs;
      } else if (ms > e) {
        t = 1.0 - (ms - e) / _fadeMs;
      } else {
        t = 1.0;
      }
      t = t.clamp(0.0, 1.0);
      // Smoothstep: zero slope at both endpoints → no kink at boundaries
      t = t * t * (3.0 - 2.0 * t);

      final toneAmp = isDash ? _dashAmplitude : _dotAmplitude;
      amp = math.max(amp, _silenceAmplitude + (toneAmp - _silenceAmplitude) * t);
    }
    return amp;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final cy = size.height / 2;
    final trackEnd = size.width - 8;
    final thumbX = (progress * trackEnd).clamp(0.0, trackEnd);
    final waveClip = (thumbX - _sepGap).clamp(0.0, trackEnd);
    final phase = animation.value * 2 * math.pi;

    final wavePaint = Paint()
      ..color = color
      ..strokeWidth = 2.8
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    // Fixed-scale scrolling wave: played content is right-aligned at the thumb.
    // Long sequences scroll left (old content hides) rather than compressing.
    if (waveClip > 0) {
      // ms value at x=0 (leftmost visible pixel)
      final ms0 = _totalMs * progress - thumbX / _pxPerMs;
      final path = Path();
      for (double x = 0; x <= waveClip; x++) {
        final ms = ms0 + x / _pxPerMs;
        final amp =
          (ms < 0 || ms >= _totalMs) ? _silenceAmplitude : _amplitudeAt(ms);
        final y = cy + amp * math.sin(2 * math.pi * x / _wavelength - phase);
        if (x == 0) {
          path.moveTo(x, y);
        } else {
          path.lineTo(x, y);
        }
      }
      canvas.drawPath(path, wavePaint);
    }

    // Thumb separator
    canvas.drawLine(
      Offset(thumbX, cy - _sepHalfH),
      Offset(thumbX, cy + _sepHalfH),
      Paint()
        ..color = color
        ..strokeWidth = 2.8
        ..strokeCap = StrokeCap.round,
    );

    // Remaining flat track
    final trackStart = thumbX + _sepGap;
    if (trackStart < trackEnd - 2) {
      canvas.drawLine(
        Offset(trackStart, cy),
        Offset(trackEnd, cy),
        Paint()
          ..color = color.withValues(alpha: 0.22)
          ..strokeWidth = 1.6
          ..strokeCap = StrokeCap.round,
      );
    }

    // End dot
    canvas.drawCircle(
      Offset(size.width - 3, cy),
      3.2,
      Paint()
        ..color = color.withValues(alpha: 0.45)
        ..style = PaintingStyle.fill,
    );
  }

  @override
  bool shouldRepaint(_SquigglyWavePainter old) =>
      old.progress != progress ||
      old.morseSequence != morseSequence ||
      old.color != color;
}

class _TransmittingButton extends StatelessWidget {
  const _TransmittingButton({
    required this.animation,
    required this.progress,
    required this.morseSequence,
  });

  final Animation<double> animation;
  final double progress;
  final String morseSequence;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (_, child) {
        final pulse = (math.sin(animation.value * 2 * math.pi) + 1) / 2;
        return Container(
          height: 52,
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(26),
            border: Border.all(color: AppColors.primaryDark, width: 1),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.12 + 0.2 * pulse),
                blurRadius: 12 + 18 * pulse,
                spreadRadius: pulse * 3,
              ),
            ],
          ),
          child: child,
        );
      },
      child: Row(
        children: [
          const SizedBox(width: 20),
          const HugeIcon(
            icon: HugeIcons.strokeRoundedVolumeHigh,
            color: AppColors.primaryLight,
            size: 20,
          ),
          const SizedBox(width: 10),
          Container(
            width: 1.5,
            height: 22,
            color: AppColors.primaryLight.withValues(alpha: 0.35),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: SizedBox.expand(
              child: CustomPaint(
                painter: _SquigglyWavePainter(
                  animation: animation,
                  progress: progress,
                  color: AppColors.primaryLight,
                  morseSequence: morseSequence,
                ),
              ),
            ),
          ),
          const SizedBox(width: 20),
        ],
      ),
    );
  }
}

class _StopButton extends StatelessWidget {
  const _StopButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 52,
        height: 52,
        decoration: const BoxDecoration(
          color: AppColors.dangerSurface,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: const Center(
          child: HugeIcon(
            icon: HugeIcons.strokeRoundedStop,
            color: AppColors.danger,
            size: 22,
          ),
        ),
      ),
    );
  }
}

// ─── Screen ──────────────────────────────────────────────────────────────────

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
      duration: const Duration(milliseconds: 1100),
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
                _DirectionLabel(textFirst: true),
                _DirectionLabel(textFirst: false),
              ],
            ),
            const SizedBox(height: AppSpacing.base),

            // Input field
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Text(
                          state.direction == TranslationDirection.textToMorse
                              ? 'BESEDILO'
                              : 'MORSE',
                          style: AppTypography.overline
                              .copyWith(color: AppColors.textTertiary),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () => ref
                              .read(morseTranslationProvider.notifier)
                              .clear(),
                          child: const HugeIcon(
                            icon: HugeIcons.strokeRoundedDelete02,
                            color: AppColors.textTertiary,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        maxLines: null,
                        expands: true,
                        textAlignVertical: TextAlignVertical.top,
                        style: AppTypography.body
                            .copyWith(color: AppColors.textPrimary),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Vnesi besedilo...',
                          hintStyle: TextStyle(color: AppColors.textTertiary),
                        ),
                        onChanged: (text) => ref
                            .read(morseTranslationProvider.notifier)
                            .setInput(text),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.md),

            // Output field
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.primaryDark, width: 1),
                ),
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Text(
                          state.direction == TranslationDirection.textToMorse
                              ? 'MORSE'
                              : 'BESEDILO',
                          style: AppTypography.overline
                              .copyWith(color: AppColors.primaryLight),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            if (state.outputText.isNotEmpty) {
                              Clipboard.setData(
                                  ClipboardData(text: state.outputText));
                            }
                          },
                          child: const HugeIcon(
                            icon: HugeIcons.strokeRoundedCopy01,
                            color: AppColors.textTertiary,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Text(
                          state.outputText.isEmpty
                              ? 'Prevod se pojavi tukaj...'
                              : state.outputText,
                          style: state.outputText.isEmpty
                              ? AppTypography.body
                                  .copyWith(color: AppColors.textTertiary)
                              : AppTypography.morseSequence.copyWith(
                                  fontSize: 16, color: AppColors.primaryLight),
                        ),
                      ),
                    ),
                  ],
                ),
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
                            style: AppTypography.buttonLabel.copyWith(
                                color: AppColors.primary, fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                ],
                if (_isTransmitting) ...[
                  Expanded(
                    child: _TransmittingButton(
                      animation: _waveController,
                      progress: _transmitProgress,
                      morseSequence: _transmittingMorse,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  _StopButton(onPressed: _stop),
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
