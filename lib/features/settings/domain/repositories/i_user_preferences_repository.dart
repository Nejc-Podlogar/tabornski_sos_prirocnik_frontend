import '../entities/user_preferences.dart';

abstract interface class IUserPreferencesRepository {
  Future<UserPreferences> get();
  Future<void> save(UserPreferences preferences);
}
