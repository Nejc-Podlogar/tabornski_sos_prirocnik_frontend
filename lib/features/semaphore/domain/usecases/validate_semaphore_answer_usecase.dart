import '../../../../core/domain/value_objects/exercise_validation.dart';

class ValidateSemaphoreAnswerUseCase {
  const ValidateSemaphoreAnswerUseCase();

  ExerciseValidation call(String userInput, String expected) {
    final input = userInput.trim().toLowerCase();
    final target = expected.trim().toLowerCase();

    if (input == target) return ExerciseValidation.correct;

    final inputChars = input.split('');
    final targetChars = target.split('');
    int matches = 0;
    final minLen =
        inputChars.length < targetChars.length
            ? inputChars.length
            : targetChars.length;
    for (int i = 0; i < minLen; i++) {
      if (inputChars[i] == targetChars[i]) matches++;
    }
    final ratio =
        targetChars.isEmpty ? 0.0 : matches / targetChars.length;

    return ratio > 0.5
        ? ExerciseValidation.partial
        : ExerciseValidation.incorrect;
  }
}
