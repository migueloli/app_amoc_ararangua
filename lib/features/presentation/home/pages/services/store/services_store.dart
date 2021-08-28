import 'package:mobx_triple/mobx_triple.dart';

import '../../../../../../core/errors/failures.dart';
import '../../../../../domain/entities/account_entity.dart';
import '../../../../../domain/usecases/get_accounts_use_case.dart';

class ServicesStore extends MobXStore<String, List<AccountEntity>> {

  final GetAccountsUseCase getAccountUseCase;

  ServicesStore(this.getAccountUseCase) : super([]);

  Future<void> searchServiceAccounts() async {
    setLoading(true);

    final response = await getAccountUseCase();
    response.fold(
      (failure) {
        switch(failure.runtimeType) {
          case NetworkFailure:
            setError(networkFailureMessage);
            break;
          case ServerFailure:
            setError(serverFailureMessage);
            break;
          default:
            setError(genericFailureMessage);
            break;
        }
      },
      update,
    );

    setLoading(false);
  }

  static const networkFailureMessage = 'Não foi possível conectar a internet, verifique as conexões do aparelho.';
  static const serverFailureMessage = 'Ocorreu um erro na comunicação com o servidor, tente novamente.';
  static const genericFailureMessage = 'Ocorreu um erro, tente novamente.';
}