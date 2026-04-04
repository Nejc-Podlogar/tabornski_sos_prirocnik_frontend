import '../entities/user_preferences.dart';
import '../repositories/i_user_preferences_repository.dart';

class GetUserPreferencesUseCase {
  const GetUserPreferencesUseCase(this._repository);

  final IUserPreferencesRepository _repository;

  Future<UserPreferences> call() => _repository.get();
}
