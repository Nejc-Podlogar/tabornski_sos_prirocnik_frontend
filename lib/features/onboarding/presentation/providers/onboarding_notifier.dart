import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../settings/presentation/providers/user_preferences_provider.dart';
import '../../../settings/presentation/providers/user_preferences_repository_provider.dart';
import '../../domain/usecases/mark_onboarding_seen_usecase.dart';

final onboardingNotifierProvider =
    AsyncNotifierProvider<OnboardingNotifier, void>(OnboardingNotifier.new);

class OnboardingNotifier extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<void> markSeen() async {
    final repo = ref.read(userPreferencesRepositoryProvider);
    final useCase = MarkOnboardingSeenUseCase(repo);
    await useCase.call();
    ref.invalidate(userPreferencesProvider);
    await Future.delayed(const Duration(milliseconds: 100));
  }
}
