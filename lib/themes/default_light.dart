import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  primaryColor: const Color(0xFF5E8C61),
  hintColor: const Color(0xFF611599),
  textTheme: const TextTheme(
    headline1: TextStyle(color: Colors.black),
    bodyText1: TextStyle(color: Colors.black),
  ),
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF5E8C61),
    titleTextStyle: TextStyle(color: Colors.white),
    iconTheme: IconThemeData(color: Colors.white),
  ),
  cardTheme: const CardTheme(
    color: Colors.white, // Default card background
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
