import '../repositories/i_exercise_history_repository.dart';

class ClearExerciseHistoryUseCase {
  const ClearExerciseHistoryUseCase(this._repository);

  final IExerciseHistoryRepository _repository;

  Future<void> call() => _repository.clearAll();
}
