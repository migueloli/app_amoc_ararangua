import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/states/bloc_state.dart';
import '../../../domain/repositories/account_repository.dart';
import 'event/create_account_bloc_event.dart';

class CreateAccountBloc extends Bloc<CreateAccountBlocEvent, BlocState> {
  final IAccountsRepository accountRepository;

  CreateAccountBloc(
    this.accountRepository,
  ) : super(BlocState.empty());

  String email = '';
  String password = '';

  void onSaveEmail(String? value) => email = value ?? '';

  void onSavePassword(String? value) => password = value ?? '';

  @override
  Stream<BlocState> mapEventToState(CreateAccountBlocEvent event) async* {
    if(event is CreateAccountWithEmailAndPasswordEvent) {
      yield BlocState.loading();
      final  result = await accountRepository.createAccountWithEmailAndPassword(email, password);
      yield result.fold(
        (failure) => BlocState.error(_prepareFailure(failure)),
        (entity) => BlocState.success(entity),
      );
    } else if(event is CreateAccountWithGoogleEvent) {
      yield BlocState.loading();
      final  result = await accountRepository.loginWithGoogle();
      yield result.fold(
        (failure) => BlocState.error(_prepareFailure(failure)),
        (entity) => BlocState.success(entity),
      );
    }
  }

  String _prepareFailure(Failure e) {
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

  static const emailAlreadyInUseMessage = 'Já existe uma conta com esse e-mail.';
  static const weakPasswordMessage = 'Senha digitada é muito fraca.';
  static const invalidEmailMessage = 'E-mail inválido.';
  static const operationNotAllowedMessage = 'Operação não permitida.';
  static const userDisabledMessage = 'Usuário desabilitado.';
  static const userNotFoundMessage = 'Não foi encontrado nenhum usuário com esses dados.';
  static const wrongPasswordMessage = 'Senha incorreta.';
  static const accountExistsWithDifferentCredentialMessage = 'Conta cadastrada com outro modo de login.';
  static const invalidCredentialMessage = 'Conta inválida.';
  static const networkFailureMessage = 'Não foi possível conectar a internet, verifique as conexões do aparelho.';
  static const serverFailureMessage = 'Ocorreu um erro na comunicação com o servidor, tente novamente.';
  static const genericFailureMessage = 'Ocorreu um erro, tente novamente.';
}
