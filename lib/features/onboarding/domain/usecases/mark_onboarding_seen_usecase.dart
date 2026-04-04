import '../../../settings/domain/repositories/i_user_preferences_repository.dart';

class MarkOnboardingSeenUseCase {
  const MarkOnboardingSeenUseCase(this._repository);

  final IUserPreferencesRepository _repository;

  Future<void> call() async {
    final current = await _repository.get();
    await _repository.save(current.copyWith(onboardingSeen: true));
  }
}
