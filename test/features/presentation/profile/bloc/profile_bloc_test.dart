import 'package:app_amoc_ararangua/core/errors/failures.dart';
import 'package:app_amoc_ararangua/core/states/bloc_state.dart';
import 'package:app_amoc_ararangua/features/domain/entities/account_entity.dart';
import 'package:app_amoc_ararangua/features/domain/repositories/account_repository.dart';
import 'package:app_amoc_ararangua/features/presentation/profile/bloc/events/profile_event_bloc.dart';
import 'package:app_amoc_ararangua/features/presentation/profile/bloc/profile_bloc.dart';
import 'package:app_amoc_ararangua/features/presentation/profile/bloc/save_profile_bloc.dart';
import 'package:app_amoc_ararangua/features/presentation/profile/presenter/mapper/account_entity_mapper.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAccountsRepository extends Mock implements IAccountsRepository {}

class MockSaveProfileBloc extends Mock implements SaveProfileBloc {}

void main() {
  late IAccountsRepository repository;
  late SaveProfileBloc saveUseCase;

  setUp(() {
    repository = MockAccountsRepository();
    saveUseCase = MockSaveProfileBloc();
  });

  group('GetProfileEventBloc', () {
    blocTest(
      'should expect [LoadingBlocState, ErrorBlocState]',
      build: () => ProfileBloc(repository, saveUseCase),
      setUp: () => when(() => repository.getLoggedUser()).thenAnswer((_) async => Left(UserNotFoundFailure())),
      act: (ProfileBloc bloc) => bloc.add(const GetProfileEventBloc()),
      expect: () => [BlocState.loading(), BlocState.error(ProfileBloc.userNotFoundMessage)],
    );

    blocTest(
      'should expect [LoadingBlocState, ErrorBlocState]',
      build: () => ProfileBloc(repository, saveUseCase),
      setUp: () => when(() => repository.getLoggedUser()).thenAnswer((_) async => Left(NetworkFailure())),
      act: (ProfileBloc bloc) => bloc.add(const GetProfileEventBloc()),
      expect: () => [BlocState.loading(), BlocState.error(ProfileBloc.networkFailureMessage)],
    );

    blocTest(
      'should expect [LoadingBlocState, ErrorBlocState]',
      build: () => ProfileBloc(repository, saveUseCase),
      setUp: () => when(() => repository.getLoggedUser()).thenAnswer((_) async => Left(ServerFailure())),
      act: (ProfileBloc bloc) => bloc.add(const GetProfileEventBloc()),
      expect: () => [BlocState.loading(), BlocState.error(ProfileBloc.serverFailureMessage)],
    );

    blocTest(
      'should expect [LoadingBlocState, ErrorBlocState]',
      build: () => ProfileBloc(repository, saveUseCase),
      setUp: () => when(() => repository.getLoggedUser()).thenAnswer((_) async => Left(LoginFailure())),
      act: (ProfileBloc bloc) => bloc.add(const GetProfileEventBloc()),
      expect: () => [BlocState.loading(), BlocState.error(ProfileBloc.genericFailureMessage)],
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
    final presenter = tAccount.toPresenter();

    blocTest(
      'should expect [LoadingBlocState, SuccessBlocState]',
      build: () => ProfileBloc(repository, saveUseCase),
      setUp: () {
        when(() => repository.getLoggedUser()).thenAnswer((_) async => const Right(tAccount));
        when(() => saveUseCase.presenter).thenReturn(presenter);
      },
      act: (ProfileBloc bloc) => bloc.add(const GetProfileEventBloc()),
      expect: () => [BlocState.loading(), BlocState.success(presenter)],
    );
  });

  group('SaveProfileEventBloc', () {
    const event = SaveProfileEventBloc();
    blocTest(
      'should expect [LoadingBlocState]',
      build: () => ProfileBloc(repository, saveUseCase),
      setUp: () => when(() => saveUseCase.add(event)).thenAnswer((_) async => Left(UserNotSavedFailure())),
      act: (ProfileBloc bloc) => bloc.add(event),
      expect: () => [BlocState.loading()],
    );
  });
}