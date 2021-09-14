import 'package:dartz/dartz.dart';

import '../../../core/errors/failures.dart';
import '../entities/account_entity.dart';
import '../repositories/account_repository.dart';

class LoginWithEmailAndPasswordUseCase {
  final IAccountsRepository repository;

  LoginWithEmailAndPasswordUseCase(this.repository);

  Future<Either<Failure, AccountEntity>> call(String email, String password) {
    return repository.loginWithEmailAndPassword(email, password);
  }
}