import '../entities/morse_exercise.dart';
import '../repositories/i_morse_exercise_repository.dart';
import '../value_objects/interaction_type.dart';
import '../value_objects/translation_direction.dart';

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
