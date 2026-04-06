import 'package:freezed_annotation/freezed_annotation.dart';

import '../value_objects/exercise_content_type.dart';
import '../value_objects/interaction_type.dart';
import '../value_objects/translation_direction.dart';

part 'morse_exercise.freezed.dart';

@freezed
class MorseExercise with _$MorseExercise {
  const factory MorseExercise({
    required List<String> exerciseValues,
    required List<String> translatedValues,
    required List<bool?> areCorrect,
    required int currentIndex,
    required ExerciseContentType contentType,
    required TranslationDirection direction,
    required InteractionType interactionType,
  }) = _MorseExercise;
}
