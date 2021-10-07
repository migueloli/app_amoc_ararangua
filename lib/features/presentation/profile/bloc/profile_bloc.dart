import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/states/bloc_state.dart';
import '../../../domain/entities/account_entity.dart';
import '../../../domain/repositories/account_repository.dart';
import '../presenter/mapper/account_entity_mapper.dart';
import 'events/profile_event_bloc.dart';
import 'save_profile_bloc.dart';

class ProfileBloc extends Bloc<ProfileEventBloc, BlocState> {
  final IAccountsRepository accountRepository;
  final SaveProfileBloc saveProfileBloc;
  AccountEntity _entity = AccountEntity.empty();

  ProfileBloc(this.accountRepository, this.saveProfileBloc) : super(BlocState.empty());

  @override
  Stream<BlocState> mapEventToState(ProfileEventBloc event) async* {
    if(event is GetProfileEventBloc) {
      yield BlocState.loading();
      if(event.resend) {
        yield BlocState.success(saveProfileBloc.presenter);
      } else {
        final result = await accountRepository.getLoggedUser();
        yield result.fold(
          (failure) => BlocState.error(_prepareGetFailure(failure)),
          (entity) {
            _entity = entity;
            saveProfileBloc.presenter = _entity.toPresenter();
            return BlocState.success(saveProfileBloc.presenter);
          }
        );
      }
    } else if(event is SaveProfileEventBloc) {
      yield BlocState.loading();
      saveProfileBloc.add(event);
    }
  }

  String _prepareGetFailure(Failure failure) {
    switch(failure.runtimeType) {
      case UserNotFoundFailure:
        return userNotFoundMessage;
      case NetworkFailure:
        return networkFailureMessage;
      case ServerFailure:
        return serverFailureMessage;
    }

    return genericFailureMessage;
  }

  static const userNotFoundMessage = 'Ocorreu um erro ao buscar o usuário conectado.';
  static const networkFailureMessage = 'Não foi possível conectar a internet, verifique as conexões do aparelho.';
  static const serverFailureMessage = 'Ocorreu um erro na comunicação com o servidor, tente novamente.';
  static const genericFailureMessage = 'Ocorreu um erro, tente novamente.';
}