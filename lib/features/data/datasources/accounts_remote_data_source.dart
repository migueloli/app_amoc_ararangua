import '../models/account_model.dart';

abstract class IAccountsRemoteDataSource {

  Future<List<AccountModel>> getListOfAccounts();

  Future<AccountModel> saveAccount(AccountModel account);

}