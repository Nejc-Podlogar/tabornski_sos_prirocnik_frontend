import '../../../../core/domain/value_objects/exercise_validation.dart';

class ValidateOrientationAnswerUseCase {
  const ValidateOrientationAnswerUseCase();

  ExerciseValidation call(String userInput, String expectedName) {
    final input = userInput.trim().toLowerCase();
    final target = expectedName.trim().toLowerCase();

    if (input == target) return ExerciseValidation.correct;

    final inputChars = input.split('');
    final targetChars = target.split('');
    final minLen = inputChars.length < targetChars.length
        ? inputChars.length
        : targetChars.length;

    var matches = 0;
    for (var i = 0; i < minLen; i++) {
      if (inputChars[i] == targetChars[i]) matches++;
    }

    final ratio = targetChars.isEmpty ? 0.0 : matches / targetChars.length;

    return ratio > 0.5
        ? ExerciseValidation.partial
        : ExerciseValidation.incorrect;
  }
}
