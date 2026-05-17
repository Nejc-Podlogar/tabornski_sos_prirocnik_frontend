import 'package:torch_light/torch_light.dart';

import '../morse_timing_constants.dart';
import 'i_torch_service.dart';

class TorchServiceMobile implements ITorchService {
  bool _running = false;

  @override
  Future<void> transmit(String morseSequence, {bool loop = false}) async {
    if (_running) throw StateError('Already transmitting');
    _running = true;

    try {
      while (_running) {
        for (final char in morseSequence.split('')) {
          if (!_running) break;

          switch (char) {
            case '.':
              await TorchLight.enableTorch();
              await Future.delayed(
                  const Duration(milliseconds: MorseTimingConstants.dotMs));
              await TorchLight.disableTorch();
              await Future.delayed(
                  const Duration(milliseconds: MorseTimingConstants.symbolGapMs));
            case '-':
              await TorchLight.enableTorch();
              await Future.delayed(
                  const Duration(milliseconds: MorseTimingConstants.dashMs));
              await TorchLight.disableTorch();
              await Future.delayed(
                  const Duration(milliseconds: MorseTimingConstants.symbolGapMs));
            case ' ':
              await Future.delayed(
                  const Duration(milliseconds: MorseTimingConstants.letterGapMs));
            case '/':
              await Future.delayed(
                  const Duration(milliseconds: MorseTimingConstants.wordGapMs));
          }
        }
        if (!loop) break;
      }
    } finally {
      _running = false;
      try {
        await TorchLight.disableTorch();
      } catch (_) {}
    }
  }

  @override
  Future<void> stop() async {
    _running = false;
    // loop exits naturally; finally block in transmit() handles cleanup
  }

  @override
  Future<void> setTorch(bool on) async {
    try {
      if (on) {
        await TorchLight.enableTorch();
      } else {
        await TorchLight.disableTorch();
      }
    } catch (_) {}
  }

  @override
  bool get isTransmitting => _running;
}
