import '../../../../core/domain/value_objects/exercise_enums.dart';
import '../entities/morse_exercise.dart';

abstract interface class IMorseExerciseRepository {
  Future<List<MorseExercise>> getLetterExercises(
    int count,
    TranslationDirection direction,
    InteractionType interactionType,
  );

  Future<List<MorseExercise>> getCorpusExercises(
    int count,
    ExerciseContentType contentType,
    TranslationDirection direction,
    InteractionType interactionType,
  );
}
