import 'package:dartz/dartz.dart';

import '../../../core/errors/exceptions.dart';
import '../../../core/errors/failures.dart';
import '../../../core/network/network_info.dart';
import '../../domain/entities/account_entity.dart';
import '../../domain/repositories/account_repository.dart';
import '../datasources/accounts_remote_datasource.dart';
import '../models/account_model.dart';

class AccountsRepositoryImplementation implements IAccountsRepository {

  final IAccountsRemoteDataSource datasource;
  final INetworkInfo networkInfo;

  AccountsRepositoryImplementation(this.datasource, this.networkInfo);

  @override
  Future<Either<Failure, List<AccountEntity>>> getListOfAccounts({bool? isWorker = true, int? status = 1}) async {
    try {
      final networkConnected = await networkInfo.isConnected;
      if(!networkConnected) return Left(NetworkFailure());

      final result = await datasource.getListOfAccounts(isWorker: isWorker, status: status);
      return Right(result);
    } on Exception {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, AccountEntity>> saveAccount(AccountEntity account) async {
    try {
      final networkConnected = await networkInfo.isConnected;
      if(!networkConnected) return Left(NetworkFailure());

      final accountModel = AccountModel(
        id: account.id,
        name: account.name,
        document: account.document,
        email: account.email,
        phone: account.phone,
        zip: account.zip,
        address: account.address,
        number: account.number,
        neighborhood: account.neighborhood,
        city: account.city,
        state: account.state,
        isWorker: account.isWorker,
        description: account.description,
        status: account.status,
        cause: account.cause,
        categoryId: account.categoryId,
        isAdmin: account.isAdmin,
      );

      final result = await datasource.saveAccount(accountModel);

      return Right(result);
    } on Exception {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, AccountEntity>> getAccount(String uid) async {
    try {
      final networkConnected = await networkInfo.isConnected;
      if(!networkConnected) return Left(NetworkFailure());

      final result = await datasource.getAccount(uid);

      return Right(result);
    } on UserNotFoundException {
      return Left(UserNotFoundFailure());
    } catch(e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, AccountEntity>> createAccountWithEmailAndPassword(String email, String password) async {
    try {
      final networkConnected = await networkInfo.isConnected;
      if(!networkConnected) return Left(NetworkFailure());

      final result = await datasource.createAccountWithEmailAndPassword(email, password);

      return Right(result);
    } on Exception catch (e) {
      return Left(_prepareFailureFromException(e));
    }
  }

  @override
  Future<Either<Failure, AccountEntity>> loginWithEmailAndPassword(String email, String password) async {
    try {
      final networkConnected = await networkInfo.isConnected;
      if(!networkConnected) return Left(NetworkFailure());

      final result = await datasource.loginWithEmailAndPassword(email, password);

      return Right(result);
    } on Exception catch (e) {
      return Left(_prepareFailureFromException(e));
    }
  }

  @override
  Future<Either<Failure, AccountEntity>> loginWithGoogle() async {
    try {
      final networkConnected = await networkInfo.isConnected;
      if(!networkConnected) return Left(NetworkFailure());

      final result = await datasource.loginWithGoogle();

      return Right(result);
    } on Exception catch (e) {
      return Left(_prepareFailureFromException(e));
    }
  }

  @override
  Future<Either<Failure, AccountEntity>> getLoggedUser() async {
    try {
      final networkConnected = await networkInfo.isConnected;
      if(!networkConnected) return Left(NetworkFailure());

      final result = await datasource.getLoggedUser();

      return Right(result);
    } on Exception {
      return Left(UserNotFoundFailure());
    }
  }

  Failure _prepareFailureFromException(Exception e) {
    switch(e.runtimeType) {
      case EmailAlreadyInUseException:
        return EmailAlreadyInUseFailure();
      case WeakPasswordException:
        return WeakPasswordFailure();
      case InvalidEmailException:
        return InvalidEmailFailure();
      case OperationNotAllowedException:
        return OperationNotAllowedFailure();
      case UserDisabledException:
        return UserDisabledFailure();
      case UserNotFoundException:
        return UserNotFoundFailure();
      case WrongPasswordException:
        return WrongPasswordFailure();
      case AccountExistsWithDifferentCredentialException:
        return AccountExistsWithDifferentCredentialFailure();
      case InvalidCredentialException:
        return InvalidCredentialFailure();
      case InvalidVerificationCodeException:
        return InvalidVerificationCodeFailure();
      case InvalidVerificationIdException:
        return InvalidVerificationIdFailure();
      case LoginException:
        return LoginFailure();
      default:
        return ServerFailure();
    }
  }

}
