import 'dart:math';

import '../../../../core/domain/value_objects/exercise_enums.dart';
import '../entities/semaphore_exercise.dart';
import '../repositories/i_semaphore_exercise_repository.dart';
import '../repositories/i_semaphore_translation_repository.dart';

class GetSemaphoreExerciseUseCase {
  const GetSemaphoreExerciseUseCase(
    this._repository,
    this._translationRepository,
  );

  final ISemaphoreExerciseRepository _repository;
  final ISemaphoreTranslationRepository _translationRepository;

  static final _random = Random();

  Future<List<SemaphoreExercise>> call(
    int count,
    TranslationDirection direction,
    InteractionType interactionType,
  ) async {
    final fromDb = await _repository.getExercises(count, direction, interactionType);
    if (fromDb.isNotEmpty) return fromDb;

    // DB empty — generate from dictionary (letters only, no space).
    final allEntries = _translationRepository
        .getDictionary()
        .where((e) => RegExp(r'^[A-Z]$').hasMatch(e.character))
        .toList();

    allEntries.shuffle(_random);
    final selected = allEntries.take(count).toList();

    return selected.map((entry) {
      final exerciseValues = direction == TranslationDirection.textToMorse
          ? [entry.character]
          : [entry.flagImagePath];
      final translatedValues = direction == TranslationDirection.textToMorse
          ? [entry.flagImagePath]
          : [entry.character];

      return SemaphoreExercise(
        exerciseValues: exerciseValues,
        translatedValues: translatedValues,
        areCorrect: [null],
        currentIndex: 0,
        direction: direction,
        interactionType: interactionType,
      );
    }).toList();
  }
}
