import 'dart:async';
import 'dart:math' as math;
import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart';

import '../morse_timing_constants.dart';
import 'i_audio_morse_service.dart';

class AudioMorseService implements IAudioMorseService {
  static const int _sampleRate = 44100;
  static const int _frequency = 700;
  static const int _roundGapMs = 300;
  static const int _roundGapStepMs = 100;

  AudioPlayer? _player;
  bool _running = false;
  int _totalMs = 0;

  final _progressController = StreamController<double>.broadcast();

  AudioPlayer get _audio => _player ??= AudioPlayer();

  @override
  bool get isTransmitting => _running;

  @override
  Stream<double> get progress => _progressController.stream;

  @override
  Future<void> transmit(String morseSequence) async {
    if (_running) throw StateError('Already transmitting');
    _running = true;

    final (bytes, totalMs) = _buildSequenceWav(morseSequence);
    _totalMs = totalMs;

    StreamSubscription<Duration>? positionSub;

    try {
      while (_running) {
        _progressController.add(0.0);

        final completer = Completer<void>();

        positionSub = _audio.onPositionChanged.listen((pos) {
          if (_totalMs > 0) {
            _progressController.add(
              (pos.inMilliseconds / _totalMs).clamp(0.0, 1.0),
            );
          }
        });

        final stateSub = _audio.onPlayerStateChanged.listen((s) {
          if (!completer.isCompleted &&
              (s == PlayerState.completed || s == PlayerState.stopped)) {
            completer.complete();
          }
        });

        await _audio.play(BytesSource(bytes));
        await completer.future;
        await positionSub.cancel();
        positionSub = null;
        await stateSub.cancel();

        if (!_running) break;

        _progressController.add(1.0);

        // Inter-round pause — checked in steps so stop() takes effect quickly.
        for (int t = 0; t < _roundGapMs && _running; t += _roundGapStepMs) {
          await Future.delayed(const Duration(milliseconds: _roundGapStepMs));
        }
      }
    } finally {
      await positionSub?.cancel();
      _running = false;
      _progressController.add(0.0);
    }
  }

  @override
  Future<void> stop() async {
    _running = false;
    await _player?.stop();
  }

  @override
  void dispose() {
    _running = false;
    _progressController.close();
    _player?.dispose();
    _player = null;
  }

  // ---------------------------------------------------------------------------

  (Uint8List bytes, int totalMs) _buildSequenceWav(String morseSequence) {
    final segments = <(int, bool)>[];

    for (final ch in morseSequence.split('')) {
      switch (ch) {
        case '.':
          segments.add((MorseTimingConstants.dotMs, true));
          segments.add((MorseTimingConstants.symbolGapMs, false));
        case '-':
          segments.add((MorseTimingConstants.dashMs, true));
          segments.add((MorseTimingConstants.symbolGapMs, false));
        case ' ':
          segments.add((MorseTimingConstants.letterGapMs, false));
        case '/':
          segments.add((MorseTimingConstants.wordGapMs, false));
      }
    }

    if (segments.isEmpty) return (_emptyWav(), 0);

    final totalMs = segments.fold(0, (s, seg) => s + seg.$1);
    final numSamples = (_sampleRate * totalMs / 1000).round();
    final dataSize = numSamples * 2;
    final buf = ByteData(44 + dataSize);
    _writeWavHeader(buf, dataSize);

    int pos = 0;
    for (final (dMs, tone) in segments) {
      final segLen = (_sampleRate * dMs / 1000).round();
      if (tone) {
        final fadeLen = (_sampleRate * 0.008).round();
        for (int i = 0; i < segLen; i++) {
          double env = 1.0;
          if (i < fadeLen) env = i / fadeLen;
          if (i > segLen - fadeLen) env = (segLen - i) / fadeLen;
          final t = (pos + i) / _sampleRate;
          final v = (math.sin(2 * math.pi * _frequency * t) * 32767 * env)
              .round()
              .clamp(-32768, 32767);
          buf.setInt16(44 + (pos + i) * 2, v, Endian.little);
        }
      }
      pos += segLen;
    }

    return (buf.buffer.asUint8List(), totalMs);
  }

  static Uint8List _emptyWav() {
    final buf = ByteData(44);
    _writeWavHeader(buf, 0);
    return buf.buffer.asUint8List();
  }

  static void _writeWavHeader(ByteData buf, int dataSize) {
    void bytes(int offset, List<int> bs) {
      for (int i = 0; i < bs.length; i++) {
        buf.setUint8(offset + i, bs[i]);
      }
    }

    bytes(0, [0x52, 0x49, 0x46, 0x46]);
    buf.setUint32(4, 36 + dataSize, Endian.little);
    bytes(8, [0x57, 0x41, 0x56, 0x45]);
    bytes(12, [0x66, 0x6D, 0x74, 0x20]);
    buf.setUint32(16, 16, Endian.little);
    buf.setUint16(20, 1, Endian.little);
    buf.setUint16(22, 1, Endian.little);
    buf.setUint32(24, _sampleRate, Endian.little);
    buf.setUint32(28, _sampleRate * 2, Endian.little);
    buf.setUint16(32, 2, Endian.little);
    buf.setUint16(34, 16, Endian.little);
    bytes(36, [0x64, 0x61, 0x74, 0x61]);
    buf.setUint32(40, dataSize, Endian.little);
  }
}
