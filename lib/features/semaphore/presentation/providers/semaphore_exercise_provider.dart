import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/domain/value_objects/exercise_enums.dart';
import '../../../../core/domain/value_objects/exercise_validation.dart';
import '../../domain/entities/semaphore_exercise.dart';
import '../../domain/usecases/get_semaphore_exercise_usecase.dart';
import '../../domain/usecases/validate_semaphore_answer_usecase.dart';
import 'semaphore_exercise_repository_provider.dart';
import 'semaphore_translation_repository_provider.dart';

part 'semaphore_exercise_provider.freezed.dart';

@freezed
class SemaphoreExerciseState with _$SemaphoreExerciseState {
  const factory SemaphoreExerciseState({
    required List<SemaphoreExercise> exercises,
    @Default(0) int currentIndex,
    required List<ExerciseValidation?> sessionResults,
    @Default(false) bool isComplete,
  }) = _SemaphoreExerciseState;
}

final semaphoreExerciseProvider =
    AsyncNotifierProvider<SemaphoreExerciseNotifier, SemaphoreExerciseState?>(
  SemaphoreExerciseNotifier.new,
);

class SemaphoreExerciseNotifier
    extends AsyncNotifier<SemaphoreExerciseState?> {
  @override
  Future<SemaphoreExerciseState?> build() async => null;

  Future<void> startExercise(
    TranslationDirection direction,
    InteractionType interactionType,
    int count,
  ) async {
    state = const AsyncLoading();
    final exerciseRepo = ref.read(semaphoreExerciseRepositoryProvider);
    final translationRepo = ref.read(semaphoreTranslationRepositoryProvider);
    final useCase =
        GetSemaphoreExerciseUseCase(exerciseRepo, translationRepo);
    final exercises =
        await useCase.call(count, direction, interactionType);

    state = AsyncData(SemaphoreExerciseState(
      exercises: exercises,
      currentIndex: 0,
      sessionResults: List.filled(exercises.length, null),
      isComplete: false,
    ));
  }

  void validateAnswer(String userInput) {
    final current = state.valueOrNull;
    if (current == null || current.isComplete) return;

    final exercise = current.exercises[current.currentIndex];
    final expected = exercise.translatedValues[0];
    const useCase = ValidateSemaphoreAnswerUseCase();
    final result = useCase.call(userInput, expected);

    final updatedResults =
        List<ExerciseValidation?>.from(current.sessionResults)
          ..[current.currentIndex] = result;

    state = AsyncData(current.copyWith(sessionResults: updatedResults));
  }

  void nextExercise() {
    final current = state.valueOrNull;
    if (current == null) return;

    final nextIndex = current.currentIndex + 1;
    if (nextIndex >= current.exercises.length) {
      state = AsyncData(current.copyWith(isComplete: true));
    } else {
      state = AsyncData(current.copyWith(currentIndex: nextIndex));
    }
  }

  void swipeCard(bool isCorrect) {
    final current = state.valueOrNull;
    if (current == null || current.isComplete) return;

    final result = isCorrect
        ? ExerciseValidation.correct
        : ExerciseValidation.incorrect;
    final updatedResults =
        List<ExerciseValidation?>.from(current.sessionResults)
          ..[current.currentIndex] = result;

    state = AsyncData(current.copyWith(sessionResults: updatedResults));
    nextExercise();
  }
}
