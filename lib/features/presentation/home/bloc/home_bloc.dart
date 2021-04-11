import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/states/bloc_state.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../domain/usecases/get_accounts_usecase.dart';

part 'home_event.dart';

const SERVER_FAILURE_MESSAGE = 'Ocorreu um erro na comunicação com o servidor, tente novamente.';
const NETWORK_FAILURE_MESSAGE = 'Não foi possível conectar a internet, verifique as conexões do aparelho.';
const GENERIC_FAILURE_MESSAGE = 'Ocorreu um erro, tente novamente.';

class HomeBloc extends Bloc<HomeEvent, BlocState> {

  final GetAccountsUseCase getAccountUseCase;

  HomeBloc({required this.getAccountUseCase}): super(BlocState.empty());

  @override
  Stream<BlocState> mapEventToState(
    HomeEvent event,
  ) async* {
    if(event is GetAccountsEvent){
      yield LoadingBlocState();
      final failureOrSuccess = await getAccountUseCase(NoParams());
      yield failureOrSuccess.fold(
        (failure) => ErrorBlocState(message: _mapFailureToMessage(failure)),
        (success) => SuccessBlocState(value: success),
      );
    }
  }

  String _mapFailureToMessage(Failure failure) {
    switch(failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case NetworkFailure:
        return NETWORK_FAILURE_MESSAGE;
      default:
        return GENERIC_FAILURE_MESSAGE;
    }
  }
}
