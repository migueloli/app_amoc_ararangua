import 'package:app_amoc_ararangua/core/errors/failures.dart';
import 'package:app_amoc_ararangua/core/usecases/usecase.dart';
import 'package:app_amoc_ararangua/features/domain/entities/account_entity.dart';
import 'package:app_amoc_ararangua/features/domain/usecases/get_logged_user_usecase.dart';
import 'package:app_amoc_ararangua/features/presentation/home/pages/account/store/account_store.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetLoggedUserUseCase extends Mock implements GetLoggedUserUseCase{}

void main() {
  late GetLoggedUserUseCase useCase;
  late AccountStore store;

  setUp(() {
    useCase = MockGetLoggedUserUseCase();
    store = AccountStore(useCase);
  });

  test(
    'should be an empty AccountEntity as initial state',
    () {
      expect(store.state, AccountEntity.empty());
    }
  );

  group('getLoggedUser', () {
    test('should return a UserNotFoundFailure', () {
      //Arrange
      when(() => useCase(NoParams())).thenAnswer((_) async => Left(UserNotFoundFailure()));
      //Act
      store.getLoggedUser();
      //Assert
      store.observer(
        onError: (failure) {
          expect(failure, UserNotFoundFailure());
          verify(() => useCase(NoParams())).called(1);
        }
      );
    });

    test('should return a NetworkFailure', () {
      //Arrange
      when(() => useCase(NoParams())).thenAnswer((_) async => Left(NetworkFailure()));
      //Act
      store.getLoggedUser();
      //Assert
      store.observer(
        onError: (failure) {
          expect(failure, NetworkFailure());
          verify(() => useCase(NoParams())).called(1);
        }
      );
    });

    test('should return an AccountEntity', () {
      //Arrange
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
      when(() => useCase(NoParams())).thenAnswer((_) async => Right(tAccount));
      //Act
      store.getLoggedUser();
      //Assert
      store.observer(
        onState: (state) {
          expect(state, tAccount);
          verify(() => useCase(NoParams())).called(1);
        }
      );
    });
  });
}