import 'package:dartz/dartz.dart';

import '../../../core/errors/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../entities/account_entity.dart';
import '../repositories/account_repository.dart';

class SaveAccountUseCase implements UseCase<AccountEntity, AccountEntity> {

  final IAccountsRepository repository;

  SaveAccountUseCase(this.repository);

  @override
  Future<Either<Failure, AccountEntity>> call(AccountEntity params) async {
    return await repository.saveAccount(params);
  }
}