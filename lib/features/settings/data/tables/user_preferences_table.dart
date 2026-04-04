import 'package:drift/drift.dart';

import '../../domain/value_objects/app_theme_mode.dart';

class UserPreferencesTable extends Table {
  IntColumn get id => integer()();

  TextColumn get themeMode =>
      textEnum<AppThemeMode>().withDefault(const Constant('dark'))();

  TextColumn get username => text().nullable()();

  TextColumn get avatarId => text().nullable()();

  BoolColumn get onboardingSeen =>
      boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}
