import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  fontFamily: 'JetBrains Mono',
  splashColor: Colors.transparent,
  primaryColor: const Color(0xFF5E8C61),
  hintColor: const Color(0xFF611599),
  textTheme: const TextTheme(
    displayLarge: TextStyle(color: Colors.black, fontSize: 24, fontFamily: 'JetBrains Mono'),
    displayMedium: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'JetBrains Mono'),
    displaySmall: TextStyle(color: Colors.black, fontSize: 18, fontFamily: 'JetBrains Mono'),
    bodyLarge: TextStyle(color: Colors.black, fontSize: 16, fontFamily: 'JetBrains Mono'),
    bodyMedium: TextStyle(color: Colors.black, fontSize: 14, fontFamily: 'JetBrains Mono'),
    bodySmall: TextStyle(color: Colors.black, fontSize: 12, fontFamily: 'JetBrains Mono'),
    titleLarge: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'JetBrains Mono'),
    titleMedium: TextStyle(color: Colors.black, fontSize: 18, fontFamily: 'JetBrains Mono'),
    titleSmall: TextStyle(color: Colors.black, fontSize: 16, fontFamily: 'JetBrains Mono'),
    headlineLarge: TextStyle(color: Colors.black, fontSize: 24, fontFamily: 'JetBrains Mono'),
    headlineMedium: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'JetBrains Mono'),
    headlineSmall: TextStyle(color: Colors.black, fontSize: 18, fontFamily: 'JetBrains Mono'),
    labelLarge: TextStyle(color: Colors.black, fontSize: 16, fontFamily: 'JetBrains Mono'),
    labelMedium: TextStyle(color: Colors.black, fontSize: 14, fontFamily: 'JetBrains Mono'),
    labelSmall: TextStyle(color: Colors.black, fontSize: 12, fontFamily: 'JetBrains Mono'),
  ),
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    surfaceTintColor: Colors.transparent,
    shadowColor: Colors.transparent,
    foregroundColor: Colors.transparent,
    backgroundColor: Color(0xFF5E8C61),
    titleTextStyle: TextStyle(color: Colors.white),
    iconTheme: IconThemeData(color: Colors.white),
  ),
  iconTheme: const IconThemeData(
    color: Colors.black,
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
  color: const Color(0xFF5E8C61),
  elevation: 2,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(4.0),
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

// The color 656839 with 50% opacity for the background
const Color semiTransparentBackground = Color(0x80656839);

// The color 656839 with 50% opacity for the text
const Color semiTransparentText = Color(0x80656839);
