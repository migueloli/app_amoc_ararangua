import 'package:flutter_triple/flutter_triple.dart';

import '../../../../../../core/errors/failures.dart';
import '../../../../../../core/usecases/usecase.dart';
import '../../../../../domain/entities/account_entity.dart';
import '../../../../../domain/usecases/get_accounts_usecase.dart';

class ServicesStore extends NotifierStore<Failure, List<AccountEntity>> {

  final GetAccountsUseCase getAccountUseCase;

  ServicesStore(this.getAccountUseCase) : super([]);

  searchServiceAccounts() async {
    setLoading(true);

    final response = await getAccountUseCase(NoParams());
    response.fold(
      setError,
      update,
    );

    setLoading(false);
  }
}