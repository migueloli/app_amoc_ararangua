import 'package:dartz/dartz.dart';

import '../../../core/errors/failures.dart';
import '../entities/account_entity.dart';
import '../repositories/account_repository.dart';

class CreateAccountWithEmailAndPasswordUseCase {
  final IAccountsRepository repository;

  CreateAccountWithEmailAndPasswordUseCase(this.repository);

  Future<Either<Failure, AccountEntity>> call(String email, String password) {
    return repository.createAccountWithEmailAndPassword(email, password);
  }
}