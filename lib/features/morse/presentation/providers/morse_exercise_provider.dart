import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/morse_exercise.dart';
import '../../domain/usecases/generate_letter_exercise_usecase.dart';
import '../../domain/usecases/get_corpus_exercise_usecase.dart';
import '../../domain/usecases/validate_morse_answer_usecase.dart';
import '../../domain/value_objects/exercise_content_type.dart';
import '../../domain/value_objects/interaction_type.dart';
import '../../domain/value_objects/morse_code_validation.dart';
import '../../domain/value_objects/translation_direction.dart';
import 'morse_exercise_repository_provider.dart';
import 'morse_translation_repository_provider.dart';

part 'morse_exercise_provider.freezed.dart';

@freezed
class MorseExerciseState with _$MorseExerciseState {
  const factory MorseExerciseState({
    required List<MorseExercise> exercises,
    @Default(0) int currentIndex,
    required List<MorseCodeValidation?> sessionResults,
    @Default(false) bool isComplete,
  }) = _MorseExerciseState;
}

final morseExerciseProvider =
    AsyncNotifierProvider<MorseExerciseNotifier, MorseExerciseState?>(
  MorseExerciseNotifier.new,
);

class MorseExerciseNotifier extends AsyncNotifier<MorseExerciseState?> {
  @override
  Future<MorseExerciseState?> build() async => null;

  Future<void> startExercise(
    ExerciseContentType contentType,
    TranslationDirection direction,
    InteractionType interactionType,
    int count,
  ) async {
    state = const AsyncLoading();
    final exerciseRepo = ref.read(morseExerciseRepositoryProvider);

    List<MorseExercise> exercises;
    if (contentType == ExerciseContentType.letters) {
      final useCase = GenerateLetterExerciseUseCase(exerciseRepo);
      exercises = await useCase.call(count, direction, interactionType);
    } else {
      final useCase = GetCorpusExerciseUseCase(exerciseRepo);
      exercises =
          await useCase.call(count, contentType, direction, interactionType);
    }

    state = AsyncData(MorseExerciseState(
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
    final translationRepo = ref.read(morseTranslationRepositoryProvider);
    final useCase = ValidateMorseAnswerUseCase(translationRepo);
    final result = useCase.call(userInput, expected, exercise.direction);

    final updatedResults = List<MorseCodeValidation?>.from(current.sessionResults)
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

    final result =
        isCorrect ? MorseCodeValidation.correct : MorseCodeValidation.incorrect;
    final updatedResults = List<MorseCodeValidation?>.from(current.sessionResults)
      ..[current.currentIndex] = result;

    state = AsyncData(current.copyWith(sessionResults: updatedResults));
    nextExercise();
  }
}
