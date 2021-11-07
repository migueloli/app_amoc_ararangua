import '../models/account_model.dart';

abstract class IAccountsRemoteDataSource {

  Future<List<AccountModel>> getListOfAccounts({bool? isWorker = true, int? status = 1});

  Future<AccountModel> saveAccount(AccountModel account);

  Future<AccountModel> getAccount(String uid);

  Future<AccountModel> createAccountWithEmailAndPassword(String email, String password);

  Future<AccountModel> loginWithEmailAndPassword(String email, String password);

  Future<AccountModel> loginWithGoogle();

  Future<AccountModel> getLoggedUser();

}
