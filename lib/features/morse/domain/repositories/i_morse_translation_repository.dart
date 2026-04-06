import '../../../../core/domain/value_objects/exercise_enums.dart';
import '../../../../core/domain/value_objects/exercise_validation.dart';
import '../entities/morse_entry.dart';

abstract interface class IMorseTranslationRepository {
  String translate(String input, TranslationDirection direction);
  List<MorseEntry> getDictionary();
  ExerciseValidation validate(
    String input,
    String expected,
    TranslationDirection direction,
  );
}
