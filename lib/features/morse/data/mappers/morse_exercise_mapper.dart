import 'dart:convert';

import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../domain/entities/morse_exercise.dart';
import '../../domain/value_objects/exercise_content_type.dart';

class MorseExerciseMapper {
  MorseExerciseMapper._();

  static MorseExercise fromRow(MorseExercisesTableData row) {
    final exerciseValues =
        (jsonDecode(row.exerciseValues) as List<dynamic>).cast<String>();
    final translatedValues =
        (jsonDecode(row.translatedValues) as List<dynamic>).cast<String>();

    return MorseExercise(
      exerciseValues: exerciseValues,
      translatedValues: translatedValues,
      areCorrect: List.filled(exerciseValues.length, null),
      currentIndex: 0,
      contentType: row.exerciseContentType,
      direction: row.translateType,
      interactionType: row.interactionType,
    );
  }

  static MorseExercisesTableCompanion toCompanion(MorseExercise entity) {
    return MorseExercisesTableCompanion.insert(
      exerciseContentType: entity.contentType,
      translateType: entity.direction,
      exerciseValues: jsonEncode(entity.exerciseValues),
      translatedValues: jsonEncode(entity.translatedValues),
      count: entity.exerciseValues.length,
      interactionType: entity.interactionType,
    );
  }
}
