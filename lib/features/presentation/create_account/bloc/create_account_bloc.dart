import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/states/bloc_state.dart';
import '../../../domain/usecases/create_account_with_email_and_password_use_case.dart';
import '../../../domain/usecases/create_account_with_google_use_case.dart';
import 'event/create_account_bloc_event.dart';

class CreateAccountBloc extends Bloc<CreateAccountBlocEvent, BlocState> {
  final CreateAccountWithEmailAndPasswordUseCase createAccountWithEmailAndPasswordUseCase;
  final CreateAccountWithGoogleUseCase googleUseCase;

  CreateAccountBloc(
    this.createAccountWithEmailAndPasswordUseCase,
    this.googleUseCase,
  ) : super(BlocState.empty());

  String email = '';
  String password = '';

  void onSaveEmail(String? value) => email = value ?? '';

  void onSavePassword(String? value) => password = value ?? '';

  @override
  Stream<BlocState> mapEventToState(CreateAccountBlocEvent event) async* {
    if(event is CreateAccountWithEmailAndPasswordEvent) {
      yield BlocState.loading();
      final  result = await createAccountWithEmailAndPasswordUseCase(email, password);
      yield result.fold(
        (failure) => BlocState.error(_prepareFailure(failure)),
        (entity) => BlocState.success(entity),
      );
    } else if(event is CreateAccountWithGoogleEvent) {
      yield BlocState.loading();
      final  result = await googleUseCase();
      yield result.fold(
        (failure) => BlocState.error(_prepareFailure(failure)),
        (entity) => BlocState.success(entity),
      );
    }
  }

  String _prepareFailure(Failure e) {
    switch(e.runtimeType) {
      case EmailAlreadyInUseFailure:
        return 'Já existe uma conta com esse e-mail.';
      case WeakPasswordFailure:
        return 'Senha digitada é muito fraca.';
      case InvalidEmailFailure:
        return 'E-mail inválido';
      case OperationNotAllowedFailure:
        return 'Operação não permitida.';
      default:
        return 'Ocorreu um erro, tente novamente.';
    }
  }
}
