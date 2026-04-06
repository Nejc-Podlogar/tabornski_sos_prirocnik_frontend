import '../entities/morse_entry.dart';
import '../value_objects/morse_code_validation.dart';
import '../value_objects/translation_direction.dart';

abstract interface class IMorseTranslationRepository {
  String translate(String input, TranslationDirection direction);
  List<MorseEntry> getDictionary();
  MorseCodeValidation validate(
    String input,
    String expected,
    TranslationDirection direction,
  );
}
