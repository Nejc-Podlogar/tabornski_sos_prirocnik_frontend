import '../../../../core/domain/value_objects/exercise_enums.dart';
import '../entities/morse_exercise.dart';
import '../repositories/i_morse_exercise_repository.dart';

class GenerateLetterExerciseUseCase {
  const GenerateLetterExerciseUseCase(this._repository);

  final IMorseExerciseRepository _repository;

  Future<List<MorseExercise>> call(
    int count,
    TranslationDirection direction,
    InteractionType interactionType,
  ) =>
      _repository.getLetterExercises(count, direction, interactionType);
}
