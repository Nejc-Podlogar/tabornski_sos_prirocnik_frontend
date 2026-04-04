import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/database_provider.dart';
import '../../data/repositories/user_preferences_repository.dart';
import '../../domain/repositories/i_user_preferences_repository.dart';

final userPreferencesRepositoryProvider =
    Provider<IUserPreferencesRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return UserPreferencesRepository(db);
});
