import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'audio_morse_service.dart';
import 'i_audio_morse_service.dart';

final audioMorseServiceProvider = Provider<IAudioMorseService>((ref) {
  final service = AudioMorseService();
  ref.onDispose(service.dispose);
  return service;
});
