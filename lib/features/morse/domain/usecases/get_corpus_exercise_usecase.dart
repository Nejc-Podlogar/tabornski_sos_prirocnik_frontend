import '../../../../core/domain/value_objects/exercise_enums.dart';
import '../entities/morse_exercise.dart';
import '../repositories/i_morse_exercise_repository.dart';

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
