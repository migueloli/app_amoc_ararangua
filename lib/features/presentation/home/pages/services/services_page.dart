import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../core/states/bloc_state.dart';
import '../../../../domain/entities/account_entity.dart';
import '../../../widgets/error_message_widget.dart';
import 'bloc/events/services_bloc_event.dart';
import 'bloc/services_bloc.dart';

class ServicesPage extends StatefulWidget {
  @override
  _ServicesPageState createState() => _ServicesPageState();
}

class _ServicesPageState extends ModularState<ServicesPage, ServicesBloc> {
  @override
  void initState() {
    store.add(const SearchServicesBlocEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: bloc,
      builder: (context, state) {
        if(state is SuccessBlocState) return _onState(context, state.value as List<AccountEntity>);
        if(state is ErrorBlocState) return _onError(context, state.message);
        return _onLoading(context);
      }
    );
  }

  Widget _onState(BuildContext context, List<AccountEntity> state) => ListView.separated(
    itemCount: state.length,
    itemBuilder: (_, index) => ListTile(
      leading: Icon(
        Icons.business,
        color: Theme.of(context).colorScheme.secondary
      ),
      title: Text(state[index].name),
      subtitle: Text(state[index].phone),
    ),
    separatorBuilder: (_, index) => const Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Divider(),
    ),
  );

  Widget _onLoading(BuildContext context) => const Center(
    child: CircularProgressIndicator()
  );

  Widget _onError(BuildContext context, String? error) => ErrorMessageWidget(
    errorMessage: error ?? 'Ocorreu um erro, tente novamente.',
  );
}