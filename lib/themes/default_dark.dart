import 'package:flutter/material.dart';

final ThemeData darkTheme = ThemeData(
  fontFamily: 'JetBrains Mono',
  splashColor: Colors.transparent,
  primaryColor: const Color(0xFF5E8C61),
  hintColor: const Color(0xFF611599),
  textTheme: const TextTheme(
    displayLarge: TextStyle(color: Colors.black),
    bodyLarge: TextStyle(color: Colors.black),
  ),
  scaffoldBackgroundColor: const Color(0xFF1A1A1A),
  appBarTheme: const AppBarTheme(
    foregroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    shadowColor: Colors.transparent,
    backgroundColor: Color(0xFF5E8C61),
    titleTextStyle: TextStyle(color: Colors.white),
    iconTheme: IconThemeData(color: Colors.white),
  ),
  cardTheme: const CardTheme(
    color: Colors.white, // Default card background
  ),
  chipTheme: const ChipThemeData(
    backgroundColor: Colors.white,
    labelStyle: TextStyle(
        color: Color(0xFFB2B39C),
    ),
    brightness: Brightness.dark,
    selectedColor: Color(0xFFB2B39C),
    checkmarkColor: Colors.white,
    shape: RoundedRectangleBorder(
      side: BorderSide(
        color: Color(0xFFB2B39C),
        width: 1.5,
      ),
      borderRadius: BorderRadius.all(
          Radius.circular(10),
      ),
    ),

  ),
);

final CardTheme primaryCardTheme = CardTheme(
  color: const Color(0xFFB2B39C),
  elevation: 2,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(25),
  ),
);

const TextStyle primaryCardTextStyle = TextStyle(
  color: Colors.white,
);

const IconThemeData primaryCardIconTheme = IconThemeData(
  color: Colors.white,
);

final CardTheme secondaryCardTheme = CardTheme(
  color: Colors.white,
  elevation: 2,
  shape: RoundedRectangleBorder(
    side: const BorderSide(
      color: Color(0xFF611599),
      width: 2,
    ),
    borderRadius: BorderRadius.circular(4.0),
  ),
);

const TextStyle secondaryCardTextStyle = TextStyle(
  color: Color(0xFF611599),
);

const IconThemeData secondaryCardIconTheme = IconThemeData(
  color: Color(0xFF611599),
);
