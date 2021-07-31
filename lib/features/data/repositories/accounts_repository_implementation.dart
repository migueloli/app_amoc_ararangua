import 'package:app_amoc_ararangua/features/data/models/account_model.dart';
import 'package:dartz/dartz.dart';

import '../../../core/errors/failures.dart';
import '../../../core/network/network_info.dart';
import '../../domain/entities/account_entity.dart';
import '../../domain/repositories/account_repository.dart';
import '../datasources/accounts_remote_data_source.dart';

class AccountsRepositoryImplementation implements IAccountsRepository {

  final IAccountsRemoteDataSource datasource;
  final INetworkInfo networkInfo;

  AccountsRepositoryImplementation(this.datasource, this.networkInfo);

  @override
  Future<Either<Failure, List<AccountEntity>>> getListOfAccounts() async {
    try {
      final networkConnected = await networkInfo.isConnected;
      if(!networkConnected)
        return Left(NetworkFailure());

      final result = await datasource.getListOfAccounts();
      return Right(result);
    } on Exception {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, AccountEntity>> saveAccount(AccountEntity account) async {
    try {
      final networkConnected = await networkInfo.isConnected;
      if(!networkConnected)
        return Left(NetworkFailure());

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
      );

      final result = await datasource.saveAccount(accountModel);

      return Right(result);
    } on Exception {
      return Left(ServerFailure());
    }
  }

}