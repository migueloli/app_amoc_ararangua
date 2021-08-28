import 'package:dartz/dartz.dart';

import '../../../core/errors/failures.dart';
import '../entities/account_entity.dart';
import '../repositories/account_repository.dart';

class SaveAccountUseCase {

  final IAccountsRepository repository;

  SaveAccountUseCase(this.repository);

  Future<Either<Failure, AccountEntity>> call(AccountEntity params) {
    return repository.saveAccount(params);
  }
}