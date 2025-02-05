import 'package:flutter/material.dart';

enum CustomTheme {
  light,
  dark,
}

class CustomThemes {
  static final ThemeData lightTheme = ThemeData(
    // colorSchemeSeed: const Color(0xff537FE7),
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.light,
      seedColor: const Color(0xff537FE7),
      surfaceVariant: const Color(0xffe5eaff),
      // surface: const Color(0xffdde7ff),
    ),

    // textTheme: GoogleFonts.robotoTextTheme(),
    useMaterial3: true,
  );

  static final ThemeData darkTheme = ThemeData(
    // colorSchemeSeed: const Color(0xff537FE7),
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor: const Color(0xff537FE7),
      surface: const Color(0xff232323),
      surfaceVariant: const Color(0xff232323),
      primaryContainer: const Color(0xff6392ff),
      shadow: const Color(0xff6b95ff)
    ),
    shadowColor: const Color(0xff6b95ff),
    // textTheme: GoogleFonts.montserratTextTheme(),
    useMaterial3: true,
  );

  static ThemeData getTheme(CustomTheme theme) {
    switch (theme) {
      case CustomTheme.light:
        return lightTheme;
      case CustomTheme.dark:
        return darkTheme;
      default:
        return lightTheme;
    }
  }
}
