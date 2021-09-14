import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/states/bloc_state.dart';
import '../../../../../domain/usecases/get_logged_user_use_case.dart';
import 'events/account_bloc_events.dart';

class AccountBloc extends Bloc<AccountBlocEvents, BlocState> {

  final GetLoggedUserUseCase getLoggedUserUseCase;

  AccountBloc(this.getLoggedUserUseCase) : super(BlocState.empty());

  @override
  Stream<BlocState> mapEventToState(AccountBlocEvents event) async* {
    if(event is GetLoggedUserBlocEvent) {
      yield BlocState.loading();

      final result = await getLoggedUserUseCase();
      yield result.fold(
        (message) => BlocState.error(''),
        (entity) => BlocState.success(entity),
      );
    }
  }
}