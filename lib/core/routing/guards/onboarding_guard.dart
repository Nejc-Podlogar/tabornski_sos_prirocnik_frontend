import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../features/onboarding/presentation/providers/onboarding_seen_provider.dart';
import '../route_names.dart';

/// Guard applied to `/` and `/onboarding`.
///
/// Uses [ProviderContainer.read] intentionally — redirect callbacks are not
/// widget builds and do not subscribe to provider changes. Re-evaluation is
/// triggered externally by the [ProviderListenableAdapter] wired to
/// GoRouter's [refreshListenable] in app_router.dart, which calls
/// [notifyListeners] whenever [onboardingSeenProvider] emits a new value.
String? onboardingGuard(ProviderContainer container, GoRouterState state) {
  final asyncValue = container.read(onboardingSeenProvider);

  return asyncValue.when(
    data: (seen) {
      if (seen && state.matchedLocation == '/${RouteNames.onboarding}') {
        return '/${RouteNames.home}';
      }
      if (!seen && state.matchedLocation != '/${RouteNames.onboarding}') {
        return '/${RouteNames.onboarding}';
      }
      return null;
    },
    loading: () => null, // no redirect while loading — refreshListenable re-triggers
    error: (_, __) => null, // fail open on error
  );
}
