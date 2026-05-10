import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/exercise_session.dart';
import '../../domain/usecases/clear_exercise_history_usecase.dart';
import '../../domain/usecases/get_exercise_history_usecase.dart';
import '../../domain/usecases/save_exercise_session_usecase.dart';
import 'exercise_history_repository_provider.dart';

final exerciseHistoryProvider =
    AsyncNotifierProvider<ExerciseHistoryNotifier, List<ExerciseSession>>(
  ExerciseHistoryNotifier.new,
);

class ExerciseHistoryNotifier extends AsyncNotifier<List<ExerciseSession>> {
  @override
  Future<List<ExerciseSession>> build() {
    final repository = ref.watch(exerciseHistoryRepositoryProvider);
    return GetExerciseHistoryUseCase(repository).call();
  }

  Future<void> saveSession(ExerciseSession session) async {
    final repository = ref.read(exerciseHistoryRepositoryProvider);
    await SaveExerciseSessionUseCase(repository).call(session);
    ref.invalidateSelf();
  }

  Future<void> clearAll() async {
    final repository = ref.read(exerciseHistoryRepositoryProvider);
    await ClearExerciseHistoryUseCase(repository).call();
    ref.invalidateSelf();
  }
}
