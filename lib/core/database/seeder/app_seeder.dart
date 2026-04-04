import '../app_database.dart';
import 'i_seeder.dart';
import 'morse_corpus_seeder.dart';
import 'orientation_seeder.dart';
import 'semaphore_corpus_seeder.dart';
import 'user_preferences_seeder.dart';

class AppSeeder {
  AppSeeder._();

  static Future<void> run(AppDatabase db) async {
    final rowCount = await db.userPreferencesTable.count().getSingle();
    if (rowCount > 0) return;

    final seeders = <ISeeder>[
      UserPreferencesSeeder(),
      OrientationSeeder(),
      MorseCorpusSeeder(),
      SemaphoreCorpusSeeder(),
    ];

    for (final seeder in seeders) {
      await seeder.seed(db);
    }
  }
}
