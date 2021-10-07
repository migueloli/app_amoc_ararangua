import 'package:app_amoc_ararangua/core/errors/failures.dart';
import 'package:app_amoc_ararangua/core/states/bloc_state.dart';
import 'package:app_amoc_ararangua/features/domain/entities/account_entity.dart';
import 'package:app_amoc_ararangua/features/domain/repositories/account_repository.dart';
import 'package:app_amoc_ararangua/features/presentation/create_account/bloc/create_account_bloc.dart';
import 'package:app_amoc_ararangua/features/presentation/create_account/bloc/event/create_account_bloc_event.dart';
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
      build: () => CreateAccountBloc(repository),
      setUp: () => when(() => repository.getLoggedUser()).thenAnswer((_) async => Left(EmailAlreadyInUseFailure())),
      act: (CreateAccountBloc bloc) => bloc.add(const CreateAccountWithEmailAndPasswordEvent()),
      expect: () => [BlocState.loading(), BlocState.error(CreateAccountBloc.emailAlreadyInUseMessage)],
    );

    blocTest(
      'should expect [LoadingBlocState, ErrorBlocState]',
      build: () => CreateAccountBloc(repository),
      setUp: () => when(() => repository.getLoggedUser()).thenAnswer((_) async => Left(WeakPasswordFailure())),
      act: (CreateAccountBloc bloc) => bloc.add(const CreateAccountWithEmailAndPasswordEvent()),
      expect: () => [BlocState.loading(), BlocState.error(CreateAccountBloc.weakPasswordMessage)],
    );

    blocTest(
      'should expect [LoadingBlocState, ErrorBlocState]',
      build: () => CreateAccountBloc(repository),
      setUp: () => when(() => repository.getLoggedUser()).thenAnswer((_) async => Left(InvalidEmailFailure())),
      act: (CreateAccountBloc bloc) => bloc.add(const CreateAccountWithEmailAndPasswordEvent()),
      expect: () => [BlocState.loading(), BlocState.error(CreateAccountBloc.invalidEmailMessage)],
    );

    blocTest(
      'should expect [LoadingBlocState, ErrorBlocState]',
      build: () => CreateAccountBloc(repository),
      setUp: () => when(() => repository.getLoggedUser()).thenAnswer((_) async => Left(OperationNotAllowedFailure())),
      act: (CreateAccountBloc bloc) => bloc.add(const CreateAccountWithEmailAndPasswordEvent()),
      expect: () => [BlocState.loading(), BlocState.error(CreateAccountBloc.operationNotAllowedMessage)],
    );

    blocTest(
      'should expect [LoadingBlocState, ErrorBlocState]',
      build: () => CreateAccountBloc(repository),
      setUp: () => when(() => repository.getLoggedUser()).thenAnswer((_) async => Left(NetworkFailure())),
      act: (CreateAccountBloc bloc) => bloc.add(const CreateAccountWithEmailAndPasswordEvent()),
      expect: () => [BlocState.loading(), BlocState.error(CreateAccountBloc.networkFailureMessage)],
    );

    blocTest(
      'should expect [LoadingBlocState, ErrorBlocState]',
      build: () => CreateAccountBloc(repository),
      setUp: () => when(() => repository.getLoggedUser()).thenAnswer((_) async => Left(ServerFailure())),
      act: (CreateAccountBloc bloc) => bloc.add(const CreateAccountWithEmailAndPasswordEvent()),
      expect: () => [BlocState.loading(), BlocState.error(CreateAccountBloc.serverFailureMessage)],
    );

    blocTest(
      'should expect [LoadingBlocState, ErrorBlocState]',
      build: () => CreateAccountBloc(repository),
      setUp: () => when(() => repository.getLoggedUser()).thenAnswer((_) async => Left(LoginFailure())),
      act: (CreateAccountBloc bloc) => bloc.add(const CreateAccountWithEmailAndPasswordEvent()),
      expect: () => [BlocState.loading(), BlocState.error(CreateAccountBloc.genericFailureMessage)],
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
      build: () => CreateAccountBloc(repository),
      setUp: () => when(() => repository.getLoggedUser()).thenAnswer((_) async => const Right(tAccount)),
      act: (CreateAccountBloc bloc) => bloc.add(const CreateAccountWithEmailAndPasswordEvent()),
      expect: () => [BlocState.loading(), BlocState.success(tAccount)],
    );
  });

  group('CreateAccountWithGoogleEvent', () {
    blocTest(
      'should expect [LoadingBlocState, ErrorBlocState]',
      build: () => CreateAccountBloc(repository),
      setUp: () => when(() => repository.getLoggedUser()).thenAnswer((_) async => Left(OperationNotAllowedFailure())),
      act: (CreateAccountBloc bloc) => bloc.add(const CreateAccountWithGoogleEvent()),
      expect: () => [BlocState.loading(), BlocState.error(CreateAccountBloc.operationNotAllowedMessage)],
    );

    blocTest(
      'should expect [LoadingBlocState, ErrorBlocState]',
      build: () => CreateAccountBloc(repository),
      setUp: () => when(() => repository.getLoggedUser()).thenAnswer((_) async => Left(UserDisabledFailure())),
      act: (CreateAccountBloc bloc) => bloc.add(const CreateAccountWithGoogleEvent()),
      expect: () => [BlocState.loading(), BlocState.error(CreateAccountBloc.userDisabledMessage)],
    );

    blocTest(
      'should expect [LoadingBlocState, ErrorBlocState]',
      build: () => CreateAccountBloc(repository),
      setUp: () => when(() => repository.getLoggedUser()).thenAnswer((_) async => Left(UserNotFoundFailure())),
      act: (CreateAccountBloc bloc) => bloc.add(const CreateAccountWithGoogleEvent()),
      expect: () => [BlocState.loading(), BlocState.error(CreateAccountBloc.userNotFoundMessage)],
    );

    blocTest(
      'should expect [LoadingBlocState, ErrorBlocState]',
      build: () => CreateAccountBloc(repository),
      setUp: () => when(() => repository.getLoggedUser()).thenAnswer((_) async => Left(WrongPasswordFailure())),
      act: (CreateAccountBloc bloc) => bloc.add(const CreateAccountWithGoogleEvent()),
      expect: () => [BlocState.loading(), BlocState.error(CreateAccountBloc.wrongPasswordMessage)],
    );

    blocTest(
      'should expect [LoadingBlocState, ErrorBlocState]',
      build: () => CreateAccountBloc(repository),
      setUp: () => when(() => repository.getLoggedUser()).thenAnswer((_) async => Left(InvalidCredentialFailure())),
      act: (CreateAccountBloc bloc) => bloc.add(const CreateAccountWithGoogleEvent()),
      expect: () => [BlocState.loading(), BlocState.error(CreateAccountBloc.invalidCredentialMessage)],
    );

    blocTest(
      'should expect [LoadingBlocState, ErrorBlocState]',
      build: () => CreateAccountBloc(repository),
      setUp: () => when(() => repository.getLoggedUser()).thenAnswer((_) async => Left(AccountExistsWithDifferentCredentialFailure())),
      act: (CreateAccountBloc bloc) => bloc.add(const CreateAccountWithGoogleEvent()),
      expect: () => [BlocState.loading(), BlocState.error(CreateAccountBloc.accountExistsWithDifferentCredentialMessage)],
    );

    blocTest(
      'should expect [LoadingBlocState, ErrorBlocState]',
      build: () => CreateAccountBloc(repository),
      setUp: () => when(() => repository.getLoggedUser()).thenAnswer((_) async => Left(NetworkFailure())),
      act: (CreateAccountBloc bloc) => bloc.add(const CreateAccountWithGoogleEvent()),
      expect: () => [BlocState.loading(), BlocState.error(CreateAccountBloc.networkFailureMessage)],
    );

    blocTest(
      'should expect [LoadingBlocState, ErrorBlocState]',
      build: () => CreateAccountBloc(repository),
      setUp: () => when(() => repository.getLoggedUser()).thenAnswer((_) async => Left(ServerFailure())),
      act: (CreateAccountBloc bloc) => bloc.add(const CreateAccountWithGoogleEvent()),
      expect: () => [BlocState.loading(), BlocState.error(CreateAccountBloc.serverFailureMessage)],
    );

    blocTest(
      'should expect [LoadingBlocState, ErrorBlocState]',
      build: () => CreateAccountBloc(repository),
      setUp: () => when(() => repository.getLoggedUser()).thenAnswer((_) async => Left(LoginFailure())),
      act: (CreateAccountBloc bloc) => bloc.add(const CreateAccountWithGoogleEvent()),
      expect: () => [BlocState.loading(), BlocState.error(CreateAccountBloc.genericFailureMessage)],
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
      build: () => CreateAccountBloc(repository),
      setUp: () => when(() => repository.getLoggedUser()).thenAnswer((_) async => const Right(tAccount)),
      act: (CreateAccountBloc bloc) => bloc.add(const CreateAccountWithGoogleEvent()),
      expect: () => [BlocState.loading(), BlocState.success(tAccount)],
    );
  });
}