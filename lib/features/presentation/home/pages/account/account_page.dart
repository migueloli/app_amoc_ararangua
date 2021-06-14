import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

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
            onChanged: (value) {
              EasyDynamicTheme.of(context).changeTheme(dark: value);
            },
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