import 'package:drift/drift.dart';

import '../../../features/settings/domain/value_objects/app_theme_mode.dart';
import '../app_database.dart';
import 'i_seeder.dart';

class UserPreferencesSeeder implements ISeeder {
  @override
  Future<void> seed(AppDatabase db) async {
    await db.into(db.userPreferencesTable).insertOnConflictUpdate(
      UserPreferencesTableCompanion.insert(
        id: const Value(1),
        themeMode: const Value(AppThemeMode.dark),
        username: const Value<String?>(null),
        role: const Value<String?>(null),
        avatarId: const Value<String?>(null),
        onboardingSeen: const Value(false),
      ),
    );
  }
}
