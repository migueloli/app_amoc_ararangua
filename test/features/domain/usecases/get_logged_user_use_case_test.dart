import 'package:app_amoc_ararangua/core/errors/failures.dart';
import 'package:app_amoc_ararangua/features/domain/entities/account_entity.dart';
import 'package:app_amoc_ararangua/features/domain/repositories/account_repository.dart';
import 'package:app_amoc_ararangua/features/domain/usecases/get_logged_user_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAccountsRepository extends Mock implements IAccountsRepository {}

void main() {
  late IAccountsRepository repository;
  late GetLoggedUserUseCase useCase;

  setUp(() {
    repository = MockAccountsRepository();
    useCase = GetLoggedUserUseCase(repository);
  });

  test(
    'GetLoggedUserUseCase should get the logged user from the repository',
    () async {
      //Arrange
      const tAccount = AccountEntity(
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

      when(repository.getLoggedUser).thenAnswer((_) async => const Right(tAccount));

      //Act
      final result = await useCase();

      //Assert
      expect(result, const Right(tAccount));
      verify(() => repository.getLoggedUser()).called(1);
    }
  );

  test(
    "should get a UserNotFoundFailure when don't succeed",
    () async {
      //Arrange
      final tUserNotFoundFailure = UserNotFoundFailure();

      when(repository.getLoggedUser).thenAnswer((_) async => Left(tUserNotFoundFailure));

      //Act
      final result = await useCase();

      //Assert
      expect(result, Left(tUserNotFoundFailure));
      verify(() => repository.getLoggedUser()).called(1);
    },
  );

  test(
    'should get a NetworkFailure when out of connectivity',
    () async {
      //Arrange
      final tNetworkFailure = NetworkFailure();

      when(repository.getLoggedUser).thenAnswer((_) async => Left(tNetworkFailure));

      //Act
      final result = await useCase();

      //Assert
      expect(result, Left(tNetworkFailure));
      verify(() => repository.getLoggedUser()).called(1);
    },
  );
}