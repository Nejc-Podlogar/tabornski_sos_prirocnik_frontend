import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:tabornski_sos_prirocnik_frontend/api/post_api_service.dart';
import 'package:tabornski_sos_prirocnik_frontend/blocs/morse_exercise_bloc/morse_exercise_bloc.dart';
import 'package:tabornski_sos_prirocnik_frontend/blocs/orientation_exercise_bloc/orientation_exercise_bloc.dart';
import 'package:tabornski_sos_prirocnik_frontend/blocs/post_cubit/post_cubit.dart';
import 'package:tabornski_sos_prirocnik_frontend/blocs/theme_block/theme_bloc.dart';
import 'package:tabornski_sos_prirocnik_frontend/blocs/theme_block/theme_state.dart';
import 'package:tabornski_sos_prirocnik_frontend/routing/app_router.dart';
import 'package:tabornski_sos_prirocnik_frontend/themes/default_dark.dart';
import 'package:tabornski_sos_prirocnik_frontend/themes/default_light.dart';
import 'package:tabornski_sos_prirocnik_frontend/utils/shared_prefs.dart';

import 'blocs/morse_translation_bloc/morse_translation_bloc.dart';
import 'blocs/semaphore_bloc/semaphore_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  //GoRouter part & definitions
  final goRouter = AppRouter.router;

  runApp(MyApp(goRouter: goRouter));
}

class MyApp extends StatelessWidget {
  final GoRouter goRouter;

  const MyApp({super.key, required this.goRouter});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final postApiService = PostApiService();


    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ThemeBloc()),
          BlocProvider(create: (context) => MorseTranslationBloc()),
          BlocProvider(create: (context) => SemaphoreBloc()),
          BlocProvider(create: (context) => MorseExerciseBloc()),
          BlocProvider(create: (context) => PostCubit(postApiService)),
          BlocProvider(create: (context) => OrientationExerciseBloc())
        ],
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, ThemeState state) {
            return MaterialApp.router(
              routerConfig: goRouter,
              theme: state is LightThemeState ? lightTheme : darkTheme,
              title: 'Taborniški SOS priročnik',
              localizationsDelegates: const [
                S.delegate,
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: AppLocalizations.supportedLocales,
              );
          },
        ));
  }
}
