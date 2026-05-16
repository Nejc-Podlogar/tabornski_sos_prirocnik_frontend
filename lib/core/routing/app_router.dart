import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/exercise_history/presentation/screens/exercise_history_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/morse/presentation/screens/flashlight_transmitter_screen.dart';
import '../../features/semaphore/presentation/screens/semaphore_exercise_screen.dart';
import '../../features/semaphore/presentation/screens/semaphore_exercise_selector_screen.dart';
import '../../features/semaphore/presentation/screens/semaphore_materials_screen.dart';
import '../../features/semaphore/presentation/screens/semaphore_screen.dart';
import '../../features/semaphore/presentation/screens/semaphore_translator_screen.dart';
import '../../features/morse/presentation/screens/morse_exercise_screen.dart';
import '../../features/morse/presentation/screens/morse_exercise_selector_screen.dart';
import '../../features/morse/presentation/screens/morse_materials_screen.dart';
import '../../features/morse/presentation/screens/morse_screen.dart';
import '../../features/morse/presentation/screens/morse_translator_screen.dart';
import '../../features/onboarding/presentation/providers/onboarding_seen_provider.dart';
import '../../features/onboarding/presentation/screens/onboarding_screen.dart';
import '../../features/settings/presentation/screens/settings_edit_profile_screen.dart';
import '../../features/settings/presentation/screens/settings_permissions_screen.dart';
import '../../features/orientation/presentation/screens/orientation_exercise_screen.dart';
import '../../features/orientation/presentation/screens/orientation_exercise_selector_screen.dart';
import '../../features/orientation/presentation/screens/orientation_reference_screen.dart';
import '../../features/orientation/presentation/screens/orientation_screen.dart';
import '../../features/settings/presentation/screens/settings_screen.dart';
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
  final rootNavigatorKey = GlobalKey<NavigatorState>();
  final shellNavigatorKey = GlobalKey<NavigatorState>();

  final listenable = ProviderListenableAdapter(
    container,
    onboardingSeenProvider,
  );

  final router = GoRouter(
    navigatorKey: rootNavigatorKey,
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

      // Onboarding — root navigator so it covers the full screen
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: '/${RouteNames.onboarding}',
        name: RouteNames.onboarding,
        redirect: (context, state) => onboardingGuard(container, state),
        builder: (_, __) => const OnboardingScreen(),
      ),

      // Shell: bottom-nav screens
      ShellRoute(
        navigatorKey: shellNavigatorKey,
        builder: (context, state, child) => child,
        routes: [
          // Home
          GoRoute(
            path: '/${RouteNames.home}',
            name: RouteNames.home,
            builder: (_, __) => const HomeScreen(),
          ),

          // Morse
          GoRoute(
            path: '/morse',
            name: RouteNames.morse,
            builder: (_, __) => const MorseScreen(),
            routes: [
              GoRoute(
                path: 'translator',
                name: RouteNames.morseTranslator,
                builder: (_, __) => const MorseTranslatorScreen(),
              ),
              GoRoute(
                path: 'materials',
                name: RouteNames.morseMaterials,
                builder: (_, __) => const MorseMaterialsScreen(),
              ),
              GoRoute(
                path: 'exercise-selector',
                name: RouteNames.morseExerciseSelector,
                builder: (_, __) => const MorseExerciseSelectorScreen(),
              ),
              GoRoute(
                path: 'exercise-session',
                name: RouteNames.morseExerciseSession,
                // No extra guard — MorseExerciseScreen handles null state
                // gracefully by showing 'Ni aktivne vaje.'
                builder: (_, __) => const MorseExerciseScreen(),
              ),
            ],
          ),

          // Semaphore
          GoRoute(
            path: '/semaphore',
            name: RouteNames.semaphore,
            builder: (_, __) => const SemaphoreScreen(),
            routes: [
              GoRoute(
                path: 'translator',
                name: RouteNames.semaphoreTranslator,
                builder: (_, __) => const SemaphoreTranslatorScreen(),
              ),
              GoRoute(
                path: 'materials',
                name: RouteNames.semaphoreMaterials,
                builder: (_, __) => const SemaphoreMaterialsScreen(),
              ),
              GoRoute(
                path: 'exercise-selector',
                name: RouteNames.semaphoreExerciseSelector,
                builder: (_, __) => const SemaphoreExerciseSelectorScreen(),
              ),
              GoRoute(
                path: 'exercise-session',
                name: RouteNames.semaphoreExerciseSession,
                // No extra guard — SemaphoreExerciseScreen handles null state
                // gracefully by showing 'Ni aktivne vaje.'
                builder: (_, __) => const SemaphoreExerciseScreen(),
              ),
            ],
          ),

          // Orientation
          GoRoute(
            path: '/orientation',
            name: RouteNames.orientation,
            builder: (_, __) => const OrientationScreen(),
            routes: [
              GoRoute(
                path: 'exercise-selector',
                name: RouteNames.orientationExerciseSelector,
                builder: (_, __) => const OrientationExerciseSelectorScreen(),
              ),
              GoRoute(
                path: 'exercise-session',
                name: RouteNames.orientationExerciseSession,
                // No extra guard — OrientationExerciseScreen handles null state
                // gracefully by showing 'Ni aktivne vaje.'
                builder: (_, __) => const OrientationExerciseScreen(),
              ),
              GoRoute(
                path: 'reference/:categoryId',
                name: RouteNames.orientationReference,
                // No guard — unknown categoryId shows empty state in screen.
                // OrientationReferenceScreen reads categoryId directly from
                // GoRouterState.of(context).pathParameters.
                builder: (_, __) => const OrientationReferenceScreen(),
              ),
            ],
          ),

          // Settings
          GoRoute(
            path: '/settings',
            name: RouteNames.settings,
            builder: (_, __) => const SettingsScreen(),
            routes: [
              GoRoute(
                path: 'edit-profile',
                name: RouteNames.settingsEditProfile,
                builder: (_, __) => const SettingsEditProfileScreen(),
              ),
              GoRoute(
                path: 'permissions',
                name: RouteNames.settingsPermissions,
                builder: (_, __) => const SettingsPermissionsScreen(),
              ),
            ],
          ),

          // Exercise history
          GoRoute(
            path: '/exercise-history',
            name: RouteNames.exerciseHistory,
            builder: (_, __) => const ExerciseHistoryScreen(),
          ),
        ],
      ),

      // Full-screen — root navigator, covers shell entirely
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: '/morse/flashlight',
        name: RouteNames.morseFlashlight,
        pageBuilder: (context, state) {
          final morse = (state.extra as String?) ?? '';
          return CustomTransitionPage(
            key: state.pageKey,
            child: FlashlightTransmitterScreen(initialMorse: morse),
            transitionsBuilder: (context, animation, secondary, child) =>
                SlideTransition(
              position: Tween(
                begin: const Offset(0.0, 1.0),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: animation,
                curve: Curves.easeOutCubic,
              )),
              child: child,
            ),
          );
        },
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: '/pdf-viewer',
        name: RouteNames.pdfViewer,
        // TODO: GROUP 15 — replace with PdfViewerScreen
        builder: (_, __) => const _PlaceholderScreen(label: 'PDF Viewer'),
      ),
      GoRoute(
        path: '/webview',
        name: RouteNames.webview,
        // TODO: GROUP 25 — replace with WebviewScreen
        builder: (_, __) => const _PlaceholderScreen(label: 'Webview'),
      ),
    ],
  );

  return (router: router, listenable: listenable);
}
