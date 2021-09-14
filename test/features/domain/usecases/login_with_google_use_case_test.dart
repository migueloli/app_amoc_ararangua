import 'package:app_amoc_ararangua/core/errors/failures.dart';
import 'package:app_amoc_ararangua/features/domain/entities/account_entity.dart';
import 'package:app_amoc_ararangua/features/domain/repositories/account_repository.dart';
import 'package:app_amoc_ararangua/features/domain/usecases/login_with_google_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class AccountMockRepository extends Mock implements IAccountsRepository {}

void main() {
  late LoginWithGoogleUseCase usecase;
  late IAccountsRepository repository;

  setUp(() {
    repository = AccountMockRepository();
    usecase = LoginWithGoogleUseCase(repository);
  });

  group('LoginWithGoogleUseCase success', () {
    test('should return an AccountEntity', () async {
      // Arrange
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
      when(repository.loginWithGoogle)
          .thenAnswer((invocation) async => const Right(tAccount));
      // Act
      final result = await usecase();
      // Assert
      expect(result, const Right(tAccount));
      verify(repository.loginWithGoogle).called(1);
    });
  });

  group('LoginWithGoogleUseCase failure', () {
    test('should return an LoginFailure', () async {
      // Arrange
      final tFailure = LoginFailure();
      when(repository.loginWithGoogle)
          .thenAnswer((invocation) async => Left(tFailure));
      // Act
      final result = await usecase();
      // Assert
      expect(result, Left(tFailure));
      verify(repository.loginWithGoogle).called(1);
    });
  });
}