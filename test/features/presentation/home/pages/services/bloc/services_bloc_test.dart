import 'package:app_amoc_ararangua/core/errors/failures.dart';
import 'package:app_amoc_ararangua/core/states/bloc_state.dart';
import 'package:app_amoc_ararangua/features/domain/entities/account_entity.dart';
import 'package:app_amoc_ararangua/features/domain/repositories/account_repository.dart';
import 'package:app_amoc_ararangua/features/presentation/home/pages/services/bloc/events/services_bloc_event.dart';
import 'package:app_amoc_ararangua/features/presentation/home/pages/services/bloc/services_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAccountsRepository extends Mock implements IAccountsRepository {}

void main() {
  late IAccountsRepository repository;

  setUp(() {
    repository = MockAccountsRepository();
  });

  group('searchServiceAccounts', () {
    blocTest(
      'should expect [LoadingBlocState, ErrorBlocState]',
      build: () => ServicesBloc(repository),
      setUp: () => when(() => repository.getListOfAccounts()).thenAnswer((_) async => Left(ServerFailure())),
      act: (ServicesBloc bloc) => bloc.add(const SearchServicesBlocEvent()),
      expect: () => [BlocState.loading(), BlocState.error(ServicesBloc.serverFailureMessage)],
    );

    blocTest(
      'should expect [LoadingBlocState, ErrorBlocState]',
      build: () => ServicesBloc(repository),
      setUp: () => when(() => repository.getListOfAccounts()).thenAnswer((_) async => Left(NetworkFailure())),
      act: (ServicesBloc bloc) => bloc.add(const SearchServicesBlocEvent()),
      expect: () => [BlocState.loading(), BlocState.error(ServicesBloc.networkFailureMessage)],
    );

    blocTest(
      'should expect [LoadingBlocState, ErrorBlocState]',
      build: () => ServicesBloc(repository),
      setUp: () => when(() => repository.getListOfAccounts()).thenAnswer((_) async => Left(LoginFailure())),
      act: (ServicesBloc bloc) => bloc.add(const SearchServicesBlocEvent()),
      expect: () => [BlocState.loading(), BlocState.error(ServicesBloc.genericFailureMessage)],
    );

    const  tListOfAccounts = [
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

    blocTest(
      'should expect [LoadingBlocState, ErrorBlocState]',
      build: () => ServicesBloc(repository),
      setUp: () => when(() => repository.getListOfAccounts()).thenAnswer((_) async => const Right(tListOfAccounts)),
      act: (ServicesBloc bloc) => bloc.add(const SearchServicesBlocEvent()),
      expect: () => [BlocState.loading(), BlocState.success(tListOfAccounts)],
    );
  });
}