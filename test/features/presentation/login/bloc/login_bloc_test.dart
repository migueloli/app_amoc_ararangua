import 'package:app_amoc_ararangua/core/errors/failures.dart';
import 'package:app_amoc_ararangua/core/states/bloc_state.dart';
import 'package:app_amoc_ararangua/features/domain/entities/account_entity.dart';
import 'package:app_amoc_ararangua/features/domain/repositories/account_repository.dart';
import 'package:app_amoc_ararangua/features/presentation/login/bloc/events/login_bloc_event.dart';
import 'package:app_amoc_ararangua/features/presentation/login/bloc/login_bloc.dart';
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

  group('CreateAccountWithEmailAndPasswordEvent', () {
    blocTest(
      'should expect [LoadingBlocState, ErrorBlocState]',
      build: () => LoginBloc(repository),
      setUp: () => when(() => repository.getLoggedUser()).thenAnswer((_) async => Left(InvalidEmailFailure())),
      act: (LoginBloc bloc) => bloc.add(const LoginWithEmailAndPasswordBlocEvent()),
      expect: () => [BlocState.loading(), BlocState.error(LoginBloc.invalidEmailMessage)],
    );

    blocTest(
      'should expect [LoadingBlocState, ErrorBlocState]',
      build: () => LoginBloc(repository),
      setUp: () => when(() => repository.getLoggedUser()).thenAnswer((_) async => Left(UserDisabledFailure())),
      act: (LoginBloc bloc) => bloc.add(const LoginWithEmailAndPasswordBlocEvent()),
      expect: () => [BlocState.loading(), BlocState.error(LoginBloc.userDisabledMessage)],
    );

    blocTest(
      'should expect [LoadingBlocState, ErrorBlocState]',
      build: () => LoginBloc(repository),
      setUp: () => when(() => repository.getLoggedUser()).thenAnswer((_) async => Left(UserNotFoundFailure())),
      act: (LoginBloc bloc) => bloc.add(const LoginWithEmailAndPasswordBlocEvent()),
      expect: () => [BlocState.loading(), BlocState.error(LoginBloc.userNotFoundMessage)],
    );

    blocTest(
      'should expect [LoadingBlocState, ErrorBlocState]',
      build: () => LoginBloc(repository),
      setUp: () => when(() => repository.getLoggedUser()).thenAnswer((_) async => Left(WrongPasswordFailure())),
      act: (LoginBloc bloc) => bloc.add(const LoginWithEmailAndPasswordBlocEvent()),
      expect: () => [BlocState.loading(), BlocState.error(LoginBloc.wrongPasswordMessage)],
    );

    blocTest(
      'should expect [LoadingBlocState, ErrorBlocState]',
      build: () => LoginBloc(repository),
      setUp: () => when(() => repository.getLoggedUser()).thenAnswer((_) async => Left(NetworkFailure())),
      act: (LoginBloc bloc) => bloc.add(const LoginWithEmailAndPasswordBlocEvent()),
      expect: () => [BlocState.loading(), BlocState.error(LoginBloc.networkFailureMessage)],
    );

    blocTest(
      'should expect [LoadingBlocState, ErrorBlocState]',
      build: () => LoginBloc(repository),
      setUp: () => when(() => repository.getLoggedUser()).thenAnswer((_) async => Left(ServerFailure())),
      act: (LoginBloc bloc) => bloc.add(const LoginWithEmailAndPasswordBlocEvent()),
      expect: () => [BlocState.loading(), BlocState.error(LoginBloc.serverFailureMessage)],
    );

    blocTest(
      'should expect [LoadingBlocState, ErrorBlocState]',
      build: () => LoginBloc(repository),
      setUp: () => when(() => repository.getLoggedUser()).thenAnswer((_) async => Left(LoginFailure())),
      act: (LoginBloc bloc) => bloc.add(const LoginWithEmailAndPasswordBlocEvent()),
      expect: () => [BlocState.loading(), BlocState.error(LoginBloc.genericFailureMessage)],
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
      build: () => LoginBloc(repository),
      setUp: () => when(() => repository.getLoggedUser()).thenAnswer((_) async => const Right(tAccount)),
      act: (LoginBloc bloc) => bloc.add(const LoginWithEmailAndPasswordBlocEvent()),
      expect: () => [BlocState.loading(), BlocState.success(tAccount)],
    );
  });

  group('LoginWithEmailAndPasswordBlocEvent', () {
    blocTest(
      'should expect [LoadingBlocState, ErrorBlocState]',
      build: () => LoginBloc(repository),
      setUp: () => when(() => repository.getLoggedUser()).thenAnswer((_) async => Left(OperationNotAllowedFailure())),
      act: (LoginBloc bloc) => bloc.add(const LoginWithEmailAndPasswordBlocEvent()),
      expect: () => [BlocState.loading(), BlocState.error(LoginBloc.operationNotAllowedMessage)],
    );

    blocTest(
      'should expect [LoadingBlocState, ErrorBlocState]',
      build: () => LoginBloc(repository),
      setUp: () => when(() => repository.getLoggedUser()).thenAnswer((_) async => Left(UserDisabledFailure())),
      act: (LoginBloc bloc) => bloc.add(const LoginWithEmailAndPasswordBlocEvent()),
      expect: () => [BlocState.loading(), BlocState.error(LoginBloc.userDisabledMessage)],
    );

    blocTest(
      'should expect [LoadingBlocState, ErrorBlocState]',
      build: () => LoginBloc(repository),
      setUp: () => when(() => repository.getLoggedUser()).thenAnswer((_) async => Left(UserNotFoundFailure())),
      act: (LoginBloc bloc) => bloc.add(const LoginWithEmailAndPasswordBlocEvent()),
      expect: () => [BlocState.loading(), BlocState.error(LoginBloc.userNotFoundMessage)],
    );

    blocTest(
      'should expect [LoadingBlocState, ErrorBlocState]',
      build: () => LoginBloc(repository),
      setUp: () => when(() => repository.getLoggedUser()).thenAnswer((_) async => Left(WrongPasswordFailure())),
      act: (LoginBloc bloc) => bloc.add(const LoginWithEmailAndPasswordBlocEvent()),
      expect: () => [BlocState.loading(), BlocState.error(LoginBloc.wrongPasswordMessage)],
    );

    blocTest(
      'should expect [LoadingBlocState, ErrorBlocState]',
      build: () => LoginBloc(repository),
      setUp: () => when(() => repository.getLoggedUser()).thenAnswer((_) async => Left(AccountExistsWithDifferentCredentialFailure())),
      act: (LoginBloc bloc) => bloc.add(const LoginWithEmailAndPasswordBlocEvent()),
      expect: () => [BlocState.loading(), BlocState.error(LoginBloc.accountExistsWithDifferentCredentialMessage)],
    );

    blocTest(
      'should expect [LoadingBlocState, ErrorBlocState]',
      build: () => LoginBloc(repository),
      setUp: () => when(() => repository.getLoggedUser()).thenAnswer((_) async => Left(InvalidCredentialFailure())),
      act: (LoginBloc bloc) => bloc.add(const LoginWithEmailAndPasswordBlocEvent()),
      expect: () => [BlocState.loading(), BlocState.error(LoginBloc.invalidCredentialMessage)],
    );

    blocTest(
      'should expect [LoadingBlocState, ErrorBlocState]',
      build: () => LoginBloc(repository),
      setUp: () => when(() => repository.getLoggedUser()).thenAnswer((_) async => Left(NetworkFailure())),
      act: (LoginBloc bloc) => bloc.add(const LoginWithEmailAndPasswordBlocEvent()),
      expect: () => [BlocState.loading(), BlocState.error(LoginBloc.networkFailureMessage)],
    );

    blocTest(
      'should expect [LoadingBlocState, ErrorBlocState]',
      build: () => LoginBloc(repository),
      setUp: () => when(() => repository.getLoggedUser()).thenAnswer((_) async => Left(ServerFailure())),
      act: (LoginBloc bloc) => bloc.add(const LoginWithEmailAndPasswordBlocEvent()),
      expect: () => [BlocState.loading(), BlocState.error(LoginBloc.serverFailureMessage)],
    );

    blocTest(
      'should expect [LoadingBlocState, ErrorBlocState]',
      build: () => LoginBloc(repository),
      setUp: () => when(() => repository.getLoggedUser()).thenAnswer((_) async => Left(LoginFailure())),
      act: (LoginBloc bloc) => bloc.add(const LoginWithEmailAndPasswordBlocEvent()),
      expect: () => [BlocState.loading(), BlocState.error(LoginBloc.genericFailureMessage)],
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
      build: () => LoginBloc(repository),
      setUp: () => when(() => repository.getLoggedUser()).thenAnswer((_) async => const Right(tAccount)),
      act: (LoginBloc bloc) => bloc.add(const LoginWithEmailAndPasswordBlocEvent()),
      expect: () => [BlocState.loading(), BlocState.success(tAccount)],
    );
  });
}