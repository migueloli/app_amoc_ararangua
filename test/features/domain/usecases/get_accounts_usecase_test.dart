import 'package:app_amoc_ararangua/core/errors/failures.dart';
import 'package:app_amoc_ararangua/core/usecases/usecase.dart';
import 'package:app_amoc_ararangua/features/domain/entities/account_entity.dart';
import 'package:app_amoc_ararangua/features/domain/repositories/account_repository.dart';
import 'package:app_amoc_ararangua/features/domain/usecases/get_accounts_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAccountsRepository extends Mock implements IAccountsRepository {}

void main() {

  late GetAccountsUseCase usecase;
  late IAccountsRepository repository;

  setUp(() {
    repository = new MockAccountsRepository();
    usecase = new GetAccountsUseCase(repository);
  });

  group(
    'GetAccountsUseCase success',
    () {
      test(
          'should get a list of accounts from the repository',
          () async {
            //Arrange
            final tListOfAccounts = [
              AccountEntity(
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
              AccountEntity(
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
                password: "Test2"
              ),
            ];
            final tNoParam = NoParams();

            when(repository.getListOfAccounts).thenAnswer((_) async => Right(tListOfAccounts));

            //Act
            final result = await usecase(tNoParam);

            //Assert
            expect(result, Right(tListOfAccounts));
            verify(() => repository.getListOfAccounts()).called(1);
          },
        );
    }
  );

  group(
    'GetAccountsUseCase failure',
    () {
      test(
        'should get a ServerFailure when don\'t succeed',
        () async {
          //Arrange
          final tServerFailure = ServerFailure();
          final tNoParam = NoParams();

          when(repository.getListOfAccounts).thenAnswer((_) async => Left(tServerFailure));

          //Act
          final result = await usecase(tNoParam);

          //Assert
          expect(result, Left(tServerFailure));
          verify(() => repository.getListOfAccounts()).called(1);
        },
      );

      test(
        'should get a NetworkFailure when out of connectivity',
        () async {
          //Arrange
          final tNetworkFailure = NetworkFailure();
          final tNoParam = NoParams();

          when(repository.getListOfAccounts).thenAnswer((_) async => Left(tNetworkFailure));

          //Act
          final result = await usecase(tNoParam);

          //Assert
          expect(result, Left(tNetworkFailure));
          verify(() => repository.getListOfAccounts()).called(1);
        },
      );
    }
  );

}