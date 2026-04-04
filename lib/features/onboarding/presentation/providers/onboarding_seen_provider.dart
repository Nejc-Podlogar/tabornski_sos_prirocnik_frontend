import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../settings/presentation/providers/user_preferences_provider.dart';

/// Read-only view of [UserPreferences.onboardingSeen].
/// Watched by the router guard via [ProviderListenableAdapter].
final onboardingSeenProvider = FutureProvider<bool>((ref) async {
  final preferences = await ref.watch(
    userPreferencesProvider.future,
  );
  return preferences.onboardingSeen;
});
