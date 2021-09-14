import 'package:dartz/dartz.dart';

import '../../../core/errors/failures.dart';
import '../entities/account_entity.dart';
import '../repositories/account_repository.dart';

class LoginWithGoogleUseCase {
  final IAccountsRepository repository;

  LoginWithGoogleUseCase(this.repository);

  Future<Either<Failure, AccountEntity>> call() {
    return repository.loginWithGoogle();
  }
}