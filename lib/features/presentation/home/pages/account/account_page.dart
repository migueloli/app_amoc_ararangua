import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../core/states/bloc_state.dart';
import '../../../../../core/theme/theme.dart';
import '../../../../domain/entities/account_entity.dart';
import '../../../widgets/menu_button_widget.dart';
import 'bloc/account_bloc.dart';
import 'bloc/events/account_bloc_events.dart';

class AccountPage extends StatefulWidget {

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends ModularState<AccountPage, AccountBloc> {

  @override
  void initState() {
    store.add(const GetLoggedUserBlocEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: bloc,
      builder: (context, state) {
        if(state is SuccessBlocState) return _onState(context, state.value as AccountEntity);
        if(state is ErrorBlocState) return _onError(context);
        return _onLoading(context);
      },
    );
  }

  Widget _onState(BuildContext context, AccountEntity entity) => ListView(
    children: _createMenu(context, entity),
  );

  Widget _onLoading(BuildContext context) => const Center(
    child: CircularProgressIndicator(),
  );

  Widget _onError(BuildContext context) => ListView(
    children: _createMenu(context, null),
  );

  List<Widget> _createMenu(BuildContext context, AccountEntity? entity) {
    final textStyle = TextStyle(
      color: Theme.of(context).colorScheme.secondary,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    );
    final widgets = <Widget>[];

    widgets.addAll([
      const SizedBox(height: 20,),
      SwitchListTile(
        activeColor: Theme.of(context).colorScheme.secondary,
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
            color: Theme.of(context).colorScheme.secondary,
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
      onPressed: () => Modular.to.pushNamed('/login/'),
    ),
  ];

  List<Widget> _connectedItems(TextStyle textStyle) => [
    const Divider(),
    MenuButtonWidget(
      label: 'Perfil',
      icon: Icons.person,
      onPressed: () => Modular.to.pushNamed('/profile/'),
    ),
    const Divider(),
    MenuButtonWidget(
      label: 'Sair',
      icon: Icons.logout,
      onPressed: () {},
    ),
  ];
}
