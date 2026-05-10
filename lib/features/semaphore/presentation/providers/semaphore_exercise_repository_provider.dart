import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/database_provider.dart';
import '../../data/repositories/semaphore_exercise_repository.dart';
import '../../domain/repositories/i_semaphore_exercise_repository.dart';

final semaphoreExerciseRepositoryProvider =
    Provider<ISemaphoreExerciseRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return SemaphoreExerciseRepository(db);
});
