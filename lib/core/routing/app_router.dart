import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/onboarding/presentation/providers/onboarding_seen_provider.dart';
import 'guards/onboarding_guard.dart';
import 'provider_listenable.dart';
import 'route_names.dart';

// Placeholder screens — replaced when feature screens are implemented.
class _PlaceholderScreen extends StatelessWidget {
  const _PlaceholderScreen({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) =>
      Scaffold(body: Center(child: Text(label)));
}

/// Creates the app router and its associated refresh listenable.
///
/// [container] must be the [ProviderContainer] from [ProviderScope].
/// Call this inside a widget build method where context is available:
///
/// ```dart
/// // main.dart (GROUP 26):
/// final (:router, :listenable) =
///     createAppRouter(ProviderScope.containerOf(context));
/// ```
///
/// The caller owns both lifecycles. When the app shuts down:
/// // TODO: GROUP 26 — call listenable.dispose() on app shutdown.
({GoRouter router, ChangeNotifier listenable}) createAppRouter(
    ProviderContainer container) {
  final listenable = ProviderListenableAdapter(
    container,
    onboardingSeenProvider,
  );

  final router = GoRouter(
    initialLocation: '/',
    refreshListenable: listenable,
    redirect: (context, state) => onboardingGuard(container, state),
    routes: [
      // Root redirect — handled entirely by guard
      GoRoute(
        path: '/',
        name: RouteNames.root,
        builder: (_, __) => const SizedBox.shrink(),
      ),

      // Onboarding
      GoRoute(
        path: '/${RouteNames.onboarding}',
        name: RouteNames.onboarding,
        redirect: (context, state) => onboardingGuard(container, state),
        builder: (_, __) =>
            const _PlaceholderScreen(label: 'Onboarding'),
      ),

      // Shell: bottom-nav screens
      ShellRoute(
        builder: (context, state, child) => child,
        routes: [
          // Home
          GoRoute(
            path: '/${RouteNames.home}',
            name: RouteNames.home,
            builder: (_, __) =>
                const _PlaceholderScreen(label: 'Home'),
          ),

          // Morse
          GoRoute(
            path: '/morse',
            name: RouteNames.morse,
            builder: (_, __) =>
                const _PlaceholderScreen(label: 'Morse'),
            routes: [
              GoRoute(
                path: 'translator',
                name: RouteNames.morseTranslator,
                builder: (_, __) =>
                    const _PlaceholderScreen(label: 'Morse Translator'),
              ),
              GoRoute(
                path: 'materials',
                name: RouteNames.morseMaterials,
                builder: (_, __) =>
                    const _PlaceholderScreen(label: 'Morse Materials'),
              ),
              GoRoute(
                path: 'flashlight',
                name: RouteNames.morseFlashlight,
                builder: (_, __) =>
                    const _PlaceholderScreen(label: 'Morse Flashlight'),
              ),
              GoRoute(
                path: 'exercises',
                name: RouteNames.morseExercises,
                builder: (_, __) =>
                    const _PlaceholderScreen(label: 'Morse Exercises'),
                routes: [
                  GoRoute(
                    path: 'selector',
                    name: RouteNames.morseExerciseSelector,
                    builder: (_, __) =>
                        const _PlaceholderScreen(
                            label: 'Morse Exercise Selector'),
                  ),
                  GoRoute(
                    path: 'session',
                    name: RouteNames.morseExerciseSession,
                    redirect: (context, state) {
                      if (state.extra == null) {
                        return GoRouter.of(context)
                            .namedLocation(RouteNames.morseExerciseSelector);
                      }
                      return null;
                    },
                    builder: (_, __) =>
                        const _PlaceholderScreen(
                            label: 'Morse Exercise Session'),
                  ),
                ],
              ),
            ],
          ),

          // Semaphore
          GoRoute(
            path: '/semaphore',
            name: RouteNames.semaphore,
            builder: (_, __) =>
                const _PlaceholderScreen(label: 'Semaphore'),
            routes: [
              GoRoute(
                path: 'translator',
                name: RouteNames.semaphoreTranslator,
                builder: (_, __) =>
                    const _PlaceholderScreen(
                        label: 'Semaphore Translator'),
              ),
              GoRoute(
                path: 'materials',
                name: RouteNames.semaphoreMaterials,
                builder: (_, __) =>
                    const _PlaceholderScreen(
                        label: 'Semaphore Materials'),
              ),
              GoRoute(
                path: 'exercises',
                name: RouteNames.semaphoreExercises,
                builder: (_, __) =>
                    const _PlaceholderScreen(
                        label: 'Semaphore Exercises'),
                routes: [
                  GoRoute(
                    path: 'selector',
                    name: RouteNames.semaphoreExerciseSelector,
                    builder: (_, __) =>
                        const _PlaceholderScreen(
                            label: 'Semaphore Exercise Selector'),
                  ),
                  GoRoute(
                    path: 'session',
                    name: RouteNames.semaphoreExerciseSession,
                    redirect: (context, state) {
                      if (state.extra == null) {
                        return GoRouter.of(context).namedLocation(
                            RouteNames.semaphoreExerciseSelector);
                      }
                      return null;
                    },
                    builder: (_, __) =>
                        const _PlaceholderScreen(
                            label: 'Semaphore Exercise Session'),
                  ),
                ],
              ),
            ],
          ),

          // Orientation
          GoRoute(
            path: '/orientation',
            name: RouteNames.orientation,
            builder: (_, __) =>
                const _PlaceholderScreen(label: 'Orientation'),
            routes: [
              GoRoute(
                path: 'exercises',
                name: RouteNames.orientationExercises,
                builder: (_, __) =>
                    const _PlaceholderScreen(
                        label: 'Orientation Exercises'),
                routes: [
                  GoRoute(
                    path: 'selector',
                    name: RouteNames.orientationExerciseSelector,
                    builder: (_, __) =>
                        const _PlaceholderScreen(
                            label: 'Orientation Exercise Selector'),
                  ),
                  GoRoute(
                    path: 'session',
                    name: RouteNames.orientationExerciseSession,
                    redirect: (context, state) {
                      if (state.extra == null) {
                        return GoRouter.of(context).namedLocation(
                            RouteNames.orientationExerciseSelector);
                      }
                      return null;
                    },
                    builder: (_, __) =>
                        const _PlaceholderScreen(
                            label: 'Orientation Exercise Session'),
                  ),
                ],
              ),
              GoRoute(
                path: 'reference/:categoryId',
                name: RouteNames.orientationReference,
                // No guard — unknown categoryId shows empty state in screen
                builder: (_, __) =>
                    const _PlaceholderScreen(
                        label: 'Orientation Reference'),
              ),
              GoRoute(
                path: 'pdf',
                name: RouteNames.orientationPdf,
                builder: (_, __) =>
                    const _PlaceholderScreen(label: 'PDF Viewer'),
              ),
            ],
          ),

          // Settings
          GoRoute(
            path: '/settings',
            name: RouteNames.settings,
            builder: (_, __) =>
                const _PlaceholderScreen(label: 'Settings'),
            routes: [
              GoRoute(
                path: 'edit-profile',
                name: RouteNames.settingsEditProfile,
                builder: (_, __) =>
                    const _PlaceholderScreen(label: 'Edit Profile'),
              ),
              GoRoute(
                path: 'permissions',
                name: RouteNames.settingsPermissions,
                builder: (_, __) =>
                    const _PlaceholderScreen(label: 'Permissions'),
              ),
            ],
          ),

          // Exercise history
          GoRoute(
            path: '/exercise-history',
            name: RouteNames.exerciseHistory,
            builder: (_, __) =>
                const _PlaceholderScreen(label: 'Exercise History'),
          ),
        ],
      ),

      // Utility — outside shell
      GoRoute(
        path: '/pdf-viewer',
        name: RouteNames.pdfViewer,
        builder: (_, __) =>
            const _PlaceholderScreen(label: 'PDF Viewer'),
      ),
      GoRoute(
        path: '/webview',
        name: RouteNames.webview,
        builder: (_, __) =>
            const _PlaceholderScreen(label: 'Webview'),
      ),
    ],
  );

  return (router: router, listenable: listenable);
}
