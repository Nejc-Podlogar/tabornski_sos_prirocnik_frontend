import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../domain/entities/user_preferences.dart';
import '../../domain/repositories/i_user_preferences_repository.dart';
import '../mappers/user_preferences_mapper.dart';

class UserPreferencesRepository implements IUserPreferencesRepository {
  const UserPreferencesRepository(this._db);

  final AppDatabase _db;

  @override
  Future<UserPreferences> get() async {
    final row = await (_db.select(_db.userPreferencesTable)
          ..where((t) => t.id.equals(1)))
        .getSingle();
    return UserPreferencesMapper.fromRow(row);
  }

  @override
  Future<void> save(UserPreferences preferences) async {
    await (_db.update(_db.userPreferencesTable)
          ..where((t) => t.id.equals(1)))
        .write(UserPreferencesMapper.toCompanion(preferences));
  }
}
