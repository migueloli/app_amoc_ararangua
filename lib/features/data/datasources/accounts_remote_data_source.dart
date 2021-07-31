import 'package:app_amoc_ararangua/core/errors/exceptions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/account_model.dart';

abstract class IAccountsRemoteDataSource {

  Future<List<AccountModel>> getListOfAccounts();

  Future<AccountModel> saveAccount(AccountModel account);

}

class AccountsRemoteDataSourceImplementation extends IAccountsRemoteDataSource {

  final FirebaseFirestore store;

  AccountsRemoteDataSourceImplementation(this.store);

  @override
  Future<List<AccountModel>> getListOfAccounts() async {
    try {
      final response = await store.collection('users').where('is_worker', isEqualTo: true).where('status', isEqualTo: 1).get();
      final accountList = <AccountModel>[];

      for(var doc in response.docs) {
        accountList.add(AccountModel.fromJson(doc.data()));
      }

      return accountList;
    } catch(exception) {
      throw ServerException;
    }
  }

  @override
  Future<AccountModel> saveAccount(AccountModel account) async {
    try {
      final response = await store.collection('users').add(account.toJson());
      final doc = await response.get();
      final data = doc.data();

      if(data != null) {
        return AccountModel.fromJson(data);
      } else {
        throw ServerException();
      }
    } catch(exception) {
      throw ServerException();
    }
  }

}