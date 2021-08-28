import 'package:mobx_triple/mobx_triple.dart';

import '../../../../../../core/errors/failures.dart';
import '../../../../../domain/entities/account_entity.dart';
import '../../../../../domain/usecases/get_logged_user_use_case.dart';

class AccountStore extends MobXStore<Failure, AccountEntity> {

  final GetLoggedUserUseCase getLoggedUserUseCase;

  AccountStore(this.getLoggedUserUseCase) : super(AccountEntity.empty());

  Future<void> getLoggedUser() async {
    setLoading(true);

    final result = await getLoggedUserUseCase();
    result.fold(
      setError,
      update,
    );

    setLoading(false);
  }
}