import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/usecases/save_user_preferences_usecase.dart';
import '../../domain/value_objects/app_theme_mode.dart';
import 'user_preferences_provider.dart';
import 'user_preferences_repository_provider.dart';

/// Current theme mode. Initialised from persisted [UserPreferences].
///
/// Updating this provider via [setThemeMode] persists the change via
/// [SaveUserPreferencesUseCase] and refreshes [userPreferencesProvider].
final themeModeProvider =
    NotifierProvider<ThemeModeNotifier, AppThemeMode>(
  ThemeModeNotifier.new,
);

class ThemeModeNotifier extends Notifier<AppThemeMode> {
  @override
  AppThemeMode build() {
    // ref.read: initialise once only. setThemeMode manages
    // state updates directly — watching would cause a
    // redundant rebuild loop on every theme change.
    return ref.read(userPreferencesProvider).valueOrNull?.themeMode ??
        AppThemeMode.dark;
  }

  Future<void> setThemeMode(AppThemeMode mode) async {
    state = mode;
    final repo = ref.read(userPreferencesRepositoryProvider);
    final useCase = SaveUserPreferencesUseCase(repo);
    final current = await ref.read(userPreferencesProvider.future);
    await useCase(current.copyWith(themeMode: mode));
    ref.invalidate(userPreferencesProvider);
  }
}
