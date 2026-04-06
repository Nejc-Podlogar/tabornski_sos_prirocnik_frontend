import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/domain/value_objects/exercise_enums.dart';

part 'semaphore_exercise.freezed.dart';

@freezed
class SemaphoreExercise with _$SemaphoreExercise {
  const factory SemaphoreExercise({
    required List<String> exerciseValues,
    required List<String> translatedValues,
    required List<bool?> areCorrect,
    required int currentIndex,
    required TranslationDirection direction,
    required InteractionType interactionType,
  }) = _SemaphoreExercise;
}
