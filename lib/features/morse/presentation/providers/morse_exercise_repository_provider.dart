import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/database_provider.dart';
import '../../data/repositories/morse_exercise_repository.dart';
import '../../domain/repositories/i_morse_exercise_repository.dart';

final morseExerciseRepositoryProvider =
    Provider<IMorseExerciseRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return MorseExerciseRepository(db);
});
