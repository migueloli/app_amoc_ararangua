import 'package:app_amoc_ararangua/features/domain/repositories/account_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/states/bloc_state.dart';
import 'events/login_bloc_event.dart';

class LoginBloc extends Bloc<LoginBlocEvent, BlocState> {
  final IAccountsRepository accountRepository;

  LoginBloc(this.accountRepository) : super(BlocState.empty());

  String email = '';
  String password = '';

  void onSaveEmail(String? value) => email = value ?? '';

  void onSavePassword(String? value) => password = value ?? '';

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
    final result = await accountRepository.loginWithEmailAndPassword(email, password);
    return result.fold(
      (error) => BlocState.error(_processFailure(error)),
      (entity) => BlocState.success(entity),
    );
  }

  Future<BlocState> _loginWithGoogle() async {
    final result = await accountRepository.loginWithGoogle();
    return result.fold(
      (error) => BlocState.error(_processFailure(error)),
      (entity) => BlocState.success(entity),
    );
  }

  String _processFailure(Failure e) {
    switch(e.runtimeType) {
      case EmailAlreadyInUseFailure:
        return emailAlreadyInUseMessage;
      case WeakPasswordFailure:
        return weakPasswordMessage;
      case InvalidEmailFailure:
        return invalidEmailMessage;
      case OperationNotAllowedFailure:
        return operationNotAllowedMessage;
      case UserDisabledFailure:
        return userDisabledMessage;
      case UserNotFoundFailure:
        return userNotFoundMessage;
      case WrongPasswordFailure:
        return wrongPasswordMessage;
      case AccountExistsWithDifferentCredentialFailure:
        return accountExistsWithDifferentCredentialMessage;
      case InvalidCredentialFailure:
        return invalidCredentialMessage;
      case NetworkFailure:
        return networkFailureMessage;
      case ServerFailure:
        return serverFailureMessage;
    }

    return genericFailureMessage;
  }

  static const emailAlreadyInUseMessage = 'J?? existe uma conta com esse e-mail.';
  static const weakPasswordMessage = 'Senha digitada ?? muito fraca.';
  static const invalidEmailMessage = 'E-mail inv??lido.';
  static const operationNotAllowedMessage = 'Opera????o n??o permitida.';
  static const userDisabledMessage = 'Usu??rio desabilitado.';
  static const userNotFoundMessage = 'N??o foi encontrado nenhum usu??rio com esses dados.';
  static const wrongPasswordMessage = 'Senha incorreta.';
  static const accountExistsWithDifferentCredentialMessage = 'Conta cadastrada com outro modo de login.';
  static const invalidCredentialMessage = 'Conta inv??lida.';
  static const networkFailureMessage = 'N??o foi poss??vel conectar a internet, verifique as conex??es do aparelho.';
  static const serverFailureMessage = 'Ocorreu um erro na comunica????o com o servidor, tente novamente.';
  static const genericFailureMessage = 'Ocorreu um erro ao fazer login, tente novamente.';
}
