import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../domain/entities/exercise_session.dart';
import '../../domain/repositories/i_exercise_history_repository.dart';
import '../mappers/exercise_session_mapper.dart';

class ExerciseHistoryRepository implements IExerciseHistoryRepository {
  const ExerciseHistoryRepository(this._db);

  final AppDatabase _db;

  @override
  Future<List<ExerciseSession>> getAll() async {
    final rows = await (_db.select(_db.exerciseHistoryTable)
          ..orderBy([(t) => OrderingTerm.desc(t.sessionDate)]))
        .get();
    return rows.map(ExerciseSessionMapper.fromRow).toList();
  }

  @override
  Future<void> save(ExerciseSession session) async {
    await _db
        .into(_db.exerciseHistoryTable)
        .insert(ExerciseSessionMapper.toCompanion(session));
  }

  @override
  Future<void> clearAll() async {
    await _db.delete(_db.exerciseHistoryTable).go();
  }
}
