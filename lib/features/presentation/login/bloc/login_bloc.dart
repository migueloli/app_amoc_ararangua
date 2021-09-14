import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/states/bloc_state.dart';
import '../../../domain/usecases/login_with_email_and_password_use_case.dart';
import '../../../domain/usecases/login_with_google_use_case.dart';
import 'events/login_bloc_event.dart';

class LoginBloc extends Bloc<LoginBlocEvent, BlocState> {
  final LoginWithEmailAndPasswordUseCase loginWithEmailAndPasswordUseCase;
  final LoginWithGoogleUseCase loginWithGoogleUseCase;

  LoginBloc(this.loginWithEmailAndPasswordUseCase, this.loginWithGoogleUseCase) : super(BlocState.empty());

  String email = '';
  String password = '';

  @override
  Stream<BlocState> mapEventToState(LoginBlocEvent event) async* {
    yield BlocState.loading();
    if(event is LoginWithEmailAndPasswordBlocEvent) {
      yield await _loginWithEmailAndPassword(email, password);
    } else if(event is LoginWithGoogleBlocEvent) {
      yield await _loginWithGoogle();
    }
  }

  Future<BlocState> _loginWithEmailAndPassword(String email, String password) async {
    final result = await loginWithEmailAndPasswordUseCase(email, password);
    return result.fold(
      (error) => BlocState.error(_processFailure(error)),
      (entity) => BlocState.success(entity),
    );
  }

  Future<BlocState> _loginWithGoogle() async {
    final result = await loginWithGoogleUseCase();
    return result.fold(
      (error) => BlocState.error(_processFailure(error)),
      (entity) => BlocState.success(entity),
    );
  }

  void onSaveEmail(String? value) => email = value ?? '';

  void onSavePassword(String? value) => password = value ?? '';

  String _processFailure(Failure e) {
    var message = 'Ocorreu um erro ao fazer login, tente novamente.';

    switch(e.runtimeType) {
      case EmailAlreadyInUseFailure:
        message = 'Este e-mail já está cadastrado.';
        break;
      case WeakPasswordFailure:
        message = 'Está senha digitada é muito fraca.';
        break;
      case InvalidEmailFailure:
        message = 'Este e-mail é inválido.';
        break;
      case OperationNotAllowedFailure:
        message = 'Operação não permitida.';
        break;
      case UserDisabledFailure:
        message = 'Usuário desabilitado.';
        break;
      case UserNotFoundFailure:
        message = 'Não foi encontrado nenhum usuário com esses dados.';
        break;
      case WrongPasswordFailure:
        message = 'Senha incorreta.';
        break;
      case AccountExistsWithDifferentCredentialFailure:
        message = 'Conta cadastrada com outro modo de login.';
        break;
    }

    return message;
  }
}
