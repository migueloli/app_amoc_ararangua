import 'package:app_amoc_ararangua/core/errors/failures.dart';
import 'package:app_amoc_ararangua/core/usecases/usecase.dart';
import 'package:app_amoc_ararangua/features/domain/entities/account_entity.dart';
import 'package:app_amoc_ararangua/features/domain/usecases/get_logged_user_usecase.dart';
import 'package:flutter_triple/flutter_triple.dart';

class AccountStore extends NotifierStore<Failure, AccountEntity> {
  final GetLoggedUserUseCase getLoggedUserUseCase;
  AccountStore(this.getLoggedUserUseCase) : super(AccountEntity.empty());

  getLoggedUser() async {
    setLoading(true);

    final result = await getLoggedUserUseCase(NoParams());
    result.fold(
      setError,
      update,
    );

    setLoading(false);
  }
}