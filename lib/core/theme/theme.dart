import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';

class AppThemes {
  static const int LIGHT_THEME = 0;
  static const int DARK_THEME = 1;
}

const MaterialColor amocMain = MaterialColor(0xFF283593, {
  50: Color.fromRGBO(40, 53, 200, .1),
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

const Color amocBlue = Color.fromRGBO(40, 53, 200, 1);

const Color amocYellow = Color.fromRGBO(255, 223, 0, 1);

final themes = {
  AppThemes.LIGHT_THEME: ThemeData(
    primarySwatch: amocMain,
    brightness: Brightness.light,
    primaryColor: amocBlue,
    primaryColorDark: amocBlue,
    primaryColorLight: amocBlue,
    accentColor: amocBlue,
    dividerColor: amocBlue,
  ),
  AppThemes.DARK_THEME: ThemeData(
    primarySwatch: amocMain,
    brightness: Brightness.dark,
    primaryColor: amocBlue,
    primaryColorDark: amocBlue,
    primaryColorLight: amocBlue,
    accentColor: amocYellow,
    dividerColor: amocYellow,
  ),
};

final themeCollection = ThemeCollection(
  themes: themes,
  fallbackTheme: themes[AppThemes.LIGHT_THEME],
);