import 'package:app_amoc_ararangua/core/errors/failures.dart';
import 'package:app_amoc_ararangua/features/domain/entities/account_entity.dart';
import 'package:app_amoc_ararangua/features/domain/repositories/account_repository.dart';
import 'package:app_amoc_ararangua/features/domain/usecases/get_accounts_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAccountsRepository extends Mock implements IAccountsRepository {}

void main() {

  late GetAccountsUseCase usecase;
  late IAccountsRepository repository;

  setUp(() {
    repository = MockAccountsRepository();
    usecase = GetAccountsUseCase(repository);
  });

  group(
    'GetAccountsUseCase success',
    () {
      test(
          'should get a list of accounts from the repository',
          () async {
            //Arrange
            const tListOfAccounts = [
              AccountEntity(
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
              ),
              AccountEntity(
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
              ),
            ];

            when(repository.getListOfAccounts).thenAnswer((_) async => const Right(tListOfAccounts));

            //Act
            final result = await usecase();

            //Assert
            expect(result, const Right(tListOfAccounts));
            verify(() => repository.getListOfAccounts()).called(1);
          },
        );
    }
  );

  group(
    'GetAccountsUseCase failure',
    () {
      test(
        "should get a ServerFailure when don't succeed",
        () async {
          //Arrange
          final tServerFailure = ServerFailure();

          when(repository.getListOfAccounts).thenAnswer((_) async => Left(tServerFailure));

          //Act
          final result = await usecase();

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

          when(repository.getListOfAccounts).thenAnswer((_) async => Left(tNetworkFailure));

          //Act
          final result = await usecase();

          //Assert
          expect(result, Left(tNetworkFailure));
          verify(() => repository.getListOfAccounts()).called(1);
        },
      );
    }
  );

}