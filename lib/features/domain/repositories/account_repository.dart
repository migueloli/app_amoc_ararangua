import 'package:dartz/dartz.dart';

import '../../../core/errors/failures.dart';
import '../entities/account_entity.dart';

abstract class IAccountsRepository {

  Future<Either<Failure, List<AccountEntity>>> getListOfAccounts();

  Future<Either<Failure, AccountEntity>> saveAccount(AccountEntity account);

  Future<Either<Failure, AccountEntity>> getAccount(String uid);

  Future<Either<Failure, AccountEntity>> loginWithEmailAndPassword(String email, String password);

  Future<Either<Failure, AccountEntity>> loginWithGoogle();

}