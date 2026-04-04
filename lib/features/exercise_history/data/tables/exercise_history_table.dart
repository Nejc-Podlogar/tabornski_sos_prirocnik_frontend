import 'package:drift/drift.dart';

import '../../domain/value_objects/feature_type.dart';

class ExerciseHistoryTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get featureType =>
      textEnum<FeatureType>()();

  TextColumn get exerciseContentType => text()();

  TextColumn get interactionType => text()();

  IntColumn get totalQuestions => integer()();

  IntColumn get correctCount => integer()();

  /// Unix milliseconds.
  IntColumn get sessionDate => integer()();

  IntColumn get durationSeconds => integer()();
}
