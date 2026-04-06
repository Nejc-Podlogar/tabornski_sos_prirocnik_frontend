import '../entities/morse_exercise.dart';
import '../value_objects/exercise_content_type.dart';
import '../value_objects/interaction_type.dart';
import '../value_objects/translation_direction.dart';

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
