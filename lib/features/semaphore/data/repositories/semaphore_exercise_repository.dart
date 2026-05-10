import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/domain/value_objects/exercise_enums.dart';
import '../../domain/entities/semaphore_exercise.dart';
import '../../domain/repositories/i_semaphore_exercise_repository.dart';
import '../mappers/semaphore_exercise_mapper.dart';

class SemaphoreExerciseRepository implements ISemaphoreExerciseRepository {
  const SemaphoreExerciseRepository(this._db);

  final AppDatabase _db;

  @override
  Future<List<SemaphoreExercise>> getExercises(
    int count,
    TranslationDirection direction,
    InteractionType interactionType,
  ) async {
    final rows = await (_db.select(_db.semaphoreExercisesTable)
          ..where(
            (t) =>
                t.translateType.equalsValue(direction) &
                t.interactionType.equalsValue(interactionType),
          )
          ..limit(count))
        .get();

    return rows.map(SemaphoreExerciseMapper.fromRow).toList();
  }
}
