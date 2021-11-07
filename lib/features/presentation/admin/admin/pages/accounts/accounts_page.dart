import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../../core/states/bloc_state.dart';
import '../../../../../domain/entities/account_entity.dart';
import '../../../../widgets/error_message_widget.dart';
import '../../../../widgets/worker_list_tile_widget.dart';
import 'bloc/accounts_page_bloc.dart';

class AccountsPage extends StatefulWidget {
  const AccountsPage({ Key? key }) : super(key: key);

  @override
  _AccountsPageState createState() => _AccountsPageState();
}

class _AccountsPageState extends ModularState<AccountsPage, AccountsPageBloc> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: bloc,
      builder: (context, state) {
        if(state is SuccessBlocState) return _onState(context, state.value as List<AccountEntity>);

        if(state is ErrorBlocState) return _onError(context, state.message);

        return _onLoading(context);
      },
    );
  }

  Widget _onLoading(BuildContext context) => const Center(
    child: CircularProgressIndicator(),
  );

  Widget _onError(BuildContext context, String? error) => ErrorMessageWidget(
    errorMessage: error ?? 'Ocorreu um erro, tente novamente.',
  );

  Widget _onState(BuildContext context, List<AccountEntity> list) => ListView.separated(
    itemCount: list.length,
    itemBuilder: (context, index) => WorkerListTileWidget(
      icon: Icon(
        Icons.business,
        color: Theme.of(context).colorScheme.secondary,
        size: 36,
      ),
      name: list[index].name,
      phone: list[index].phone,
      email: list[index].email,
    ),
    separatorBuilder: (_, index) => const Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Divider(),
    ),
  );
}
