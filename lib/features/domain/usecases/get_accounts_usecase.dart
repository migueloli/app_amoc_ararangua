import 'package:dartz/dartz.dart';

import '../../../core/errors/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../entities/account_entity.dart';
import '../repositories/account_repository.dart';

class GetAccountsUseCase implements UseCase<List<AccountEntity>, NoParams> {

  final IAccountsRepository repository;

  GetAccountsUseCase(this.repository);

  @override
  Future<Either<Failure, List<AccountEntity>>> call(NoParams params) async {
    return await repository.getListOfAccounts();
  }
}