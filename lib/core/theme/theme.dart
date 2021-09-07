import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';

class AppThemes {
  static const int lightTheme = 0;
  static const int darkTheme = 1;
}

const MaterialColor amocMainBlue = MaterialColor(0xFF283593, {
  050: Color.fromRGBO(40, 53, 200, .1),
  100: Color.fromRGBO(40, 53, 200, .2),
  200: Color.fromRGBO(40, 53, 200, .3),
  300: Color.fromRGBO(40, 53, 200, .4),
  400: Color.fromRGBO(40, 53, 200, .5),
  500: Color.fromRGBO(40, 53, 200, .6),
  600: Color.fromRGBO(40, 53, 200, .7),
  700: Color.fromRGBO(40, 53, 200, .8),
  800: Color.fromRGBO(40, 53, 200, .9),
  900: Color.fromRGBO(40, 53, 200, 1),
});

const MaterialColor amocMainYellow = MaterialColor(0xFF283593, {
  050: Color.fromRGBO(255, 223, 0, .1),
  100: Color.fromRGBO(255, 223, 0, .2),
  200: Color.fromRGBO(255, 223, 0, .3),
  300: Color.fromRGBO(255, 223, 0, .4),
  400: Color.fromRGBO(255, 223, 0, .5),
  500: Color.fromRGBO(255, 223, 0, .6),
  600: Color.fromRGBO(255, 223, 0, .7),
  700: Color.fromRGBO(255, 223, 0, .8),
  800: Color.fromRGBO(255, 223, 0, .9),
  900: Color.fromRGBO(255, 223, 0, 1),
});

final themes = {
  AppThemes.lightTheme: ThemeData(
    primarySwatch: amocMainBlue,
    brightness: Brightness.light,
    primaryColor: amocMainBlue[900],
    primaryColorDark: amocMainBlue[900],
    primaryColorLight: amocMainBlue[900],
    accentColor: amocMainBlue[900],
    dividerColor: amocMainBlue[900],
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: amocMainBlue[900],
      selectionColor: amocMainBlue[900],
      selectionHandleColor: amocMainBlue[900],
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: amocMainBlue[900],
      centerTitle: true,
      elevation: 0,
      titleSpacing: 1.5,
      textTheme: const TextTheme(
        headline6: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  ),
  AppThemes.darkTheme: ThemeData(
    primarySwatch: amocMainYellow,
    brightness: Brightness.dark,
    primaryColor: amocMainYellow[900],
    primaryColorDark: amocMainYellow[900],
    primaryColorLight: amocMainYellow[900],
    accentColor: amocMainYellow[900],
    dividerColor: amocMainYellow[900],
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: amocMainYellow[900],
      selectionColor: amocMainYellow[900],
      selectionHandleColor: amocMainYellow[900],
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: amocMainBlue[900],
      centerTitle: true,
      elevation: 0,
      titleSpacing: 1.5,
      textTheme: const TextTheme(
        headline6: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  ),
};

final themeCollection = ThemeCollection(
  themes: themes,
  fallbackTheme: themes[AppThemes.darkTheme],
);