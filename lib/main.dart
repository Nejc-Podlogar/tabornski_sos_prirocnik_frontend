import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/constants/app_colors.dart';
import 'core/constants/app_spacing.dart';
import 'core/constants/app_typography.dart';
import 'core/database/database_provider.dart';
import 'core/database/seeder/app_seeder.dart';
import 'core/routing/app_router.dart';
import 'core/theme/app_theme.dart';
import 'features/settings/domain/value_objects/app_theme_mode.dart';
import 'features/settings/presentation/providers/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Edge-to-edge: app draws behind transparent system bars.
  // AppBar handles the top status bar inset; the MaterialApp.router builder
  // below handles the bottom navigation bar inset globally.
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  runApp(const ProviderScope(child: _AppBootstrap()));
}

class _AppBootstrap extends ConsumerStatefulWidget {
  const _AppBootstrap();

  @override
  ConsumerState<_AppBootstrap> createState() => _AppBootstrapState();
}

class _AppBootstrapState extends ConsumerState<_AppBootstrap> {
  late final Future<void> _seedFuture;

  // RouterConfig<Object> is the Flutter base type GoRouter implements —
  // typed here to avoid importing go_router directly in main.dart.
  late final RouterConfig<Object> _router;
  late final ChangeNotifier _listenable;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _seedFuture = _runSeeder();
  }

  Future<void> _runSeeder() async {
    final db = ref.read(appDatabaseProvider);
    await AppSeeder.run(db);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      // Container retrieved here rather than build():
      // didChangeDependencies runs before build() and
      // guarantees context is available exactly once.
      final container = ProviderScope.containerOf(context);
      final result = createAppRouter(container);
      _router = result.router;
      _listenable = result.listenable;
      _initialized = true;
    }
  }

  @override
  void dispose() {
    _listenable.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appThemeMode = ref.watch(themeModeProvider);
    final themeMode = switch (appThemeMode) {
      AppThemeMode.dark => ThemeMode.dark,
      AppThemeMode.light => ThemeMode.light,
      AppThemeMode.system => ThemeMode.system,
    };

    return FutureBuilder<void>(
      future: _seedFuture,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppTheme.dark(),
            home: Scaffold(
              backgroundColor: AppColors.background,
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.xxl),
                  child: Text(
                    'Napaka pri zagonu aplikacije.\n${snapshot.error}',
                    style: AppTypography.body.copyWith(
                      color: AppColors.danger,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          );
        }

        if (snapshot.connectionState != ConnectionState.done) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppTheme.dark(),
            home: Scaffold(
              backgroundColor: AppColors.background,
              body: const Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              ),
            ),
          );
        }

        return MaterialApp.router(
          routerConfig: _router,
          theme: AppTheme.light(),
          darkTheme: AppTheme.dark(),
          themeMode: themeMode,
          debugShowCheckedModeBanner: false,
          // Globally shield every screen from the bottom navigation bar.
          // top: false because each Scaffold's AppBar handles the status bar.
          builder: (context, child) =>
              SafeArea(top: false, child: child ?? const SizedBox.shrink()),
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [Locale('sl')],
        );
      },
    );
  }
}
