import 'package:dartz/dartz.dart';

import '../../../core/errors/failures.dart';
import '../entities/account_entity.dart';
import '../repositories/account_repository.dart';

class GetAccountsUseCase {

  final IAccountsRepository repository;

  GetAccountsUseCase(this.repository);

  Future<Either<Failure, List<AccountEntity>>> call() {
    return repository.getListOfAccounts();
  }
}