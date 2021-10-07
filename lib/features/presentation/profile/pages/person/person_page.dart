import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:kayta/formatters.dart';

import '../../../../../core/states/bloc_state.dart';
import '../../../../../core/validators/validators.dart';
import '../../../widgets/error_message_widget.dart';
import '../../../widgets/text_field_widget.dart';
import '../../bloc/profile_bloc.dart';

class PersonPage extends StatefulWidget {
  const PersonPage({ Key? key }) : super(key: key);

  @override
  _PersonPageState createState() => _PersonPageState();
}

class _PersonPageState extends State<PersonPage> {
  late final ProfileBloc _bloc;

  @override
  void initState() {
    _bloc = Modular.get<ProfileBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _bloc,
      builder: (context, state) {
        if(state is ErrorBlocState) return ErrorMessageWidget(errorMessage: state.message);

        if(state is SuccessBlocState) {
          return Form(
            child: ListView(
              children: [
                TextFieldWidget(
                  label: "Nome",
                  icon: Icons.person,
                  inputType: TextInputType.name,
                  validator: validateName,
                  onChanged: _bloc.saveProfileBloc.saveName,
                  capitalization: TextCapitalization.words,
                  textInputAction: TextInputAction.next,
                  value: _bloc.saveProfileBloc.presenter.name,
                ),
                TextFieldWidget(
                  label: "CPF",
                  icon: Icons.payment,
                  inputType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    CpfOuCnpjFormatter(),
                  ],
                  validator: validateDocument,
                  onChanged: _bloc.saveProfileBloc.saveDocument,
                  textInputAction: TextInputAction.next,
                  value: _bloc.saveProfileBloc.presenter.document,
                ),
                TextFieldWidget(
                  label: "Telefone",
                  icon: Icons.phone_android,
                  inputType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    TelefoneInputFormatter()
                  ],
                  validator: validatePhone,
                  onChanged: _bloc.saveProfileBloc.savePhone,
                  textInputAction: TextInputAction.next,
                  value: _bloc.saveProfileBloc.presenter.phone,
                ),
                TextFieldWidget(
                  label: "CEP",
                  icon: Icons.pin_drop,
                  inputType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    CepInputFormatter(),
                  ],
                  validator: validateZip,
                  onChanged: _bloc.saveProfileBloc.saveZip,
                  value: _bloc.saveProfileBloc.presenter.zip,
                ),
                TextFieldWidget(
                  label: "Endereço",
                  icon: Icons.place,
                  validator: validateAddress,
                  onChanged: _bloc.saveProfileBloc.saveAddress,
                  capitalization: TextCapitalization.words,
                  textInputAction: TextInputAction.next,
                  value: _bloc.saveProfileBloc.presenter.address,
                ),
                TextFieldWidget(
                  label: "Número",
                  icon: Icons.exposure_zero,
                  onChanged: _bloc.saveProfileBloc.saveNumber,
                  textInputAction: TextInputAction.next,
                  value: _bloc.saveProfileBloc.presenter.number,
                ),
                TextFieldWidget(
                  label: "Bairro",
                  icon: Icons.place,
                  validator: validateNeighborhood,
                  onChanged: _bloc.saveProfileBloc.saveNeighborhood,
                  capitalization: TextCapitalization.words,
                  textInputAction: TextInputAction.next,
                  value: _bloc.saveProfileBloc.presenter.neighborhood,
                ),
                TextFieldWidget(
                  label: "Cidade",
                  icon: Icons.map,
                  validator: validateCity,
                  onChanged: _bloc.saveProfileBloc.saveCity,
                  capitalization: TextCapitalization.characters,
                  value: _bloc.saveProfileBloc.presenter.city,
                ),
                TextFieldWidget(
                  label: 'Estado',
                  icon: Icons.map,
                  capitalization: TextCapitalization.characters,
                  onChanged: _bloc.saveProfileBloc.saveState,
                  value: _bloc.saveProfileBloc.presenter.state,
                ),
              ],
            )
          );
        }

        return const Center(child: CircularProgressIndicator(),);
      }
    );
  }
}