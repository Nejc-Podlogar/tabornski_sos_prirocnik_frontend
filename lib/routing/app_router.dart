import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../views/home/home_screen.dart';
import '../views/morse_code/morse_code.dart';
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