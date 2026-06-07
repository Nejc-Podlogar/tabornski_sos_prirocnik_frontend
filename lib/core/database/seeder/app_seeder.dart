import 'package:flutter/foundation.dart';

import '../app_database.dart';
import 'i_seeder.dart';
import 'morse_corpus_seeder.dart';
import 'orientation_seeder.dart';
import 'semaphore_corpus_seeder.dart';
import 'user_preferences_seeder.dart';

class AppSeeder {
  AppSeeder._();

  static Future<void> run(AppDatabase db) async {
    debugPrint('AppSeeder.run() called');

    final seeders = <ISeeder>[
      UserPreferencesSeeder(),
      MorseCorpusSeeder(),
      SemaphoreCorpusSeeder(),
      OrientationSeeder(),
    ];

    for (final seeder in seeders) {
      try {
        await seeder.seed(db);
        debugPrint('AppSeeder: ${seeder.runtimeType} complete');
      } catch (e) {
        debugPrint('AppSeeder: ${seeder.runtimeType} failed — $e');
        // Continue with next seeder
      }
    }
  }
}
