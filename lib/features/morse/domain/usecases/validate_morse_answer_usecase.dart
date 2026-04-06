import '../repositories/i_morse_translation_repository.dart';
import '../value_objects/morse_code_validation.dart';
import '../value_objects/translation_direction.dart';

class ValidateMorseAnswerUseCase {
  const ValidateMorseAnswerUseCase(this._repository);

  final IMorseTranslationRepository _repository;

  MorseCodeValidation call(
    String userInput,
    String expected,
    TranslationDirection direction,
  ) =>
      _repository.validate(userInput, expected, direction);
}
