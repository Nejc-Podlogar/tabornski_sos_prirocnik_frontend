import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/database_provider.dart';
import '../../data/repositories/exercise_history_repository.dart';
import '../../domain/repositories/i_exercise_history_repository.dart';

final exerciseHistoryRepositoryProvider =
    Provider<IExerciseHistoryRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return ExerciseHistoryRepository(db);
});
