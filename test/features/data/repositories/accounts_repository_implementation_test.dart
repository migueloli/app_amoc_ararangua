import 'package:app_amoc_ararangua/core/errors/exceptions.dart';
import 'package:app_amoc_ararangua/core/errors/failures.dart';
import 'package:app_amoc_ararangua/core/network/network_info.dart';
import 'package:app_amoc_ararangua/features/data/datasources/accounts_remote_datasource.dart';
import 'package:app_amoc_ararangua/features/data/models/account_model.dart';
import 'package:app_amoc_ararangua/features/data/repositories/accounts_repository_implementation.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAccountDatasource extends Mock implements IAccountsRemoteDatasource {}
class MockNetworkInfo extends Mock implements INetworkInfo {}

void main() {

  late AccountsRepositoryImplementation repository;
  late IAccountsRemoteDatasource datasource;
  late INetworkInfo networkInfo;

  setUp(() {
    datasource = new MockAccountDatasource();
    networkInfo = new MockNetworkInfo();
    repository = new AccountsRepositoryImplementation(datasource, networkInfo);
  });

  group(
    'getListOfAccounts',
    () {
      group(
        'getListOfAccounts success',
        () {
          test(
            'should return a list of account models when calls the datasource',
            () async {
              //Arrange
              final tListOfAccounts = [
                AccountModel(
                  id: 1,
                  name: "Test 1",
                  document: "123",
                  email: "test1@test.com",
                  phone: "123456",
                  zip: "123456",
                  address: "Test 1",
                  number: "123",
                  neighborhood: "Test 1",
                  city: "Test 1",
                  state: "Test 1",
                  isWorker: true,
                  description: "Test 1",
                  status: 0,
                  cause: "Test 1",
                  password: "Test1",
                ),
                AccountModel(
                  id: 2,
                  name: "Test 2",
                  document: "321",
                  email: "test2@test.com",
                  phone: "654321",
                  zip: "654321",
                  address: "Test",
                  number: "321",
                  neighborhood: "Test 2",
                  city: "Test 2",
                  state: "Test 2",
                  isWorker: false,
                  description: "Test 2",
                  status: 1,
                  cause: "Test 2",
                  password: "Test2",
                ),
              ];

              when(datasource.getListOfAccounts).thenAnswer((_) async => tListOfAccounts);
              when(() => networkInfo.isConnected).thenAnswer((_) async => true);

              //Act
              final result = await repository.getListOfAccounts();

              //Assert
              expect(result, Right(tListOfAccounts));
              verify(() => networkInfo.isConnected).called(1);
              verify(() => datasource.getListOfAccounts()).called(1);
            }
          );
        }
      );

      group(
        'getListOfAccounts failure',
        (){
          test(
            'should return a ServerFailure when call to datasource is unsuccessful',
            () async {
              //Arrange
              when(datasource.getListOfAccounts).thenThrow(ServerException());
              when(() => networkInfo.isConnected).thenAnswer((_) async => true);

              //Act
              final result = await repository.getListOfAccounts();

              //Assert
              expect(result, Left(ServerFailure()));
              verify(() => networkInfo.isConnected).called(1);
              verify(() => datasource.getListOfAccounts()).called(1);
            }
          );

          test(
            'should return a NetworkFailure when call to datasource is unsuccessful',
            () async {
              //Arrange
              when(() => networkInfo.isConnected).thenAnswer((_) async => false);

              //Act
              final result = await repository.getListOfAccounts();

              //Assert
              expect(result, Left(NetworkFailure()));
              verify(() => networkInfo.isConnected).called(1);
              verifyNever(() => datasource.getListOfAccounts());
            }
          );
        }
      );
    }
  );

  group(
    'saveAccount',
    () {
      final tAccount = AccountModel(
        id: 1,
        name: "Test 1",
        document: "123",
        email: "test1@test.com",
        phone: "123456",
        zip: "123456",
        address: "Test 1",
        number: "123",
        neighborhood: "Test 1",
        city: "Test 1",
        state: "Test 1",
        isWorker: true,
        description: "Test 1",
        status: 0,
        cause: "Test 1",
        password: "Test1",
      );

      group(
        'saveAccount success',
        () {
          test(
            'should return a account model when calls the datasource',
            () async {
              //Arrange
              when(() => datasource.saveAccount(tAccount)).thenAnswer((_) async => tAccount);
              when(() => networkInfo.isConnected).thenAnswer((_) async => true);

              //Act
              final result = await repository.saveAccount(tAccount);

              //Assert
              expect(result, Right(tAccount));
              verify(() => networkInfo.isConnected).called(1);
              verify(() => datasource.saveAccount(tAccount)).called(1);
            }
          );
        }
      );

      group(
        'saveAccount failure',
        (){
          test(
            'should return a ServerFailure when call to datasource is unsuccessful',
            () async {
              //Arrange
              when(() => datasource.saveAccount(tAccount)).thenThrow(ServerException());
              when(() => networkInfo.isConnected).thenAnswer((_) async => true);

              //Act
              final result = await repository.saveAccount(tAccount);

              //Assert
              expect(result, Left(ServerFailure()));
              verify(() => networkInfo.isConnected).called(1);
              verify(() => datasource.saveAccount(tAccount)).called(1);
            }
          );

          test(
            'should return a NetworkFailure when call to datasource is unsuccessful',
            () async {
              //Arrange
              when(() => networkInfo.isConnected).thenAnswer((_) async => false);

              //Act
              final result = await repository.saveAccount(tAccount);

              //Assert
              expect(result, Left(NetworkFailure()));
              verify(() => networkInfo.isConnected).called(1);
              verifyNever(() => datasource.saveAccount(tAccount));
            }
          );
        }
      );
    }
  );

}