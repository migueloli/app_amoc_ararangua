import 'package:app_amoc_ararangua/core/errors/failures.dart';
import 'package:app_amoc_ararangua/core/usecases/usecase.dart';
import 'package:app_amoc_ararangua/features/domain/entities/account_entity.dart';
import 'package:app_amoc_ararangua/features/domain/repositories/account_repository.dart';
import 'package:dartz/dartz.dart';

class GetLoggedUserUseCase implements UseCase<AccountEntity?, NoParams> {

  final IAccountsRepository repository;

  GetLoggedUserUseCase(this.repository);

  @override
  Future<Either<Failure, AccountEntity>> call(NoParams params) async {
    return await repository.getLoggedUser();
  }

}