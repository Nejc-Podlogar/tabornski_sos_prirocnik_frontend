import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../domain/entities/user_preferences.dart';

class UserPreferencesMapper {
  UserPreferencesMapper._();

  static UserPreferences fromRow(UserPreferencesTableData row) {
    return UserPreferences(
      themeMode: row.themeMode,
      username: row.username,
      avatarId: row.avatarId,
      onboardingSeen: row.onboardingSeen,
    );
  }

  static UserPreferencesTableCompanion toCompanion(UserPreferences entity) {
    return UserPreferencesTableCompanion(
      themeMode: Value(entity.themeMode),
      username: Value(entity.username),
      avatarId: Value(entity.avatarId),
      onboardingSeen: Value(entity.onboardingSeen),
    );
  }
}
