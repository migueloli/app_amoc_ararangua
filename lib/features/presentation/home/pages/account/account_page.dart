import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

import '../../../../../core/errors/failures.dart';
import '../../../../../core/theme/theme.dart';
import '../../../../domain/entities/account_entity.dart';
import '../../../widgets/menu_button_widget.dart';
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

  Widget _onLoading(BuildContext context) => const Center(
    child: CircularProgressIndicator()
  );

  Widget _onError(BuildContext context, Failure? failure) => ListView(
    children: _createMenu(context, null),
  );

  List<Widget> _createMenu(BuildContext context, AccountEntity? entity) {
    final textStyle = TextStyle(
      color: Theme.of(context).accentColor,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    );
    final widgets = <Widget>[];

    widgets.addAll([
      const SizedBox(height: 20,),
      SwitchListTile(
        activeColor: Theme.of(context).accentColor,
        value: Theme.of(context).brightness == Brightness.dark,
        title: Text(
          'Modo noturno',
          style: textStyle,
        ),
        onChanged: (value) => value
            ? DynamicTheme.of(context)?.setTheme(AppThemes.darkTheme)
            : DynamicTheme.of(context)?.setTheme(AppThemes.lightTheme),
      ),
    ]);

    if(entity == null) {
      widgets.addAll(_disconnectedItems(textStyle));
    } else {
      widgets.addAll(_connectedItems(textStyle));
    }

    widgets.addAll([
      const SizedBox(height: 8,),
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
    ]);

    return widgets;
  }

  List<Widget> _disconnectedItems(TextStyle textStyle) => [
    const Divider(),
    MenuButtonWidget(
      label: 'Login',
      icon: Icons.login,
      onPressed: () => Modular.to.pushNamed('/login'),
    ),
  ];

  List<Widget> _connectedItems(TextStyle textStyle) => [
    const Divider(),
    MenuButtonWidget(
      label: 'Perfil',
      icon: Icons.person,
      onPressed: () {},
    ),
    const Divider(),
    MenuButtonWidget(
      label: 'Sair',
      icon: Icons.logout,
      onPressed: () {},
    ),
  ];
}