import 'package:app_amoc_ararangua/core/errors/failures.dart';
import 'package:app_amoc_ararangua/features/domain/entities/account_entity.dart';
import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

import '../../../../../core/theme/theme.dart';
import 'store/account_store.dart';

class AccountPage extends StatefulWidget {

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends ModularState<AccountPage, AccountStore> {

  @override
  void initState() {
    controller.getLoggedUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedBuilder(
      store: controller,
      onState: _onState,
      onLoading: _onLoading,
      onError: _onError,
    );
  }

  Widget _onState(BuildContext context, AccountEntity entity) => ListView(
    children: _createMenu(context, entity),
  );

  Widget _onLoading(BuildContext context) => Center(
    child: CircularProgressIndicator()
  );

  Widget _onError(BuildContext context, Failure? failure) => ListView(
    children: _createMenu(context, null),
  );

  List<Widget> _createMenu(BuildContext context, AccountEntity? entity) {
    final textStyle = TextStyle(
      color: Theme.of(context).accentColor,
      fontSize: 10,
      fontStyle: FontStyle.italic,
      fontWeight: FontWeight.bold,
    );
    var widgets = <Widget>[];

    widgets.addAll([
      SizedBox(height: 20,),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SwitchListTile(
          value: Theme.of(context).brightness == Brightness.dark,
          title: Text(
            'Modo noturno',
            style: textStyle,
          ),
          onChanged: (value) => value
              ? DynamicTheme.of(context)?.setTheme(AppThemes.DARK_THEME)
              : DynamicTheme.of(context)?.setTheme(AppThemes.LIGHT_THEME),
        ),
      ),
    ]);

    if(entity == null) {
      widgets.addAll(_disconnectedItems(textStyle));
    } else {
      widgets.addAll(_connectedItems(textStyle));
    }

    widgets.add(
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Text(
          "Desenvolvido por Share Exp.",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Theme.of(context).accentColor,
            fontSize: 10,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

    return widgets;
  }

  List<Widget> _disconnectedItems(TextStyle textStyle) => [
    Divider(),
    Padding(
      padding: const EdgeInsets.all(8),
      child: MaterialButton(
        child: Text(
          'Login',
          style: textStyle,
        ),
        onPressed: () {},
      ),
    ),
  ];

  List<Widget> _connectedItems(TextStyle textStyle) => [
    Divider(),
    Padding(
      padding: const EdgeInsets.all(8),
      child: MaterialButton(
        child: Text(
          'Perfil',
          style: textStyle,
        ),
        onPressed: () {},
      ),
    ),
    Divider(),
    Padding(
      padding: const EdgeInsets.all(8),
      child: MaterialButton(
        child: Text(
          'Sair',
          style: textStyle,
        ),
        onPressed: () {},
      ),
    )
  ];
}