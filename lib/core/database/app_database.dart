import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import '../../features/exercise_history/data/tables/exercise_history_table.dart';
import '../../features/exercise_history/domain/value_objects/feature_type.dart';
import '../../features/home/data/tables/posts_table.dart';
import '../../features/morse/data/tables/morse_exercises_table.dart';
import '../../features/morse/domain/value_objects/exercise_content_type.dart';
import '../../features/morse/domain/value_objects/interaction_type.dart';
import '../../features/morse/domain/value_objects/translation_direction.dart';
import '../../features/orientation/data/tables/orientation_signs_table.dart';
import '../../features/orientation/domain/value_objects/topo_group_type.dart';
import '../../features/semaphore/data/tables/semaphore_exercises_table.dart';
import '../../features/settings/data/tables/user_preferences_table.dart';
import '../../features/settings/domain/value_objects/app_theme_mode.dart';

export '../../features/exercise_history/data/tables/exercise_history_table.dart';
export '../../features/home/data/tables/posts_table.dart';
export '../../features/morse/data/tables/morse_exercises_table.dart';
export '../../features/orientation/data/tables/orientation_signs_table.dart';
export '../../features/semaphore/data/tables/semaphore_exercises_table.dart';
export '../../features/settings/data/tables/user_preferences_table.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    PostsTable,
    MorseExercisesTable,
    SemaphoreExercisesTable,
    OrientationSignsTable,
    UserPreferencesTable,
    ExerciseHistoryTable,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(driftDatabase(name: 'app'));

  @override
  int get schemaVersion => 1;
}
