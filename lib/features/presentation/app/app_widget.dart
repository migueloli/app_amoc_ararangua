import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/theme/theme.dart';

class AppWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
      themeCollection: themeCollection,
      builder: (_, theme) {
        return MaterialApp(
          title: 'AMOC',
          debugShowCheckedModeBanner: false,
          theme: theme,
          initialRoute: Modular.initialRoute,
        ).modular();
      },
    );
  }

}
