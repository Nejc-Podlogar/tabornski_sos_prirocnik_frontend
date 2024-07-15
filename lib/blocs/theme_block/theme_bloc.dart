import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabornski_sos_prirocnik_frontend/blocs/theme_block/theme_event.dart';
import 'package:tabornski_sos_prirocnik_frontend/blocs/theme_block/theme_state.dart';
import 'package:tabornski_sos_prirocnik_frontend/utils/shared_prefs.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(LightThemeState()) {
    _loadThemePreference();
    on<ToggleThemeEvent>((event, emit) => _mapToggleThemeEventToState(state, emit));
  }

  void _loadThemePreference() async {
    final bool isDarkMode = await SharedPrefs().getTheme();
    if(isDarkMode) {
      emit(DarkThemeState());
    } else {
      emit(LightThemeState());
    }
  }


  void _mapToggleThemeEventToState(ThemeState state, Emitter<ThemeState> emit) {
    if(state is LightThemeState) {
      emit(DarkThemeState());
      SharedPrefs().setTheme(true);
    } else {
      emit(LightThemeState());
      SharedPrefs().setTheme(false);
    }
  }

}