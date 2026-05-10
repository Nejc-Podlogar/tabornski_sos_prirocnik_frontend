import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../domain/entities/exercise_session.dart';

class ExerciseSessionMapper {
  ExerciseSessionMapper._();

  static ExerciseSession fromRow(ExerciseHistoryTableData row) {
    return ExerciseSession(
      id: row.id,
      featureType: row.featureType,
      exerciseContentType: row.exerciseContentType,
      interactionType: row.interactionType,
      totalQuestions: row.totalQuestions,
      correctCount: row.correctCount,
      sessionDate:
          DateTime.fromMillisecondsSinceEpoch(row.sessionDate, isUtc: true),
      durationSeconds: row.durationSeconds,
    );
  }

  static ExerciseHistoryTableCompanion toCompanion(ExerciseSession entity) {
    return ExerciseHistoryTableCompanion.insert(
      featureType: entity.featureType,
      exerciseContentType: entity.exerciseContentType,
      interactionType: entity.interactionType,
      totalQuestions: entity.totalQuestions,
      correctCount: entity.correctCount,
      sessionDate: entity.sessionDate.millisecondsSinceEpoch,
      durationSeconds: entity.durationSeconds,
    );
  }
}
