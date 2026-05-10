import 'package:torch_light/torch_light.dart';

import 'i_torch_service.dart';

class TorchServiceMobile implements ITorchService {
  bool _running = false;

  static const _dotOn = Duration(milliseconds: 200);
  static const _dashOn = Duration(milliseconds: 600);
  static const _symbolOff = Duration(milliseconds: 200);
  static const _letterGap = Duration(milliseconds: 400);
  static const _wordGap = Duration(milliseconds: 400);

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
              await Future.delayed(_dotOn);
              await TorchLight.disableTorch();
              await Future.delayed(_symbolOff);
            case '-':
              await TorchLight.enableTorch();
              await Future.delayed(_dashOn);
              await TorchLight.disableTorch();
              await Future.delayed(_symbolOff);
            case ' ':
              await Future.delayed(_letterGap);
            case '/':
              await Future.delayed(_wordGap);
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
