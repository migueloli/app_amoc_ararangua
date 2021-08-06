import 'package:flutter_triple/flutter_triple.dart';

import '../../../../../../core/errors/failures.dart';
import '../../../../../../core/usecases/usecase.dart';
import '../../../../../domain/entities/account_entity.dart';
import '../../../../../domain/usecases/get_logged_user_usecase.dart';

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