import '../../domain/entities/semaphore_entry.dart';
import '../../domain/repositories/i_semaphore_translation_repository.dart';
import '../sources/semaphore_dictionary.dart';

class SemaphoreTranslationRepository implements ISemaphoreTranslationRepository {
  const SemaphoreTranslationRepository();

  @override
  List<SemaphoreEntry> getDictionary() {
    return SemaphoreDictionary.charToImage.entries
        .map((e) => SemaphoreEntry(character: e.key, flagImagePath: e.value))
        .toList();
  }

  @override
  String translate(String input) {
    return input.toUpperCase().split('').map((char) {
      return SemaphoreDictionary.charToImage[char] ?? '';
    }).where((path) => path.isNotEmpty).join(' ');
  }

  @override
  List<SemaphoreEntry> getEntriesForText(String input) {
    return input.toUpperCase().split('').map((char) {
      final path = SemaphoreDictionary.charToImage[char];
      if (path == null) return null;
      return SemaphoreEntry(character: char, flagImagePath: path);
    }).whereType<SemaphoreEntry>().toList();
  }
}
