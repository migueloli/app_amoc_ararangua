import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../core/states/bloc_state.dart';
import '../../../../domain/entities/account_entity.dart';
import '../../../widgets/error_message_widget.dart';
import 'bloc/account_search_bloc.dart';

class ServicesPage extends StatefulWidget {
  @override
  _ServicesPageState createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  final AccountsSearchBloc _accountsSearchBloc = Modular.get();

  @override
  void initState() {
    _accountsSearchBloc.add(GetAccountsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountsSearchBloc, BlocState>(
      bloc: _accountsSearchBloc,
      builder: _buildServicesPage,
    );
  }

  Widget _buildServicesPage(context, state) {
    if(state is SuccessBlocState){
      final list = state.value as List<AccountEntity>;

      return ListView.separated(
        itemCount: list.length,
        itemBuilder: (_, index) => ListTile(
          leading: Icon(
            Icons.business,
            color: Theme.of(context).accentColor
          ),
          title: Text(list[index].name),
          subtitle: Text(list[index].phone),
        ),
        separatorBuilder: (_, index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Divider(),
        ),
      );
    }

    switch (state.runtimeType) {
      case LoadingBlocState:
        return Center(
          child: CircularProgressIndicator()
        );
      case EmptyBlocState:
        return ErrorMessageWidget(
          errorMessage: 'Lista vazia'
        );
      case ErrorBlocState:
        return ErrorMessageWidget(
          errorMessage: (state as ErrorBlocState).message,
        );
      default:
        return ErrorMessageWidget(
          errorMessage: 'Ocorreu um erro, tente novamente.',
        );
    }
  }
}