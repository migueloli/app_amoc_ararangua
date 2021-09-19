import 'package:app_amoc_ararangua/core/errors/failures.dart';
import 'package:app_amoc_ararangua/features/domain/entities/account_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/states/bloc_state.dart';
import '../../../domain/repositories/account_repository.dart';
import 'events/profile_event_bloc.dart';

class ProfileBloc extends Bloc<ProfileEventBloc, BlocState> {
  final IAccountsRepository accountRepository;

  ProfileBloc(this.accountRepository) : super(BlocState.empty());

  @override
  Stream<BlocState> mapEventToState(ProfileEventBloc event) async* {
    if(event is GetProfileEventBloc) {
      yield BlocState.loading();
      final result = await accountRepository.getLoggedUser();
      yield result.fold(
        (failure) => BlocState.error(_prepareGetFailure(failure)),
        (entity) {
          return BlocState.success(entity);
        },
      );
    } else if(event is SaveProfileEventBloc) {
      yield BlocState.loading();
      final result = await accountRepository.saveAccount(AccountEntity.empty());
      yield result.fold(
        (failure) => BlocState.error(_prepareGetFailure(failure)),
        (entity) => BlocState.success(entity),
      );
    }
  }

  String _prepareGetFailure(Failure failure) {
    switch(failure.runtimeType) {
      case UserNotFoundFailure:
        return 'Ocorreu um erro ao buscar o usuário conectado.';
      case UserNotSavedFailure:
        return 'Ocorreu um erro ao salvar os dados do perfil.';
      case NetworkFailure:
        return networkFailureMessage;
      case ServerFailure:
        return serverFailureMessage;
    }

    return genericFailureMessage;
  }

  static const userNotFoundMessage = 'Ocorreu um erro ao buscar o usuário conectado.';
  static const userNotSavedFailure = 'Ocorreu um erro ao salvar os dados do perfil.';
  static const networkFailureMessage = 'Não foi possível conectar a internet, verifique as conexões do aparelho.';
  static const serverFailureMessage = 'Ocorreu um erro na comunicação com o servidor, tente novamente.';
  static const genericFailureMessage = 'Ocorreu um erro, tente novamente.';
}