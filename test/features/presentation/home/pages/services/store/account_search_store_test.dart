import 'package:app_amoc_ararangua/core/errors/failures.dart';
import 'package:app_amoc_ararangua/core/usecases/usecase.dart';
import 'package:app_amoc_ararangua/features/domain/entities/account_entity.dart';
import 'package:app_amoc_ararangua/features/domain/usecases/get_accounts_usecase.dart';
import 'package:app_amoc_ararangua/features/presentation/home/pages/services/store/account_search_store.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetAccountsUseCase extends Mock implements GetAccountsUseCase {}

void main() {
  late GetAccountsUseCase useCase;
  late AccountSearchStore store;

  setUp(() {
    useCase = MockGetAccountsUseCase();
    store = AccountSearchStore(getAccountUseCase: useCase);
  });

  test(
    'should be an empty list of accounts as initial state',
    () {
      expect(store.state, []);
    }
  );

  group('searchServiceAccounts', () {
    test('should return a ServerFailure', () {
      //Arrange
      when(() => useCase(NoParams())).thenAnswer((_) async => Left(ServerFailure()));
      //Act
      store.searchServiceAccounts();
      //Assert
      store.observer(
        onError: (failure) {
          expect(failure, ServerFailure());
          verify(() => useCase(NoParams())).called(1);
        }
      );
    });

    test('should return a NetworkFailure', () {
      //Arrange
      when(() => useCase(NoParams())).thenAnswer((_) async => Left(NetworkFailure()));
      //Act
      store.searchServiceAccounts();
      //Assert
      store.observer(
        onError: (failure) {
          expect(failure, NetworkFailure());
          verify(() => useCase(NoParams())).called(1);
        }
      );
    });

    test('should return a list of AccountEntity', () {
      //Arrange
      final tListOfAccounts = [
        AccountEntity(
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
        ),
        AccountEntity(
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
          isWorker: false,
          description: "Test 2",
          status: 1,
          cause: "Test 2",
        ),
      ];
      when(() => useCase(NoParams())).thenAnswer((_) async => Right(tListOfAccounts));
      //Act
      store.searchServiceAccounts();
      //Assert
      store.observer(
        onState: (state) {
          expect(state, tListOfAccounts);
          verify(() => useCase(NoParams())).called(1);
        }
      );
    });
  });
}