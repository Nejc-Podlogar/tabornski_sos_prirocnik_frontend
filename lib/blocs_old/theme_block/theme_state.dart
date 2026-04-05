
import 'package:flutter/material.dart';
import 'package:tabornski_sos_prirocnik_frontend/themes/default_dark.dart';
import 'package:tabornski_sos_prirocnik_frontend/themes/default_light.dart';

abstract class ThemeState {
  final ThemeData themeData;

  ThemeState(this.themeData);
}

class LightThemeState extends ThemeState {
  LightThemeState() : super(lightTheme);
}

class DarkThemeState extends ThemeState {
  DarkThemeState(): super(darkTheme);
}