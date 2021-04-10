import 'package:app_amoc_ararangua/core/errors/failures.dart';
import 'package:app_amoc_ararangua/core/states/bloc_state.dart';
import 'package:app_amoc_ararangua/core/usecases/usecase.dart';
import 'package:app_amoc_ararangua/features/domain/entities/account_entity.dart';
import 'package:app_amoc_ararangua/features/domain/usecases/get_accounts_usecase.dart';
import 'package:app_amoc_ararangua/features/presentation/home/bloc/home_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetAccountsUseCase extends Mock implements GetAccountsUseCase {}

class MockFailure extends Failure{
  @override
  List<Object> get props => [];
}

void main() {
  late MockGetAccountsUseCase useCase;
  late HomeBloc bloc;

  setUp((){
    useCase = MockGetAccountsUseCase();
    bloc = HomeBloc(getAccountUseCase: useCase);
  });

  test(
    'should be EmptyBlocState as initial state',
    () {
      expect(bloc.state, isA<EmptyBlocState>());
    }
  );

  group(
    'getAccounts',
    () {
      test(
        'should emit [LoadingBlocState, ErrorBlocState] with ServerFailure',
        () {
          //Arrange
          final expected = [
            LoadingBlocState(),
            ErrorBlocState(message: SERVER_FAILURE_MESSAGE),
          ];
          when(() => useCase(NoParams())).thenAnswer((_) async => Left(ServerFailure()));

          //Assert Later
          expectLater(bloc.stream, emitsInOrder(expected));

          //Act
          bloc.add(GetAccountsEvent());
        }
      );

      test(
        'should emit [LoadingBlocState, ErrorBlocState] with NetworkFailure',
        () {
          //Arrange
          final expected = [
            LoadingBlocState(),
            ErrorBlocState(message: NETWORK_FAILURE_MESSAGE),
          ];
          when(() => useCase(NoParams())).thenAnswer((_) async => Left(NetworkFailure()));

          //Assert Later
          expectLater(bloc.stream, emitsInOrder(expected));

          //Act
          bloc.add(GetAccountsEvent());
        }
      );

      test(
        'should emit [LoadingBlocState, ErrorBlocState] with generic failure',
        () {
          //Arrange
          final expected = [
            LoadingBlocState(),
            ErrorBlocState(message: GENERIC_FAILURE_MESSAGE),
          ];
          when(() => useCase(NoParams())).thenAnswer((_) async => Left(MockFailure()));

          //Assert Later
          expectLater(bloc.stream, emitsInOrder(expected));

          //Act
          bloc.add(GetAccountsEvent());
        }
      );

      test(
        'should emit [LoadingBlocState, SuccessBlocState]',
        () {
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

          //Arrange
          final expected = [
            LoadingBlocState(),
            SuccessBlocState(value: tListOfAccounts),
          ];
          when(() => useCase(NoParams())).thenAnswer((_) async => Right(tListOfAccounts));

          //Assert Later
          expectLater(bloc.stream, emitsInOrder(expected));

          //Act
          bloc.add(GetAccountsEvent());
        }
      );
    }
  );

}