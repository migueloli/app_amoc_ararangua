import 'package:dartz/dartz.dart';

import '../../../core/errors/failures.dart';
import '../entities/account_entity.dart';
import '../repositories/account_repository.dart';

class CreateAccountWithGoogleUseCase {
  final IAccountsRepository repository;

  CreateAccountWithGoogleUseCase(this.repository);

  Future<Either<Failure, AccountEntity>> call() {
    return repository.loginWithGoogle();
  }
}