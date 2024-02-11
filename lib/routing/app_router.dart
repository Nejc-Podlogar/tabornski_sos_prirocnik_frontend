import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../blocs/morse_translation_bloc/morse_translation_bloc.dart';
import '../views/home/home_screen.dart';
import '../views/morse_code/morse_code.dart';
import '../views/morse_code/morse_code_translator.dart';
import '../views/orientation/orientation.dart';
import '../views/settings/settings.dart';
import '../views/welcome/welcome_screen.dart';

class AppRouter {
  static GoRouter router = GoRouter(
    routes: [
      GoRoute(
          name: 'root',
          path: '/',
          pageBuilder: (context, state) {
            return MaterialPage(child: WelcomeView());
          },
          routes: <RouteBase>[
            GoRoute(
              name: 'home',
              path: 'home',
              pageBuilder: (context, state) {
                return const MaterialPage(child: HomeView());
              },
            ),
            GoRoute(
              name: 'morse-code',
              path: 'morse-code',
              pageBuilder: (context, state) {
                return const MaterialPage(child: MorseCodeView());
              },
              routes: <GoRoute> [
                GoRoute(
                  name: 'morse-code-translator',
                  path: 'morse-translator',
                  pageBuilder: (context, state) {
                    return MaterialPage(
                        child: BlocProvider(
                            create: (context) => MorseTranslationBloc(),
                            child: const MorseCodeTranslatorView()
                        ));
                  }
                )
              ]
            ),
            GoRoute(
              name: 'orientation',
              path: 'orientation',
              pageBuilder: (context, state) {
                return const MaterialPage(child: OrientationView());
              },
            ),
            GoRoute(
              name: 'settings',
              path: 'settings',
              pageBuilder: (context, state) {
                return const MaterialPage(child: SettingsView());
              },
            )
          ]
      ),

    ],
  );
}