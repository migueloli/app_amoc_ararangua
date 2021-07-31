import 'package:app_amoc_ararangua/core/errors/failures.dart';
import 'package:app_amoc_ararangua/core/usecases/usecase.dart';
import 'package:app_amoc_ararangua/features/domain/entities/account_entity.dart';
import 'package:app_amoc_ararangua/features/domain/usecases/get_accounts_usecase.dart';
import 'package:flutter_triple/flutter_triple.dart';

class AccountSearchStore extends NotifierStore<Failure, List<AccountEntity>> {

  final GetAccountsUseCase getAccountUseCase;

  AccountSearchStore({required this.getAccountUseCase}) : super([]);

  searchServiceAccounts() async {
    setLoading(true);
    var response = await getAccountUseCase(NoParams());
    response.fold(
      (failure) => setError(failure),
      (success) => update(success),
    );
  }
}