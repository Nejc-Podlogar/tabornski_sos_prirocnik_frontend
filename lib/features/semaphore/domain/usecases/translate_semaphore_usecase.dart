import '../entities/semaphore_entry.dart';
import '../repositories/i_semaphore_translation_repository.dart';

class TranslateSemaphoreUseCase {
  const TranslateSemaphoreUseCase(this._repository);

  final ISemaphoreTranslationRepository _repository;

  List<SemaphoreEntry> call(String input) =>
      _repository.getEntriesForText(input);
}
