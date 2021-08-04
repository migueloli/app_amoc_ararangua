import 'package:app_amoc_ararangua/core/errors/failures.dart';
import 'package:app_amoc_ararangua/core/usecases/usecase.dart';
import 'package:app_amoc_ararangua/features/domain/entities/account_entity.dart';
import 'package:app_amoc_ararangua/features/domain/usecases/get_accounts_usecase.dart';
import 'package:flutter_triple/flutter_triple.dart';

class ServicesStore extends NotifierStore<Failure, List<AccountEntity>> {

  final GetAccountsUseCase getAccountUseCase;

  ServicesStore({required this.getAccountUseCase}) : super([]);

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