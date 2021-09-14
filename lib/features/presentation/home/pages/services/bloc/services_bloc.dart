import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/errors/failures.dart';
import '../../../../../../core/states/bloc_state.dart';
import '../../../../../domain/usecases/get_accounts_use_case.dart';
import 'events/services_bloc_event.dart';

class ServicesBloc extends Bloc<ServicesBlocEvent, BlocState> {

  final GetAccountsUseCase getAccountUseCase;

  ServicesBloc(this.getAccountUseCase) : super(BlocState.empty());

  @override
  Stream<BlocState> mapEventToState(ServicesBlocEvent event) async* {
    if(event is SearchServicesBlocEvent) {
      yield BlocState.loading();

      final response = await getAccountUseCase();
      yield response.fold(
        (failure) => BlocState.error(_processFailure(failure)),
        (list) => BlocState.success(list),
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