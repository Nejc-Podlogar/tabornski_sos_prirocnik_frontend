import '../../../../core/domain/value_objects/exercise_enums.dart';
import '../entities/semaphore_exercise.dart';

abstract interface class ISemaphoreExerciseRepository {
  Future<List<SemaphoreExercise>> getExercises(
    int count,
    TranslationDirection direction,
    InteractionType interactionType,
  );
}
