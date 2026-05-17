import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../core/platform/morse_timing_constants.dart';

class SquigglyWavePainter extends CustomPainter {
  SquigglyWavePainter({
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
          segs.add((t, t + MorseTimingConstants.dotMs, false));
          t += MorseTimingConstants.dotMs + MorseTimingConstants.symbolGapMs;
        case '-':
          segs.add((t, t + MorseTimingConstants.dashMs, true));
          t += MorseTimingConstants.dashMs + MorseTimingConstants.symbolGapMs;
        case ' ':
          t += MorseTimingConstants.letterGapMs;
        case '/':
          t += MorseTimingConstants.wordGapMs;
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
      amp = math.max(
          amp, _silenceAmplitude + (toneAmp - _silenceAmplitude) * t);
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
      final ms0 = _totalMs * progress - thumbX / _pxPerMs;
      final path = Path();
      for (double x = 0; x <= waveClip; x++) {
        final ms = ms0 + x / _pxPerMs;
        final amp = (ms < 0 || ms >= _totalMs)
            ? _silenceAmplitude
            : _amplitudeAt(ms);
        final y =
            cy + amp * math.sin(2 * math.pi * x / _wavelength - phase);
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
  bool shouldRepaint(SquigglyWavePainter old) =>
      old.progress != progress ||
      old.morseSequence != morseSequence ||
      old.color != color;
}
