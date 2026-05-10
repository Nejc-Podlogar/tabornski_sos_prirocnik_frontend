import '../../../../core/domain/value_objects/exercise_enums.dart';
import '../../../../core/domain/value_objects/exercise_validation.dart';
import '../repositories/i_morse_translation_repository.dart';

class ValidateMorseAnswerUseCase {
  const ValidateMorseAnswerUseCase(this._repository);

  final IMorseTranslationRepository _repository;

  ExerciseValidation call(
    String userInput,
    String expected,
    TranslationDirection direction,
  ) =>
      _repository.validate(userInput, expected, direction);
}
