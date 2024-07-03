import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:tabornski_sos_prirocnik_frontend/blocs/morse_exercise_bloc/morse_exercise_bloc.dart';
import 'package:tabornski_sos_prirocnik_frontend/blocs/theme_block/theme_bloc.dart';
import 'package:tabornski_sos_prirocnik_frontend/blocs/theme_block/theme_state.dart';
import 'package:tabornski_sos_prirocnik_frontend/routing/app_router.dart';
import 'package:tabornski_sos_prirocnik_frontend/utils/shared_prefs.dart';

import 'blocs/morse_translation_bloc/morse_translation_bloc.dart';
import 'blocs/semaphore_bloc/semaphore_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  bool showWelcome = await SharedPrefs().isFirstTime();
  await dotenv.load(fileName: ".env");

  //GoRouter part & definitions
  final goRouter = AppRouter.router;

  runApp(MyApp(showWelcome: showWelcome, goRouter: goRouter));
}

class MyApp extends StatelessWidget {
  final bool showWelcome;
  final GoRouter goRouter;

  const MyApp({super.key, required this.showWelcome, required this.goRouter});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ThemeBloc()),
          BlocProvider(create: (context) => MorseTranslationBloc()),
          BlocProvider(create: (context) => SemaphoreBloc()),
          BlocProvider(create: (context) => MorseExerciseBloc()),
        ],
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, ThemeState state) {
            return MaterialApp.router(
              routerConfig: goRouter,
              theme: state.themeData,
              title: 'Taborniški SOS priročnik',
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              );
          },
        ));
  }
}
