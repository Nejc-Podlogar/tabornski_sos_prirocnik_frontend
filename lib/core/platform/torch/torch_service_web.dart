import 'i_torch_service.dart';

/// Web stub — torch is unavailable in browsers.
/// The flashlight transmitter screen is guarded by [isTorchAvailable]
/// so this implementation is never called in practice.
class TorchServiceWeb implements ITorchService {
  @override
  Future<void> transmit(String morseSequence, {bool loop = false}) async {}

  @override
  Future<void> stop() async {}

  @override
  Future<void> setTorch(bool on) async {}

  @override
  bool get isTransmitting => false;
}
