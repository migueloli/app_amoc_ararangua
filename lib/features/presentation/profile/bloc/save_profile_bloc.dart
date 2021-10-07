import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/states/bloc_state.dart';
import '../../../domain/repositories/account_repository.dart';
import '../presenter/account_presenter.dart';
import '../presenter/mapper/account_presenter_mapper.dart';
import 'events/profile_event_bloc.dart';

class SaveProfileBloc extends Bloc<ProfileEventBloc, BlocState> {
  final IAccountsRepository accountRepository;
  late final AccountPresenter presenter;

  SaveProfileBloc(this.accountRepository) : super(BlocState.empty());

  void saveName(String? value) => presenter.name = value ?? '';
  void saveDocument(String? value) => presenter.document = value ?? '';
  void saveEmail(String? value) => presenter.email = value ?? '';
  void savePhone(String? value) => presenter.phone = value ?? '';
  void saveZip(String? value) => presenter.zip = value ?? '';
  void saveAddress(String? value) => presenter.address = value ?? '';
  void saveNumber(String? value) => presenter.number = value ?? '';
  void saveNeighborhood(String? value) => presenter.neighborhood = value ?? '';
  void saveCity(String? value) => presenter.city = value ?? '';
  void saveState(String? value) => presenter.state = value ?? '';
  void saveIsWorker({bool? value}) => presenter.isWorker = value ?? false;
  void saveDescription(String? value) => presenter.description = value ?? '';
  void saveCategoryId(String? value) => presenter.categoryId = value ?? '';

  @override
  Stream<BlocState> mapEventToState(ProfileEventBloc event) async* {
    if(event is SaveProfileEventBloc) {
      yield BlocState.loading();
      final result = await accountRepository.saveAccount(presenter.toEntity());
      yield result.fold(
        (failure) => BlocState.error(_prepareGetFailure(failure)),
        (entity) => BlocState.success(entity),
      );
    }
  }

  String _prepareGetFailure(Failure failure) {
    switch(failure.runtimeType) {
      case UserNotSavedFailure:
        return userNotSavedMessage;
      case NetworkFailure:
        return networkFailureMessage;
      case ServerFailure:
        return serverFailureMessage;
    }

    return genericFailureMessage;
  }

  static const userNotSavedMessage = 'Ocorreu um erro ao salvar os dados do perfil.';
  static const networkFailureMessage = 'Não foi possível conectar a internet, verifique as conexões do aparelho.';
  static const serverFailureMessage = 'Ocorreu um erro na comunicação com o servidor, tente novamente.';
  static const genericFailureMessage = 'Ocorreu um erro, tente novamente.';
}