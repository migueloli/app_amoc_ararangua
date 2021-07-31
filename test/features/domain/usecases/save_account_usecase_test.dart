import 'package:app_amoc_ararangua/core/errors/failures.dart';
import 'package:app_amoc_ararangua/features/domain/entities/account_entity.dart';
import 'package:app_amoc_ararangua/features/domain/repositories/account_repository.dart';
import 'package:app_amoc_ararangua/features/domain/usecases/save_account_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAccountsRepository extends Mock implements IAccountsRepository {}

void main() {

  late SaveAccountUseCase usecase;
  late IAccountsRepository repository;

  setUp(() {
    repository = new MockAccountsRepository();
    usecase = new SaveAccountUseCase(repository);
  });

  final tAccount = AccountEntity(
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
    status: 0,
    cause: "Test 1",
  );

  group(
    'SaveAccountUseCase success',
    () {
      test(
          'should get a list of accounts from the repository',
          () async {
            //Arrange
            when(() => repository.saveAccount(tAccount)).thenAnswer((_) async => Right(tAccount));

            //Act
            final result = await usecase(tAccount);

            //Assert
            expect(result, Right(tAccount));
            verify(() => repository.saveAccount(tAccount)).called(1);
          },
        );
    }
  );

  group(
    'SaveAccountUseCase failure',
    () {
      test(
        'should get a ServerFailure when don\'t succeed',
        () async {
          //Arrange
          final tServerFailure = ServerFailure();

          when(() => repository.saveAccount(tAccount)).thenAnswer((_) async => Left(tServerFailure));

          //Act
          final result = await usecase(tAccount);

          //Assert
          expect(result, Left(tServerFailure));
          verify(() => repository.saveAccount(tAccount)).called(1);
        },
      );

      test(
        'should get a NetworkFailure when out of connectivity',
        () async {
          //Arrange
          final tNetworkFailure = NetworkFailure();

          when(() => repository.saveAccount(tAccount)).thenAnswer((_) async => Left(tNetworkFailure));

          //Act
          final result = await usecase(tAccount);

          //Assert
          expect(result, Left(tNetworkFailure));
          verify(() => repository.saveAccount(tAccount)).called(1);
        },
      );
    }
  );

}