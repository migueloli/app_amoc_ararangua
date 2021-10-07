import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';

class AppThemes {
  static const int lightTheme = 0;
  static const int darkTheme = 1;
}

const amocBaseBlue = Color.fromRGBO(40, 53, 200, 1);
const amocBaseYellow = Color.fromRGBO(255, 223, 0, 1);

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
    primaryColor: amocBaseBlue,
    primaryColorDark: amocBaseBlue,
    primaryColorLight: amocBaseBlue,
    dividerColor: amocBaseBlue,
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: amocBaseBlue,
      selectionColor: amocBaseBlue,
      selectionHandleColor: amocBaseBlue,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: amocBaseBlue,
      centerTitle: true,
      elevation: 0,
      titleSpacing: 1.5,
      toolbarTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
    colorScheme: const ColorScheme.light(
      primary: amocBaseBlue,
      secondary: amocBaseBlue,
      onPrimary: amocBaseBlue,
      onSecondary: amocBaseBlue,
    ),
  ),
  AppThemes.darkTheme: ThemeData(
    primarySwatch: amocMainYellow,
    brightness: Brightness.dark,
    primaryColor: amocBaseYellow,
    primaryColorDark: amocBaseYellow,
    primaryColorLight: amocBaseYellow,
    dividerColor: amocBaseYellow,
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: amocBaseYellow,
      selectionColor: amocBaseYellow,
      selectionHandleColor: amocBaseYellow,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: amocBaseBlue,
      centerTitle: true,
      elevation: 0,
      titleSpacing: 1.5,
      toolbarTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
    colorScheme: const ColorScheme.dark(
      primary: amocBaseYellow,
      secondary: amocBaseYellow,
      onPrimary: amocBaseYellow,
      onSecondary: amocBaseYellow,
    ),
  ),
};

final themeCollection = ThemeCollection(
  themes: themes,
  fallbackTheme: themes[AppThemes.darkTheme],
);