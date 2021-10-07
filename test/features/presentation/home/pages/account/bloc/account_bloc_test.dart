import 'package:app_amoc_ararangua/core/errors/failures.dart';
import 'package:app_amoc_ararangua/core/states/bloc_state.dart';
import 'package:app_amoc_ararangua/features/domain/entities/account_entity.dart';
import 'package:app_amoc_ararangua/features/domain/repositories/account_repository.dart';
import 'package:app_amoc_ararangua/features/presentation/home/pages/account/bloc/account_bloc.dart';
import 'package:app_amoc_ararangua/features/presentation/home/pages/account/bloc/events/account_bloc_events.dart';
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

  group('getLoggedUser', () {
    blocTest(
      'should expect [LoadingBlocState, ErrorBlocState]',
      build: () => AccountBloc(repository),
      setUp: () => when(() => repository.getLoggedUser()).thenAnswer((_) async => Left(UserNotFoundFailure())),
      act: (AccountBloc bloc) => bloc.add(const GetLoggedUserBlocEvent()),
      expect: () => [BlocState.loading(), BlocState.error('')],
    );

    blocTest(
      'should expect [LoadingBlocState, ErrorBlocState]',
      build: () => AccountBloc(repository),
      setUp: () => when(() => repository.getLoggedUser()).thenAnswer((_) async => Left(NetworkFailure())),
      act: (AccountBloc bloc) => bloc.add(const GetLoggedUserBlocEvent()),
      expect: () => [BlocState.loading(), BlocState.error('')],
    );

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
      categoryId: '',
    );

    blocTest(
      'should expect [LoadingBlocState, SuccessBlocState]',
      build: () => AccountBloc(repository),
      setUp: () => when(() => repository.getLoggedUser()).thenAnswer((_) async => const Right(tAccount)),
      act: (AccountBloc bloc) => bloc.add(const GetLoggedUserBlocEvent()),
      expect: () => [BlocState.loading(), BlocState.success(tAccount)],
    );
  });
}