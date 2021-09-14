import 'package:app_amoc_ararangua/core/errors/failures.dart';
import 'package:app_amoc_ararangua/features/domain/entities/account_entity.dart';
import 'package:app_amoc_ararangua/features/domain/repositories/account_repository.dart';
import 'package:app_amoc_ararangua/features/domain/usecases/login_with_email_and_password_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
class AccountMockRepository extends Mock implements IAccountsRepository {}

void main() {
  late LoginWithEmailAndPasswordUseCase usecase;
  late IAccountsRepository repository;

  setUp(() {
    repository = AccountMockRepository();
    usecase = LoginWithEmailAndPasswordUseCase(repository);
  });

  group('LoginWithEmailAndPasswordUseCase success', () {
    test('should return an AccountEntity', () async {
      // Arrange
      const email = 'test@test.com';
      const password = '123456';
      const tAccount = AccountEntity(
        name: "Test 1",
        document: "123",
        email: email,
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
      when(() => repository.loginWithEmailAndPassword(email, password))
          .thenAnswer((invocation) async => const Right(tAccount));
      // Act
      final result = await usecase(email, password);
      // Assert
      expect(result, const Right(tAccount));
      verify(() => repository.loginWithEmailAndPassword(email, password)).called(1);
    });
  });

  group('LoginWithEmailAndPasswordUseCase failure', () {
    test('should return an LoginFailure', () async {
      // Arrange
      const email = 'test@test.com';
      const password = '123456';
      final tFailure = LoginFailure();
      when(() => repository.loginWithEmailAndPassword(email, password))
          .thenAnswer((invocation) async => Left(tFailure));
      // Act
      final result = await usecase(email, password);
      // Assert
      expect(result, Left(tFailure));
      verify(() => repository.loginWithEmailAndPassword(email, password)).called(1);
    });
  });
}