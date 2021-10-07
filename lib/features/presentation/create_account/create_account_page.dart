import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/states/bloc_state.dart';
import '../../../core/validators/validators.dart';
import '../widgets/rectangular_button.dart';
import '../widgets/text_field_widget.dart';
import 'bloc/create_account_bloc.dart';
import 'bloc/event/create_account_bloc_event.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({ Key? key }) : super(key: key);

  @override
  _CreateAccountPageState createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends ModularState<CreateAccountPage, CreateAccountBloc> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(300),
        child: Container(
          height: 300,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.elliptical(100, 80),
            ),
            color: Theme.of(context).appBarTheme.backgroundColor,
          ),
          child: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 40,
                ),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: Modular.to.pop,
                ),
              ),
              Center(
                child: Image.asset('assets/images/logo.png'),
              ),
            ]
          ),
        ),
      ),
      body: BlocConsumer(
        bloc: bloc,
        listenWhen: (previousState, state) => state is ErrorBlocState || state is SuccessBlocState,
        listener: (context, state) {
          if(state is ErrorBlocState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          } else {
            Modular.to.pop();
          }
        },
        buildWhen: (previousState, state) => state !is SuccessBlocState,
        builder: (context, state) {
          if(state is LoadingBlocState) _onLoading(context);
          return _onState(context);
        },
      ),
    );
  }

  Widget _onLoading(BuildContext context) => const Center(
    child: CircularProgressIndicator()
  );

  Widget _onState(context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                TextFieldWidget(
                  label: 'E-mail',
                  icon: Icons.mail,
                  inputType: TextInputType.emailAddress,
                  validator: validateEmail,
                  onSaved: bloc.onSaveEmail,
                  textInputAction: TextInputAction.next,
                ),
                TextFieldWidget(
                  label: 'Senha',
                  icon: Icons.lock,
                  validator: validatePassword,
                  onSaved: bloc.onSavePassword,
                  obscureText: true,
                  textInputAction: TextInputAction.next,
                ),
                TextFieldWidget(
                  label: 'Senha',
                  icon: Icons.lock,
                  validator: validatePassword,
                  onSaved: bloc.onSavePassword,
                  obscureText: true,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 24),
                RectangularButton(
                  label: 'Cadastrar',
                  icon: const Icon(
                    Icons.login,
                  ),
                  onPressed: () {
                    if(_formKey.currentState?.validate() == true) {
                      _formKey.currentState?.save();
                      bloc.add(const CreateAccountWithEmailAndPasswordEvent());
                    }
                  },
                ),
                const SizedBox(height: 16),
                RectangularButton(
                  label: 'Google',
                  icon: const Icon(
                    EvaIcons.google,
                  ),
                  onPressed: () => bloc.add(const CreateAccountWithGoogleEvent()),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
