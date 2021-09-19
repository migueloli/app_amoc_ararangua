import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/states/bloc_state.dart';
import '../../../../../domain/repositories/account_repository.dart';
import 'events/account_bloc_events.dart';

class AccountBloc extends Bloc<AccountBlocEvents, BlocState> {
  final IAccountsRepository accountRepository;

  AccountBloc(this.accountRepository) : super(BlocState.empty());

  @override
  Stream<BlocState> mapEventToState(AccountBlocEvents event) async* {
    if(event is GetLoggedUserBlocEvent) {
      yield BlocState.loading();

      final result = await accountRepository.getLoggedUser();
      yield result.fold(
        (message) => BlocState.error(''),
        (entity) => BlocState.success(entity),
      );
    }
  }
}