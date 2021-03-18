import '../models/account_model.dart';

abstract class IAccountsRemoteDatasource {

  Future<List<AccountModel>> getListOfAccounts();

  Future<AccountModel> saveAccount(AccountModel account);

}