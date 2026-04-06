import 'package:drift/drift.dart';

import '../../../../core/domain/value_objects/exercise_enums.dart';

class MorseExercisesTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get exerciseContentType =>
      textEnum<ExerciseContentType>()();

  TextColumn get translateType =>
      textEnum<TranslationDirection>()();

  // Column renamed from 'values' to 'exercise_values'
  // to avoid conflict with Dart enum .values getter
  TextColumn get exerciseValues => text()();

  /// JSON array of strings.
  TextColumn get translatedValues => text()();

  IntColumn get count => integer()();

  TextColumn get interactionType =>
      textEnum<InteractionType>()();
}
