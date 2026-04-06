import 'dart:convert';

import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/domain/value_objects/exercise_enums.dart';
import '../../domain/entities/semaphore_exercise.dart';

class SemaphoreExerciseMapper {
  SemaphoreExerciseMapper._();

  static SemaphoreExercise fromRow(SemaphoreExercisesTableData row) {
    final exerciseValues =
        (jsonDecode(row.exerciseValues) as List<dynamic>).cast<String>();
    final translatedValues =
        (jsonDecode(row.translatedValues) as List<dynamic>).cast<String>();

    return SemaphoreExercise(
      exerciseValues: exerciseValues,
      translatedValues: translatedValues,
      areCorrect: List.filled(exerciseValues.length, null),
      currentIndex: 0,
      direction: row.translateType,
      interactionType: row.interactionType,
    );
  }

  static SemaphoreExercisesTableCompanion toCompanion(
    SemaphoreExercise entity,
  ) {
    return SemaphoreExercisesTableCompanion.insert(
      exerciseContentType: ExerciseContentType.letters,
      translateType: entity.direction,
      exerciseValues: jsonEncode(entity.exerciseValues),
      translatedValues: jsonEncode(entity.translatedValues),
      count: entity.exerciseValues.length,
      interactionType: entity.interactionType,
    );
  }
}
