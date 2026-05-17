import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/domain/value_objects/exercise_enums.dart';
import '../../../../core/domain/value_objects/exercise_validation.dart';
import '../../domain/entities/morse_exercise.dart';
import '../../domain/usecases/generate_letter_exercise_usecase.dart';
import '../../domain/usecases/get_corpus_exercise_usecase.dart';
import '../../domain/usecases/validate_morse_answer_usecase.dart';
import 'morse_exercise_repository_provider.dart';
import 'morse_translation_repository_provider.dart';
import 'save_morse_session_provider.dart';

part 'morse_exercise_provider.freezed.dart';

@freezed
class MorseExerciseState with _$MorseExerciseState {
  const factory MorseExerciseState({
    required List<MorseExercise> exercises,
    @Default(0) int currentIndex,
    required List<ExerciseValidation?> sessionResults,
    @Default(false) bool isComplete,
  }) = _MorseExerciseState;
}

final morseExerciseProvider =
    AsyncNotifierProvider<MorseExerciseNotifier, MorseExerciseState?>(
  MorseExerciseNotifier.new,
);

class MorseExerciseNotifier extends AsyncNotifier<MorseExerciseState?> {
  late final _validateUseCase = ValidateMorseAnswerUseCase(
    ref.read(morseTranslationRepositoryProvider),
  );
  late final _generateLetterUseCase = GenerateLetterExerciseUseCase(
    ref.read(morseExerciseRepositoryProvider),
  );
  late final _getCorpusUseCase = GetCorpusExerciseUseCase(
    ref.read(morseExerciseRepositoryProvider),
  );

  @override
  Future<MorseExerciseState?> build() async => null;

  Future<void> startExercise(
    ExerciseContentType contentType,
    TranslationDirection direction,
    InteractionType interactionType,
    int count,
  ) async {
    state = const AsyncLoading();

    List<MorseExercise> exercises;
    if (contentType == ExerciseContentType.letters) {
      exercises =
          await _generateLetterUseCase.call(count, direction, interactionType);
    } else {
      exercises = await _getCorpusUseCase.call(
          count, contentType, direction, interactionType);
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
    final result = _validateUseCase.call(userInput, expected, exercise.direction);

    final updatedResults = List<ExerciseValidation?>.from(current.sessionResults)
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

  Future<void> saveSession({DateTime? completedAt}) async {
    final s = state.valueOrNull;
    if (s == null || !s.isComplete || s.exercises.isEmpty) return;
    final correct = s.sessionResults
        .where((r) => r == ExerciseValidation.correct)
        .length;
    final first = s.exercises.first;
    final now = completedAt ?? DateTime.now();
    final useCase = ref.read(saveMorseSessionUseCaseProvider);
    await useCase.call(
      contentType: first.contentType,
      interactionType: first.interactionType,
      totalQuestions: s.exercises.length,
      correctCount: correct,
      sessionDate: now,
    );
  }

  void swipeCard(bool swipedRight) {
    final current = state.valueOrNull;
    if (current == null || current.isComplete) return;

    final exercise = current.exercises[current.currentIndex];
    final isCorrect = swipedRight == exercise.isCorrectPair;
    final result =
        isCorrect ? ExerciseValidation.correct : ExerciseValidation.incorrect;
    final updatedResults = List<ExerciseValidation?>.from(current.sessionResults)
      ..[current.currentIndex] = result;

    state = AsyncData(current.copyWith(sessionResults: updatedResults));
    nextExercise();
  }
}
