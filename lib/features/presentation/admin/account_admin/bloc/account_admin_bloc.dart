import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures.dart';
import '../../../../../core/states/bloc_state.dart';
import '../../../../domain/repositories/account_repository.dart';
import 'event/account_admin_bloc_event.dart';

class AccountAdminBloc extends Bloc<AccountAdminBlocEvent, BlocState> {
  final IAccountsRepository accountsRepository;

  AccountAdminBloc(this.accountsRepository) : super(BlocState.empty());

  @override
  Stream<BlocState> mapEventToState(AccountAdminBlocEvent event) async* {
    if(event is SaveAccountAdminBlocEvent) {
      yield BlocState.loading();
      final account = event.account;
      account.copyWith(status: event.status);
      final result = await accountsRepository.saveAccount(account);
      yield result.fold(
        (failure) => BlocState.error(_prepareGetFailure(failure)),
        (entity) => BlocState.success(entity),
      );
    }
  }

  String _prepareGetFailure(Failure failure) {
    switch(failure.runtimeType) {
      case NetworkFailure:
        return networkFailureMessage;
      case ServerFailure:
        return serverFailureMessage;
    }

    return genericFailureMessage;
  }

  static const networkFailureMessage = 'Não foi possível conectar a internet, verifique as conexões do aparelho.';
  static const serverFailureMessage = 'Ocorreu um erro ao salvar os dados do perfil.';
  static const genericFailureMessage = 'Ocorreu um erro, tente novamente.';
}
