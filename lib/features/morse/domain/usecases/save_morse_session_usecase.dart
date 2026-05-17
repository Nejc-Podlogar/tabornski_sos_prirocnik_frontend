import '../../../../core/domain/value_objects/exercise_enums.dart';
import '../../../exercise_history/domain/entities/exercise_session.dart';
import '../../../exercise_history/domain/repositories/i_exercise_history_repository.dart';
import '../../../exercise_history/domain/value_objects/feature_type.dart';

class SaveMorseSessionUseCase {
  const SaveMorseSessionUseCase(this._repository);

  final IExerciseHistoryRepository _repository;

  Future<void> call({
    required ExerciseContentType contentType,
    required InteractionType interactionType,
    required int totalQuestions,
    required int correctCount,
    required DateTime sessionDate,
  }) async {
    await _repository.save(ExerciseSession(
      id: null,
      featureType: FeatureType.morse,
      exerciseContentType: contentType.name,
      interactionType: interactionType.name,
      totalQuestions: totalQuestions,
      correctCount: correctCount,
      sessionDate: sessionDate,
      durationSeconds: 0, // TODO: wire exercise timer
    ));
  }
}
