import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tabornski_sos_prirocnik_frontend/routing/route_definitions.dart';
import 'package:tabornski_sos_prirocnik_frontend/views/semaphore/semaphore_materials.dart';

import '../blocs/morse_translation_bloc/morse_translation_bloc.dart';
import '../views/home/home_screen.dart';
import '../views/morse_code/morse_code.dart';
import '../views/morse_code/morse_code_learning.dart';
import '../views/morse_code/morse_code_materials.dart';
import '../views/morse_code/morse_code_translator.dart';
import '../views/orientation/orientation.dart';
import '../views/semaphore/semaphore.dart';
import '../views/semaphore/semaphore_translator.dart';
import '../views/settings/settings.dart';
import '../views/welcome/welcome_screen.dart';

class AppRouter {
  static GoRouter router = GoRouter(
    routes: [
      GoRoute(
          name: RouteNames.root,
          path: RoutePaths.root,
          pageBuilder: (context, state) {
            return MaterialPage(child: WelcomeView());
          },
          routes: <RouteBase>[
            GoRoute(
              name: RouteNames.home,
              path: RoutePaths.home,
              pageBuilder: (context, state) {
                return const MaterialPage(child: HomeView());
              },
            ),
            GoRoute(
              name: RouteNames.morseCode,
              path: RoutePaths.morseCode,
              pageBuilder: (context, state) {
                return const MaterialPage(child: MorseCodeView());
              },
              routes: <GoRoute> [
                GoRoute(
                  name: RouteNames.morseCodeTranslator,
                  path: RoutePaths.morseCodeTranslator,
                  pageBuilder: (context, state) {
                    return MaterialPage(
                        child: BlocProvider(
                            create: (context) => MorseTranslationBloc(),
                            child: const MorseCodeTranslatorView()
                        ));
                  }
                ),
                GoRoute(
                  name: RouteNames.morseCodeMaterials,
                  path: RoutePaths.morseCodeMaterials,
                  pageBuilder: (context, state) {
                    return const MaterialPage(child: MorseCodeMaterials());
                  }
                ),
                GoRoute(
                  name: RouteNames.morseCodeLearning,
                  path: RoutePaths.morseCodeLearning,
                  pageBuilder: (context, state) {
                    return const MaterialPage(child: MorseCodeLearning());
                  }
                )
              ]
            ),
            GoRoute(
              name: RouteNames.semaphore,
              path: RoutePaths.semaphore,
                pageBuilder: (context, state) {
                  return const MaterialPage(child: SemaphoreView());
                },
              routes: <GoRoute> [
                GoRoute(
                  name: RouteNames.semaphoreTranslator,
                  path: RoutePaths.semaphoreTranslator,
                  pageBuilder: (context, state) {
                    return const MaterialPage(child: SemaphoreTranslatorView());
                  }
                ),
                GoRoute(
                  name: RouteNames.semaphoreMaterials,
                    path: RoutePaths.semaphoreMaterials,
                  pageBuilder: (context, state) {
                    return MaterialPage(child: SemaphoreMaterialsView());
                  }
                )
              ]
            ),
            GoRoute(
              name: RouteNames.orientation,
              path: RoutePaths.orientation,
              pageBuilder: (context, state) {
                return const MaterialPage(child: OrientationView());
              },
            ),
            GoRoute(
              name: RouteNames.settings,
              path: RoutePaths.settings,
              pageBuilder: (context, state) {
                return const MaterialPage(child: SettingsView());
              },
            )
          ]
      ),

    ],
  );
}