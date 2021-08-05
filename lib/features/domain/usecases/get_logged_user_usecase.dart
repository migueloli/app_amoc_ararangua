import 'package:dartz/dartz.dart';

import '../../../core/errors/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../entities/account_entity.dart';
import '../repositories/account_repository.dart';

class GetLoggedUserUseCase implements UseCase<AccountEntity?, NoParams> {

  final IAccountsRepository repository;

  GetLoggedUserUseCase(this.repository);

  @override
  Future<Either<Failure, AccountEntity>> call(NoParams params) async {
    return await repository.getLoggedUser();
  }

}