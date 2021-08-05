import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

import '../../../../../core/errors/failures.dart';
import '../../../../domain/entities/account_entity.dart';
import '../../../widgets/error_message_widget.dart';
import 'store/services_store.dart';

class ServicesPage extends StatefulWidget {
  @override
  _ServicesPageState createState() => _ServicesPageState();
}

class _ServicesPageState extends ModularState<ServicesPage, ServicesStore> {
  @override
  void initState() {
    controller.searchServiceAccounts();
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

  Widget _onState(BuildContext context, List<AccountEntity> state) => ListView.separated(
    itemCount: state.length,
    itemBuilder: (_, index) => ListTile(
      leading: Icon(
        Icons.business,
        color: Theme.of(context).accentColor
      ),
      title: Text(state[index].name),
      subtitle: Text(state[index].phone),
    ),
    separatorBuilder: (_, index) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Divider(),
    ),
  );

  Widget _onLoading(BuildContext context) => Center(
    child: CircularProgressIndicator()
  );

  Widget _onError(BuildContext context, Failure? error) {
    switch(error.runtimeType) {
      case NetworkFailure:
        return ErrorMessageWidget(
          errorMessage: 'Não foi possível conectar a internet, verifique as conexões do aparelho.',
        );
      case ServerFailure:
        return ErrorMessageWidget(
          errorMessage: 'Ocorreu um erro na comunicação com o servidor, tente novamente.',
        );
      default:
        return ErrorMessageWidget(
          errorMessage: 'Ocorreu um erro, tente novamente.',
        );
    }
  }
}