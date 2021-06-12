import 'dart:convert';
import 'dart:io';

import 'package:app_amoc_ararangua/core/errors/exceptions.dart';
import 'package:app_amoc_ararangua/features/data/datasources/accounts_remote_data_source.dart';
import 'package:app_amoc_ararangua/features/data/models/account_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../fixtures/fixture_reader.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late AccountsRemoteDataSourceImplementation dataSource;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    dataSource = AccountsRemoteDataSourceImplementation(mockDio);
  });

  group(
    'getListOfAccounts',
    () {
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
      final url = 'https://amoc-api.herokuapp.com/api/v1/user';

      test(
        'should return an List<AccountModel> when the response code is 200(success)',
        () async {
          //Arrange
          final tCategoryListJson = json.decode(fixture('account_list.json'));

          when(() => mockDio.get(any()))
            .thenAnswer(
              (_) async => Response(
                data: tCategoryListJson,
                statusCode: HttpStatus.ok,
                requestOptions: RequestOptions(
                  path: url,
                ),
              )
            );

          //Act
          final result = await dataSource.getListOfAccounts();

          //Assert
          verify(() => mockDio.get(any())).called(1);
          expect(result, tListOfAccounts);
        }
      );

      test(
        'should throw a ServerException when the response code is a negative response',
        () async {
          //Arrange
          when(() => mockDio.get(any()))
            .thenAnswer(
              (_) async => Response(
                data: 'Something went wrong.',
                statusCode: HttpStatus.notFound,
                requestOptions: RequestOptions(
                  path: url,
                ),
              )
            );

          //Act
          final call = dataSource.getListOfAccounts;

          //Assert
          expect(() => call(), throwsA(isA<ServerException>()));
          verify(() => mockDio.get(any())).called(1);
        }
      );
    }
  );

  group(
    'saveAccount',
    () {
      final tAccount = AccountModel(
        id: 1,
        name: "Test",
        document: "123",
        email: "test@test.com",
        phone: "123456",
        zip: "123456",
        address: "Test",
        number: "123",
        neighborhood: "Test",
        city: "Test",
        state: "Test",
        isWorker: true,
        description: "Test",
        status: 0,
        cause: "Test",
        password: "Test",
      );
      final url = 'https://amoc-api.herokuapp.com/api/v1/user';
      final tAccountJson = json.decode(fixture('account.json'));

      test(
        'should return an AccountModel when the response code is 201(created)',
        () async {
          //Arrange
          when(() => mockDio.post(any(), data: any(named: 'data')))
            .thenAnswer(
              (_) async => Response(
                data: tAccountJson,
                statusCode: HttpStatus.created,
                requestOptions: RequestOptions(
                  path: url,
                ),
              )
            );

          //Act
          final result = await dataSource.saveAccount(tAccount);

          //Assert
          verify(() => mockDio.post(any(), data: any(named: 'data'))).called(1);
          expect(result, tAccount);
        }
      );

      test(
        'should throw a ServerException when the response code is a negative response',
        () async {
          //Arrange
          when(() => mockDio.post(any(), data: any(named: 'data')))
            .thenAnswer(
              (_) async => Response(
                data: 'Something went wrong.',
                statusCode: HttpStatus.notFound,
                requestOptions: RequestOptions(
                  path: url,
                ),
              )
            );

          //Act
          final call = dataSource.saveAccount;

          //Assert
          expect(() => call(tAccount), throwsA(isA<ServerException>()));
          verify(() => mockDio.post(any(), data: any(named: 'data'))).called(1);
        }
      );
    }
  );

}