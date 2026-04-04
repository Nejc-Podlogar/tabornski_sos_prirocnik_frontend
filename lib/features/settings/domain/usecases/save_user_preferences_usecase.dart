import '../entities/user_preferences.dart';
import '../repositories/i_user_preferences_repository.dart';

class SaveUserPreferencesUseCase {
  const SaveUserPreferencesUseCase(this._repository);

  final IUserPreferencesRepository _repository;

  Future<void> call(UserPreferences preferences) =>
      _repository.save(preferences);
}
