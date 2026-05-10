import '../entities/exercise_session.dart';
import '../repositories/i_exercise_history_repository.dart';

class SaveExerciseSessionUseCase {
  const SaveExerciseSessionUseCase(this._repository);

  final IExerciseHistoryRepository _repository;

  Future<void> call(ExerciseSession session) =>
      _repository.save(session);
}
