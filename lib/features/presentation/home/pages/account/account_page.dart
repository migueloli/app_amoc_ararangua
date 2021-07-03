import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../core/theme/theme.dart';

class AccountPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(height: 20,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SwitchListTile(
            value: Theme.of(context).brightness == Brightness.dark,
            title: Text('Modo noturno'),
            onChanged: (value) => value
                ? DynamicTheme.of(context)?.setTheme(AppThemes.DARK_THEME)
                : DynamicTheme.of(context)?.setTheme(AppThemes.LIGHT_THEME),
          ),
        ),
        Divider(),
        Padding(
          padding: const EdgeInsets.all(8),
          child: MaterialButton(
            child: Text('Cadastrar'),
            onPressed: () => Modular.to.pushNamed("/create-account"),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            "Desenvolvido por Share Exp.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Theme.of(context).accentColor,
              fontSize: 10,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
      ],
    );
  }

}