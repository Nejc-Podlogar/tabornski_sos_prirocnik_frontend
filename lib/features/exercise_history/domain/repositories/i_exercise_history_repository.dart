import '../entities/exercise_session.dart';

abstract interface class IExerciseHistoryRepository {
  Future<List<ExerciseSession>> getAll();

  Future<void> save(ExerciseSession session);

  Future<void> clearAll();
}
