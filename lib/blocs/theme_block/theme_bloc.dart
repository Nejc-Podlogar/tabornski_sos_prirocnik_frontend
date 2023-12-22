import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabornski_sos_prirocnik_frontend/blocs/theme_block/theme_event.dart';
import 'package:tabornski_sos_prirocnik_frontend/blocs/theme_block/theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(LightThemeState()) {
    on<ToggleThemeEvent>((event, emit) => _mapToggleThemeEventToState(state, emit));
  }


  Stream<ThemeState> _mapToggleThemeEventToState(ThemeState state, Emitter<ThemeState> emit) async* {
    if(state is LightThemeState) {
      emit(DarkThemeState());
    } else {
      emit(LightThemeState());
    }
  }

}