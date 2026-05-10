import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/semaphore_translation_repository.dart';
import '../../domain/entities/semaphore_entry.dart';
import '../../domain/repositories/i_semaphore_translation_repository.dart';

final semaphoreTranslationRepositoryProvider =
    Provider<ISemaphoreTranslationRepository>((ref) {
  return const SemaphoreTranslationRepository();
});

/// Pre-computed full dictionary so widgets never call getDictionary() directly.
final semaphoreDictionaryProvider = Provider<List<SemaphoreEntry>>((ref) {
  return ref.watch(semaphoreTranslationRepositoryProvider).getDictionary();
});
