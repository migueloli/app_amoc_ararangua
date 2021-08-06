import 'package:flutter_triple/flutter_triple.dart';

import '../../../../../../core/errors/failures.dart';
import '../../../../../../core/usecases/usecase.dart';
import '../../../../../domain/entities/account_entity.dart';
import '../../../../../domain/usecases/get_accounts_usecase.dart';

class ServicesStore extends NotifierStore<String, List<AccountEntity>> {

  final GetAccountsUseCase getAccountUseCase;

  ServicesStore(this.getAccountUseCase) : super([]);

  searchServiceAccounts() async {
    setLoading(true);

    final response = await getAccountUseCase(NoParams());
    response.fold(
      (failure) {
        switch(failure.runtimeType) {
          case NetworkFailure:
            setError('Não foi possível conectar a internet, verifique as conexões do aparelho.');
            break;
          case ServerFailure:
            setError('Ocorreu um erro na comunicação com o servidor, tente novamente.');
            break;
          default:
            setError('Ocorreu um erro, tente novamente.');
            break;
        }
      },
      update,
    );

    setLoading(false);
  }
}