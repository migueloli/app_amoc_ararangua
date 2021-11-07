import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core/states/bloc_state.dart';
import '../../../domain/entities/account_entity.dart';
import '../../widgets/app_bar_widget.dart';
import '../../widgets/dropdown_widget.dart';
import '../../widgets/text_field_widget.dart';
import '../arguments/account_arguments.dart';
import 'bloc/account_admin_bloc.dart';
import 'bloc/event/status_account_admin_bloc_event.dart';
import 'bloc/status_account_admin_bloc.dart';

class AccountAdminPage extends StatefulWidget {
  final AccountArguments args;
  const AccountAdminPage({ Key? key, required this.args }) : super(key: key);

  @override
  _AccountAdminPageState createState() => _AccountAdminPageState();
}

class _AccountAdminPageState extends ModularState<AccountAdminPage, StatusAccountAdminBloc> {
  AccountEntity get entity => widget.args.entity;
  late final AccountAdminBloc _saveBloc;

  @override
  void initState() {
    _saveBloc = Modular.get();
    bloc.add(ChangeStatusAccountAdminBlocEvent(entity.status));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: 'Usuário',
      ),
      body: BlocConsumer(
        bloc: _saveBloc,
        listenWhen: (oldState, state) => state is SuccessBlocState || state is ErrorBlocState,
        listener: (context, state) {
          if(state is SuccessBlocState) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Perfil salvo com sucesso.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Modular.to.pop();
                    },
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
          } else if (state is ErrorBlocState) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Ocorreu um erro.'),
                content: Text(state.message),
                actions: [
                  TextButton(
                    onPressed: () {
                      Modular.to.pop();
                    },
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
          }
        },
        builder: (context, state) {
          if(state is LoadingBlocState) return const Center(child: CircularProgressIndicator(),);

          return _createFieldsBody();
        },
      ),
    );
  }

  Widget _createFieldsBody() => ListView(
    children: [
      TextFieldWidget(
        label: "Nome",
        icon: Icons.person,
        value: entity.name,
        enabled: false,
      ),
      TextFieldWidget(
        label: "CPF",
        icon: Icons.payment,
        value: entity.document,
        enabled: false,
      ),
      TextFieldWidget(
        label: "Telefone",
        icon: Icons.phone_android,
        value: entity.phone,
        enabled: false,
      ),
      TextFieldWidget(
        label: "CEP",
        icon: Icons.pin_drop,
        value: entity.zip,
        enabled: false,
      ),
      TextFieldWidget(
        label: "Endereço",
        icon: Icons.place,
        value: entity.address,
        enabled: false,
      ),
      TextFieldWidget(
        label: "Número",
        icon: Icons.exposure_zero,
        value: entity.number,
        enabled: false,
      ),
      TextFieldWidget(
        label: "Bairro",
        icon: Icons.place,
        value: entity.neighborhood,
        enabled: false,
      ),
      TextFieldWidget(
        label: "Cidade",
        icon: Icons.map,
        value: entity.city,
        enabled: false,
      ),
      TextFieldWidget(
        label: 'Estado',
        icon: Icons.map,
        value: entity.state,
        enabled: false,
      ),
      TextFieldWidget(
        label: "Descrição",
        icon: Icons.description,
        value: entity.description,
        enabled: false,
      ),
      BlocBuilder(
        bloc: bloc,
        builder: (context, state) {
          if(state is SuccessBlocState) {
            return DropdownWidget<int>(
              initialValue: (state.value as AccountEntity).status,
              onChanged: (value) => bloc.add(ChangeStatusAccountAdminBlocEvent(value ?? 0)),
              items: _createStatusItens(),
            );
          }

          return const SizedBox();
        },
      ),
    ],
  );

  List<DropdownMenuItem<int>> _createStatusItens() => [
    DropdownMenuItem<int>(
      value: -1,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.close, color: Theme.of(context).colorScheme.secondary),
          const SizedBox(width: 12,),
          const Text('Recusado'),
        ],
      ),
    ),
    DropdownMenuItem<int>(
      value: 0,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.pending, color: Theme.of(context).colorScheme.secondary),
          const SizedBox(width: 12,),
          const Text('Pendente'),
        ],
      ),
    ),
    DropdownMenuItem<int>(
      value: 1,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check, color: Theme.of(context).colorScheme.secondary),
          const SizedBox(width: 12,),
          const Text('Aceito'),
        ],
      ),
    ),
  ];
}
