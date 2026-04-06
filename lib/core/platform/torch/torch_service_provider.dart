import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'i_torch_service.dart';
import 'torch_service_mobile.dart';

final torchServiceProvider = Provider<ITorchService>((ref) {
  if (kIsWeb) return _NoOpTorchService();
  return TorchServiceMobile();
});

/// Web stub — screen is guarded by isTorchAvailable so this is never called.
class _NoOpTorchService implements ITorchService {
  @override
  Future<void> transmit(String morseSequence, {bool loop = false}) async {}

  @override
  Future<void> stop() async {}

  @override
  Future<void> setTorch(bool on) async {}
}
