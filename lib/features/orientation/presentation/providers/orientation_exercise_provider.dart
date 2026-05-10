import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/domain/value_objects/exercise_enums.dart';
import '../../../../core/domain/value_objects/exercise_validation.dart';
import '../../domain/entities/orientation_sign.dart';
import '../../domain/usecases/get_orientation_exercise_usecase.dart';
import '../../domain/usecases/validate_orientation_answer_usecase.dart';
import '../../domain/value_objects/topo_group_type.dart';
import 'orientation_repository_provider.dart';

part 'orientation_exercise_provider.freezed.dart';

@freezed
class OrientationExerciseState with _$OrientationExerciseState {
  const factory OrientationExerciseState({
    required List<OrientationSign> signs,
    @Default(0) int currentIndex,
    required List<ExerciseValidation?> sessionResults,
    required Set<TopoGroupType> selectedGroups,
    @Default(false) bool isComplete,
  }) = _OrientationExerciseState;
}

final orientationExerciseProvider = AsyncNotifierProvider<
    OrientationExerciseNotifier, OrientationExerciseState?>(
  OrientationExerciseNotifier.new,
);

class OrientationExerciseNotifier
    extends AsyncNotifier<OrientationExerciseState?> {
  @override
  Future<OrientationExerciseState?> build() async => null;

  Future<void> startExercise(
    Set<TopoGroupType> groups,
    int count,
    InteractionType interactionType,
  ) async {
    state = const AsyncLoading();
    final repository = ref.read(orientationRepositoryProvider);
    final signs =
        await GetOrientationExerciseUseCase(repository).call(groups, count);

    state = AsyncData(OrientationExerciseState(
      signs: signs,
      currentIndex: 0,
      sessionResults: List.filled(signs.length, null),
      selectedGroups: groups,
      isComplete: false,
    ));
  }

  void validateAnswer(String userInput) {
    final current = state.valueOrNull;
    if (current == null || current.isComplete) return;

    final expected = current.signs[current.currentIndex].name;
    const useCase = ValidateOrientationAnswerUseCase();
    final result = useCase.call(userInput, expected);

    final updatedResults =
        List<ExerciseValidation?>.from(current.sessionResults)
          ..[current.currentIndex] = result;

    state = AsyncData(current.copyWith(sessionResults: updatedResults));
  }

  void nextSign() {
    final current = state.valueOrNull;
    if (current == null) return;

    final nextIndex = current.currentIndex + 1;
    if (nextIndex >= current.signs.length) {
      state = AsyncData(current.copyWith(isComplete: true));
    } else {
      state = AsyncData(current.copyWith(currentIndex: nextIndex));
    }
  }

  void swipeCard(bool isCorrect) {
    final current = state.valueOrNull;
    if (current == null || current.isComplete) return;

    final result =
        isCorrect ? ExerciseValidation.correct : ExerciseValidation.incorrect;
    final updatedResults =
        List<ExerciseValidation?>.from(current.sessionResults)
          ..[current.currentIndex] = result;

    state = AsyncData(current.copyWith(sessionResults: updatedResults));
    nextSign();
  }
}
