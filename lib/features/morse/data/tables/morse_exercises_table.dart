import 'package:drift/drift.dart';

import '../../../domain/value_objects/exercise_content_type.dart';
import '../../../domain/value_objects/interaction_type.dart';
import '../../../domain/value_objects/translation_direction.dart';

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
