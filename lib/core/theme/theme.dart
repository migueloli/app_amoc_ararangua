import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';

class AppThemes {
  static const int LIGHT_THEME = 0;
  static const int DARK_THEME = 1;
}

final themeCollection = ThemeCollection(
  themes: {
    AppThemes.LIGHT_THEME: ThemeData.light(),
    AppThemes.DARK_THEME: ThemeData.dark(),
  },
  fallbackTheme: ThemeData.light(),
);