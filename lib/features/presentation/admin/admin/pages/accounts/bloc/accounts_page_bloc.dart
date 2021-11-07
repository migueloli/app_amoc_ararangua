import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../core/errors/failures.dart';
import '../../../../../../../core/states/bloc_state.dart';
import '../../../../../../domain/repositories/account_repository.dart';
import 'events/accounts_page_bloc_event.dart';

class AccountsPageBloc extends Bloc<AccountsPageBlocEvent, BlocState> {
  final IAccountsRepository accountsRepository;
  AccountsPageBloc(this.accountsRepository) : super(BlocState.empty());

  @override
  Stream<BlocState> mapEventToState(AccountsPageBlocEvent event) async* {
    yield BlocState.loading();
    if(event is GetAccountsBlocEvent) {
      final result = await accountsRepository.getListOfAccounts(isWorker: null, status: null);
      yield result.fold(
        (failure) => BlocState.error(_processFailure(failure)),
        (entity) => BlocState.success(entity),
      );
    }
  }

  String _processFailure(Failure failure) {
    switch(failure.runtimeType) {
      case NetworkFailure:
        return networkFailureMessage;
      case ServerFailure:
        return serverFailureMessage;
    }

    return genericFailureMessage;
  }

  static const networkFailureMessage = 'Não foi possível conectar a internet, verifique as conexões do aparelho.';
  static const serverFailureMessage = 'Ocorreu um erro na comunicação com o servidor, tente novamente.';
  static const genericFailureMessage = 'Ocorreu um erro, tente novamente.';
}
