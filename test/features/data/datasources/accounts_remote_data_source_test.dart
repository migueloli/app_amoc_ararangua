import 'package:app_amoc_ararangua/features/data/datasources/accounts_remote_data_source.dart';
import 'package:app_amoc_ararangua/features/data/models/account_model.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AccountsRemoteDataSourceImplementation dataSource;
  late FakeFirebaseFirestore mockFirebaseStore;

  setUp(() {
    mockFirebaseStore = FakeFirebaseFirestore();
    dataSource = AccountsRemoteDataSourceImplementation(mockFirebaseStore);
  });

  group(
    'getListOfAccounts',
    () {
      final tListOfAccounts = [
        AccountModel(
          id: "",
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
          status: 1,
          cause: "Test 1",
        ),
        AccountModel(
          id: "",
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
          isWorker: true,
          description: "Test 2",
          status: 1,
          cause: "Test 2",
        ),
      ];

      test(
        'should return an List<AccountModel>',
        () async {
          //Arrange
          for(var tAccount in tListOfAccounts) {
            await mockFirebaseStore.collection('users').add(tAccount.toJson());
          }

          //Act
          final result = await dataSource.getListOfAccounts();

          //Assert
          expect(result, tListOfAccounts);
        }
      );

    //   test(
    //     'should throw a ServerException when the response code is a negative response',
    //     () async {
    //       //Arrange
    //       when(() => mockDio.get(any()))
    //         .thenAnswer(
    //           (_) async => Response(
    //             data: 'Something went wrong.',
    //             statusCode: HttpStatus.notFound,
    //             requestOptions: RequestOptions(
    //               path: url,
    //             ),
    //           )
    //         );

    //       //Act
    //       final call = dataSource.getListOfAccounts;

    //       //Assert
    //       expect(() => call(), throwsA(isA<ServerException>()));
    //       verify(() => mockDio.get(any())).called(1);
    //     }
    //   );
    }
  );

  group(
    'saveAccount',
    () {
      final tAccount = AccountModel(
        id: "",
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
      );

      test(
        'should return an AccountModel',
        () async {
          //Act
          final result = await dataSource.saveAccount(tAccount);

          //Assert
          expect(result, tAccount);
        }
      );

      // test(
      //   'should throw a ServerException when the response code is a negative response',
      //   () async {
      //     //Arrange
      //     when(() => mockDio.post(any(), data: any(named: 'data')))
      //       .thenAnswer(
      //         (_) async => Response(
      //           data: 'Something went wrong.',
      //           statusCode: HttpStatus.notFound,
      //           requestOptions: RequestOptions(
      //             path: url,
      //           ),
      //         )
      //       );

      //     //Act
      //     final call = dataSource.saveAccount;

      //     //Assert
      //     expect(() => call(tAccount), throwsA(isA<ServerException>()));
      //     verify(() => mockDio.post(any(), data: any(named: 'data'))).called(1);
      //   }
      // );
    }
  );

}