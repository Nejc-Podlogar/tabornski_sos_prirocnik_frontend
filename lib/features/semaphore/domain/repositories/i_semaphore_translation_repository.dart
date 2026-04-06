import '../entities/semaphore_entry.dart';

abstract interface class ISemaphoreTranslationRepository {
  List<SemaphoreEntry> getDictionary();
  String translate(String input);
  List<SemaphoreEntry> getEntriesForText(String input);
}
