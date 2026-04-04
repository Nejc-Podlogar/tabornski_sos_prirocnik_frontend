import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/user_preferences.dart';
import '../../domain/usecases/get_user_preferences_usecase.dart';
import '../../domain/usecases/save_user_preferences_usecase.dart';
import 'user_preferences_repository_provider.dart';

final userPreferencesProvider =
    AsyncNotifierProvider<UserPreferencesNotifier, UserPreferences>(
  UserPreferencesNotifier.new,
);

class UserPreferencesNotifier extends AsyncNotifier<UserPreferences> {
  @override
  Future<UserPreferences> build() async {
    final repo = ref.watch(userPreferencesRepositoryProvider);
    final useCase = GetUserPreferencesUseCase(repo);
    return useCase.call();
  }

  Future<void> save(UserPreferences preferences) async {
    final repo = ref.read(userPreferencesRepositoryProvider);
    final useCase = SaveUserPreferencesUseCase(repo);
    await useCase.call(preferences);
    ref.invalidateSelf();
  }
}
