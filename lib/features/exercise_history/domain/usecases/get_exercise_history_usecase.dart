import '../entities/exercise_session.dart';
import '../repositories/i_exercise_history_repository.dart';

class GetExerciseHistoryUseCase {
  const GetExerciseHistoryUseCase(this._repository);

  final IExerciseHistoryRepository _repository;

  Future<List<ExerciseSession>> call() async {
    final sessions = await _repository.getAll();
    return sessions
      ..sort((a, b) => b.sessionDate.compareTo(a.sessionDate));
  }
}
