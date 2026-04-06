import '../entities/morse_exercise.dart';
import '../repositories/i_morse_exercise_repository.dart';
import '../value_objects/exercise_content_type.dart';
import '../value_objects/interaction_type.dart';
import '../value_objects/translation_direction.dart';

class GetCorpusExerciseUseCase {
  const GetCorpusExerciseUseCase(this._repository);

  final IMorseExerciseRepository _repository;

  Future<List<MorseExercise>> call(
    int count,
    ExerciseContentType contentType,
    TranslationDirection direction,
    InteractionType interactionType,
  ) =>
      _repository.getCorpusExercises(
          count, contentType, direction, interactionType);
}
