import 'dart:io';

import 'package:app_amoc_ararangua/core/errors/exceptions.dart';
import 'package:dio/dio.dart';

import '../models/account_model.dart';

abstract class IAccountsRemoteDataSource {

  Future<List<AccountModel>> getListOfAccounts();

  Future<AccountModel> saveAccount(AccountModel account);

}

class AccountsRemoteDataSourceImplementation extends IAccountsRemoteDataSource {

  final Dio dio;

  AccountsRemoteDataSourceImplementation(this.dio);

  @override
  Future<List<AccountModel>> getListOfAccounts() async {
    final response = await dio.get('user');

    if(response.statusCode == HttpStatus.ok) {
      final accountList = <AccountModel>[];

      for(var json in response.data) {
        accountList.add(AccountModel.fromJson(json));
      }

      return accountList;
    }

    throw ServerException();
  }

  @override
  Future<AccountModel> saveAccount(AccountModel account) async {
    final response = await dio.post(
      'user',
      data: account.toJson(),
    );

    if(response.statusCode == HttpStatus.created) {
      return AccountModel.fromJson(response.data);
    }

    throw ServerException();
  }

}