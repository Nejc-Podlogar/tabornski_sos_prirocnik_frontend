import '../../../../core/domain/value_objects/exercise_enums.dart';
import '../../../../core/domain/value_objects/exercise_validation.dart';
import '../../domain/entities/morse_entry.dart';
import '../../domain/repositories/i_morse_translation_repository.dart';
import '../sources/morse_dictionary.dart';

class MorseTranslationRepository implements IMorseTranslationRepository {
  const MorseTranslationRepository();

  @override
  String translate(String input, TranslationDirection direction) {
    final normalized = input.trim().toUpperCase();
    if (direction == TranslationDirection.textToMorse) {
      return normalized.split('').map((char) {
        if (char == ' ') return '/';
        return MorseDictionary.charToMorse[char] ?? '?';
      }).join(' ');
    } else {
      // morseToText: tokens separated by spaces; '/' is word separator
      return normalized.split(' ').map((token) {
        if (token == '/') return ' ';
        return MorseDictionary.morseToChar[token] ?? '?';
      }).join('');
    }
  }

  @override
  List<MorseEntry> getDictionary() {
    return MorseDictionary.charToMorse.entries
        .map((e) => MorseEntry(character: e.key, morseSequence: e.value))
        .toList();
  }

  @override
  ExerciseValidation validate(
    String input,
    String expected,
    TranslationDirection direction,
  ) {
    final normalizedInput = input.trim().toLowerCase();
    final normalizedExpected = expected.trim().toLowerCase();

    if (normalizedInput == normalizedExpected) {
      return ExerciseValidation.correct;
    }

    final inputChars = normalizedInput.split('');
    final expectedChars = normalizedExpected.split('');
    int matches = 0;
    final minLen = inputChars.length < expectedChars.length
        ? inputChars.length
        : expectedChars.length;
    for (int i = 0; i < minLen; i++) {
      if (inputChars[i] == expectedChars[i]) matches++;
    }
    final matchRatio =
        expectedChars.isEmpty ? 0.0 : matches / expectedChars.length;

    if (matchRatio > 0.5) return ExerciseValidation.partial;
    return ExerciseValidation.incorrect;
  }
}
