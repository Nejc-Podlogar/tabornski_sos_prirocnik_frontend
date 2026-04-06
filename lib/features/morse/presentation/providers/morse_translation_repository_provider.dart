import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/morse_translation_repository.dart';
import '../../domain/entities/morse_entry.dart';
import '../../domain/repositories/i_morse_translation_repository.dart';

final morseTranslationRepositoryProvider =
    Provider<IMorseTranslationRepository>((ref) {
  return const MorseTranslationRepository();
});

/// Pre-computed full dictionary so widgets never call getDictionary() directly.
final morseDictionaryProvider = Provider<List<MorseEntry>>((ref) {
  final repo = ref.watch(morseTranslationRepositoryProvider);
  return repo.getDictionary();
});
