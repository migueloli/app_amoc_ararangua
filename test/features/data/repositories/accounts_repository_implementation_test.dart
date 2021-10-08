import 'package:app_amoc_ararangua/core/errors/exceptions.dart';
import 'package:app_amoc_ararangua/core/errors/failures.dart';
import 'package:app_amoc_ararangua/core/network/network_info.dart';
import 'package:app_amoc_ararangua/features/data/datasources/accounts_remote_datasource.dart';
import 'package:app_amoc_ararangua/features/data/models/account_model.dart';
import 'package:app_amoc_ararangua/features/data/repositories/accounts_repository_implementation.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAccountDatasource extends Mock implements IAccountsRemoteDataSource {}
class MockNetworkInfo extends Mock implements INetworkInfo {}

void main() {

  late AccountsRepositoryImplementation repository;
  late IAccountsRemoteDataSource datasource;
  late INetworkInfo networkInfo;

  setUp(() {
    datasource = MockAccountDatasource();
    networkInfo = MockNetworkInfo();
    repository = AccountsRepositoryImplementation(datasource, networkInfo);
  });

  group(
    'getListOfAccounts',
    () {
      test(
        'should return a list of account models when calls the datasource',
        () async {
          //Arrange
          const tListOfAccounts = [
            AccountModel(
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
              categoryId: '',
            ),
            AccountModel(
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
              categoryId: '',
            ),
          ];
          when(() => networkInfo.isConnected).thenAnswer((_) async => true);
          when(datasource.getListOfAccounts).thenAnswer((_) async => tListOfAccounts);

          //Act
          final result = await repository.getListOfAccounts();

          //Assert
          expect(result, const Right(tListOfAccounts));
          verify(() => networkInfo.isConnected).called(1);
          verify(() => datasource.getListOfAccounts()).called(1);
        }
      );
      test(
        'should return a ServerFailure when call to datasource is unsuccessful',
        () async {
          //Arrange
          when(() => networkInfo.isConnected).thenAnswer((_) async => true);
          when(datasource.getListOfAccounts).thenThrow(ServerException());

          //Act
          final result = await repository.getListOfAccounts();

          //Assert
          expect(result, Left(ServerFailure()));
          verify(() => networkInfo.isConnected).called(1);
          verify(() => datasource.getListOfAccounts()).called(1);
        }
      );

      test(
        'should return a NetworkFailure when call to datasource is unsuccessful',
        () async {
          //Arrange
          when(() => networkInfo.isConnected).thenAnswer((_) async => false);

          //Act
          final result = await repository.getListOfAccounts();

          //Assert
          expect(result, Left(NetworkFailure()));
          verify(() => networkInfo.isConnected).called(1);
          verifyNever(() => datasource.getListOfAccounts());
        }
      );
    }
  );

  group(
    'saveAccount',
    () {
      const tAccount = AccountModel(
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
        categoryId: '',
      );

      test(
        'should return a account model when calls the datasource',
        () async {
          //Arrange
          when(() => networkInfo.isConnected).thenAnswer((_) async => true);
          when(() => datasource.saveAccount(tAccount)).thenAnswer((_) async => tAccount);

          //Act
          final result = await repository.saveAccount(tAccount);

          //Assert
          expect(result, const Right(tAccount));
          verify(() => networkInfo.isConnected).called(1);
          verify(() => datasource.saveAccount(tAccount)).called(1);
        }
      );

      test(
        'should return a ServerFailure when call to datasource is unsuccessful',
        () async {
          //Arrange
          when(() => networkInfo.isConnected).thenAnswer((_) async => true);
          when(() => datasource.saveAccount(tAccount)).thenThrow(ServerException());

          //Act
          final result = await repository.saveAccount(tAccount);

          //Assert
          expect(result, Left(ServerFailure()));
          verify(() => networkInfo.isConnected).called(1);
          verify(() => datasource.saveAccount(tAccount)).called(1);
        }
      );

      test(
        'should return a NetworkFailure when call to datasource is unsuccessful',
        () async {
          //Arrange
          when(() => networkInfo.isConnected).thenAnswer((_) async => false);

          //Act
          final result = await repository.saveAccount(tAccount);

          //Assert
          expect(result, Left(NetworkFailure()));
          verify(() => networkInfo.isConnected).called(1);
          verifyNever(() => datasource.saveAccount(tAccount));
        }
      );
    }
  );

  group(
    'getAccount',
    () {
      const uid = "1";
      const tAccount = AccountModel(
        id: uid,
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

      test(
        'should return a account model when calls the datasource',
        () async {
          //Arrange
          when(() => networkInfo.isConnected).thenAnswer((_) async => true);
          when(() => datasource.getAccount(uid)).thenAnswer((_) async => tAccount);

          //Act
          final result = await repository.getAccount(uid);

          //Assert
          expect(result, const Right(tAccount));
          verify(() => networkInfo.isConnected).called(1);
          verify(() => datasource.getAccount(uid)).called(1);
        }
      );

      test(
        'should return a UserNotFoundFailure when call to datasource is unsuccessful',
        () async {
          //Arrange
          when(() => networkInfo.isConnected).thenAnswer((_) async => true);
          when(() => datasource.getAccount(uid)).thenThrow(UserNotFoundException());

          //Act
          final result = await repository.getAccount(uid);

          //Assert
          expect(result, Left(UserNotFoundFailure()));
          verify(() => networkInfo.isConnected).called(1);
          verify(() => datasource.getAccount(uid)).called(1);
        }
      );

      test(
        'should return a ServerFailure when call to datasource is unsuccessful',
        () async {
          //Arrange
          when(() => networkInfo.isConnected).thenAnswer((_) async => true);
          when(() => datasource.getAccount(uid)).thenThrow(ServerException());

          //Act
          final result = await repository.getAccount(uid);

          //Assert
          expect(result, Left(ServerFailure()));
          verify(() => networkInfo.isConnected).called(1);
          verify(() => datasource.getAccount(uid)).called(1);
        }
      );

      test(
        'should return a NetworkFailure when call to datasource is unsuccessful',
        () async {
          //Arrange
          when(() => networkInfo.isConnected).thenAnswer((_) async => false);

          //Act
          final result = await repository.getAccount(uid);

          //Assert
          expect(result, Left(NetworkFailure()));
          verify(() => networkInfo.isConnected).called(1);
          verifyNever(() => datasource.getAccount(uid));
        }
      );
    }
  );

  group(
    'createAccountWithEmailAndPassword',
    () {
      const email = "test@test.com";
      const password = "123456";
      const tAccount = AccountModel(
        id: "1",
        name: "",
        document: "",
        email: email,
        phone: "",
        zip: "",
        address: "",
        number: "",
        neighborhood: "",
        city: "",
        state: "",
        isWorker: true,
        description: "",
        status: 0,
        cause: "",
        categoryId: '',
      );

      test(
        'should return an AccountEntity when is a successful account creation',
        () async {
          //Arrange
          when(() => networkInfo.isConnected).thenAnswer((_) async => true);
          when(() => datasource.createAccountWithEmailAndPassword(email, password)).thenAnswer((_) async => tAccount);

          //Act
          final result = await repository.createAccountWithEmailAndPassword(email, password);

          //Assert
          expect(result, const Right(tAccount));
          verify(() => networkInfo.isConnected).called(1);
          verify(() => datasource.createAccountWithEmailAndPassword(email, password)).called(1);
        }
      );

      test(
        'should return a NetworkFailure when network is disconnected',
        () async {
          //Arrange
          when(() => networkInfo.isConnected).thenAnswer((_) async => false);

          //Act
          final result = await repository.createAccountWithEmailAndPassword(email, password);

          //Assert
          expect(result, Left(NetworkFailure()));
          verify(() => networkInfo.isConnected).called(1);
          verifyNever(() => datasource.createAccountWithEmailAndPassword(email, password));
        }
      );

      test(
        'should return a EmailAlreadyInUseFailure when call to datasource throws an WeakPasswordException',
        () async {
          //Arrange
          when(() => networkInfo.isConnected).thenAnswer((_) async => true);
          when(() => datasource.createAccountWithEmailAndPassword(email, password)).thenThrow(EmailAlreadyInUseException());

          //Act
          final result = await repository.createAccountWithEmailAndPassword(email, password);

          //Assert
          expect(result, Left(EmailAlreadyInUseFailure()));
          verify(() => networkInfo.isConnected).called(1);
          verify(() => datasource.createAccountWithEmailAndPassword(email, password)).called(1);
        }
      );

      test(
        'should return a WeakPasswordFailure when call to datasource throws an WeakPasswordException',
        () async {
          //Arrange
          when(() => networkInfo.isConnected).thenAnswer((_) async => true);
          when(() => datasource.createAccountWithEmailAndPassword(email, password)).thenThrow(WeakPasswordException());

          //Act
          final result = await repository.createAccountWithEmailAndPassword(email, password);

          //Assert
          expect(result, Left(WeakPasswordFailure()));
          verify(() => networkInfo.isConnected).called(1);
          verify(() => datasource.createAccountWithEmailAndPassword(email, password)).called(1);
        }
      );

      test(
        'should return a InvalidEmailFailure when call to datasource throws an InvalidEmailException',
        () async {
          //Arrange
          when(() => networkInfo.isConnected).thenAnswer((_) async => true);
          when(() => datasource.createAccountWithEmailAndPassword(email, password)).thenThrow(InvalidEmailException());

          //Act
          final result = await repository.createAccountWithEmailAndPassword(email, password);

          //Assert
          expect(result, Left(InvalidEmailFailure()));
          verify(() => networkInfo.isConnected).called(1);
          verify(() => datasource.createAccountWithEmailAndPassword(email, password)).called(1);
        }
      );

      test(
        'should return a OperationNotAllowedFailure when call to datasource throws an OperationNotAllowedException',
        () async {
          //Arrange
          when(() => networkInfo.isConnected).thenAnswer((_) async => true);
          when(() => datasource.createAccountWithEmailAndPassword(email, password)).thenThrow(OperationNotAllowedException());

          //Act
          final result = await repository.createAccountWithEmailAndPassword(email, password);

          //Assert
          expect(result, Left(OperationNotAllowedFailure()));
          verify(() => networkInfo.isConnected).called(1);
          verify(() => datasource.createAccountWithEmailAndPassword(email, password)).called(1);
        }
      );

      test(
        'should return a LoginFailure when call to datasource throws an LoginException',
        () async {
          //Arrange
          when(() => networkInfo.isConnected).thenAnswer((_) async => true);
          when(() => datasource.createAccountWithEmailAndPassword(email, password)).thenThrow(LoginException());

          //Act
          final result = await repository.createAccountWithEmailAndPassword(email, password);

          //Assert
          expect(result, Left(LoginFailure()));
          verify(() => networkInfo.isConnected).called(1);
          verify(() => datasource.createAccountWithEmailAndPassword(email, password)).called(1);
        }
      );

      test(
        'should return a ServerFailure when call to datasource is unsuccessful with unknown error',
        () async {
          //Arrange
          when(() => networkInfo.isConnected).thenAnswer((_) async => true);
          when(() => datasource.createAccountWithEmailAndPassword(email, password)).thenThrow(ServerException());

          //Act
          final result = await repository.createAccountWithEmailAndPassword(email, password);

          //Assert
          expect(result, Left(ServerFailure()));
          verify(() => networkInfo.isConnected).called(1);
          verify(() => datasource.createAccountWithEmailAndPassword(email, password)).called(1);
        }
      );
    }
  );

  group(
    'loginWithEmailAndPassword',
    () {
      const email = "test@test.com";
      const password = "123456";
      const tAccount = AccountModel(
        id: "1",
        name: "",
        document: "",
        email: email,
        phone: "",
        zip: "",
        address: "",
        number: "",
        neighborhood: "",
        city: "",
        state: "",
        isWorker: true,
        description: "",
        status: 0,
        cause: "",
        categoryId: '',
      );

      test(
        'should return an AccountEntity when is a successful login',
        () async {
          //Arrange
          when(() => networkInfo.isConnected).thenAnswer((_) async => true);
          when(() => datasource.loginWithEmailAndPassword(email, password)).thenAnswer((_) async => tAccount);

          //Act
          final result = await repository.loginWithEmailAndPassword(email, password);

          //Assert
          expect(result, const Right(tAccount));
          verify(() => networkInfo.isConnected).called(1);
          verify(() => datasource.loginWithEmailAndPassword(email, password)).called(1);
        }
      );

      test(
        'should return a NetworkFailure when network is disconnected',
        () async {
          //Arrange
          when(() => networkInfo.isConnected).thenAnswer((_) async => false);

          //Act
          final result = await repository.loginWithEmailAndPassword(email, password);

          //Assert
          expect(result, Left(NetworkFailure()));
          verify(() => networkInfo.isConnected).called(1);
          verifyNever(() => datasource.loginWithEmailAndPassword(email, password));
        }
      );

      test(
        'should return a InvalidEmailFailure when call to datasource throws an InvalidEmailException',
        () async {
          //Arrange
          when(() => networkInfo.isConnected).thenAnswer((_) async => true);
          when(() => datasource.loginWithEmailAndPassword(email, password)).thenThrow(InvalidEmailException());

          //Act
          final result = await repository.loginWithEmailAndPassword(email, password);

          //Assert
          expect(result, Left(InvalidEmailFailure()));
          verify(() => networkInfo.isConnected).called(1);
          verify(() => datasource.loginWithEmailAndPassword(email, password)).called(1);
        }
      );

      test(
        'should return a UserDisabledFailure when call to datasource throws an UserDisabledException',
        () async {
          //Arrange
          when(() => networkInfo.isConnected).thenAnswer((_) async => true);
          when(() => datasource.loginWithEmailAndPassword(email, password)).thenThrow(UserDisabledException());

          //Act
          final result = await repository.loginWithEmailAndPassword(email, password);

          //Assert
          expect(result, Left(UserDisabledFailure()));
          verify(() => networkInfo.isConnected).called(1);
          verify(() => datasource.loginWithEmailAndPassword(email, password)).called(1);
        }
      );

      test(
        'should return a UserNotFoundFailure when call to datasource throws an UserNotFoundException',
        () async {
          //Arrange
          when(() => networkInfo.isConnected).thenAnswer((_) async => true);
          when(() => datasource.loginWithEmailAndPassword(email, password)).thenThrow(UserNotFoundException());

          //Act
          final result = await repository.loginWithEmailAndPassword(email, password);

          //Assert
          expect(result, Left(UserNotFoundFailure()));
          verify(() => networkInfo.isConnected).called(1);
          verify(() => datasource.loginWithEmailAndPassword(email, password)).called(1);
        }
      );

      test(
        'should return a WrongPasswordFailure when call to datasource throws an WrongPasswordException',
        () async {
          //Arrange
          when(() => networkInfo.isConnected).thenAnswer((_) async => true);
          when(() => datasource.loginWithEmailAndPassword(email, password)).thenThrow(WrongPasswordException());

          //Act
          final result = await repository.loginWithEmailAndPassword(email, password);

          //Assert
          expect(result, Left(WrongPasswordFailure()));
          verify(() => networkInfo.isConnected).called(1);
          verify(() => datasource.loginWithEmailAndPassword(email, password)).called(1);
        }
      );

      test(
        'should return a LoginFailure when call to datasource throws an LoginException',
        () async {
          //Arrange
          when(() => networkInfo.isConnected).thenAnswer((_) async => true);
          when(() => datasource.loginWithEmailAndPassword(email, password)).thenThrow(LoginException());

          //Act
          final result = await repository.loginWithEmailAndPassword(email, password);

          //Assert
          expect(result, Left(LoginFailure()));
          verify(() => networkInfo.isConnected).called(1);
          verify(() => datasource.loginWithEmailAndPassword(email, password)).called(1);
        }
      );

      test(
        'should return a ServerFailure when call to datasource is unsuccessful with unknown error',
        () async {
          //Arrange
          when(() => networkInfo.isConnected).thenAnswer((_) async => true);
          when(() => datasource.loginWithEmailAndPassword(email, password)).thenThrow(ServerException());

          //Act
          final result = await repository.loginWithEmailAndPassword(email, password);

          //Assert
          expect(result, Left(ServerFailure()));
          verify(() => networkInfo.isConnected).called(1);
          verify(() => datasource.loginWithEmailAndPassword(email, password)).called(1);
        }
      );
    }
  );

  group(
    'loginWithGoogle',
    () {
      const tAccount = AccountModel(
        id: "1",
        name: "",
        document: "",
        email: "",
        phone: "",
        zip: "",
        address: "",
        number: "",
        neighborhood: "",
        city: "",
        state: "",
        isWorker: true,
        description: "",
        status: 0,
        cause: "",
        categoryId: '',
      );

      test(
        'should return an AccountEntity when is a successful login',
        () async {
          //Arrange
          when(() => networkInfo.isConnected).thenAnswer((_) async => true);
          when(() => datasource.loginWithGoogle()).thenAnswer((_) async => tAccount);

          //Act
          final result = await repository.loginWithGoogle();

          //Assert
          expect(result, const Right(tAccount));
          verify(() => networkInfo.isConnected).called(1);
          verify(() => datasource.loginWithGoogle()).called(1);
        }
      );

      test(
        'should return a NetworkFailure when network is disconnected',
        () async {
          //Arrange
          when(() => networkInfo.isConnected).thenAnswer((_) async => false);

          //Act
          final result = await repository.loginWithGoogle();

          //Assert
          expect(result, Left(NetworkFailure()));
          verify(() => networkInfo.isConnected).called(1);
          verifyNever(() => datasource.loginWithGoogle());
        }
      );

      test(
        'should return a OperationNotAllowedFailure when call to datasource throws an OperationNotAllowedException',
        () async {
          //Arrange
          when(() => networkInfo.isConnected).thenAnswer((_) async => true);
          when(() => datasource.loginWithGoogle()).thenThrow(OperationNotAllowedException());

          //Act
          final result = await repository.loginWithGoogle();

          //Assert
          expect(result, Left(OperationNotAllowedFailure()));
          verify(() => networkInfo.isConnected).called(1);
          verify(() => datasource.loginWithGoogle()).called(1);
        }
      );

      test(
        'should return a UserDisabledFailure when call to datasource throws an UserDisabledException',
        () async {
          //Arrange
          when(() => networkInfo.isConnected).thenAnswer((_) async => true);
          when(() => datasource.loginWithGoogle()).thenThrow(UserDisabledException());

          //Act
          final result = await repository.loginWithGoogle();

          //Assert
          expect(result, Left(UserDisabledFailure()));
          verify(() => networkInfo.isConnected).called(1);
          verify(() => datasource.loginWithGoogle()).called(1);
        }
      );

      test(
        'should return a UserNotFoundFailure when call to datasource throws an UserNotFoundException',
        () async {
          //Arrange
          when(() => networkInfo.isConnected).thenAnswer((_) async => true);
          when(() => datasource.loginWithGoogle()).thenThrow(UserNotFoundException());

          //Act
          final result = await repository.loginWithGoogle();

          //Assert
          expect(result, Left(UserNotFoundFailure()));
          verify(() => networkInfo.isConnected).called(1);
          verify(() => datasource.loginWithGoogle()).called(1);
        }
      );

      test(
        'should return a WrongPasswordFailure when call to datasource throws an WrongPasswordException',
        () async {
          //Arrange
          when(() => networkInfo.isConnected).thenAnswer((_) async => true);
          when(() => datasource.loginWithGoogle()).thenThrow(WrongPasswordException());

          //Act
          final result = await repository.loginWithGoogle();

          //Assert
          expect(result, Left(WrongPasswordFailure()));
          verify(() => networkInfo.isConnected).called(1);
          verify(() => datasource.loginWithGoogle()).called(1);
        }
      );

      test(
        'should return a AccountExistsWithDifferentCredentialFailure when call to datasource throws an AccountExistsWithDifferentCredentialException',
        () async {
          //Arrange
          when(() => networkInfo.isConnected).thenAnswer((_) async => true);
          when(() => datasource.loginWithGoogle()).thenThrow(AccountExistsWithDifferentCredentialException());

          //Act
          final result = await repository.loginWithGoogle();

          //Assert
          expect(result, Left(AccountExistsWithDifferentCredentialFailure()));
          verify(() => networkInfo.isConnected).called(1);
          verify(() => datasource.loginWithGoogle()).called(1);
        }
      );

      test(
        'should return a InvalidCredentialFailure when call to datasource throws an InvalidCredentialException',
        () async {
          //Arrange
          when(() => networkInfo.isConnected).thenAnswer((_) async => true);
          when(() => datasource.loginWithGoogle()).thenThrow(InvalidCredentialException());

          //Act
          final result = await repository.loginWithGoogle();

          //Assert
          expect(result, Left(InvalidCredentialFailure()));
          verify(() => networkInfo.isConnected).called(1);
          verify(() => datasource.loginWithGoogle()).called(1);
        }
      );

      test(
        'should return a InvalidVerificationCodeFailure when call to datasource throws an InvalidVerificationCodeException',
        () async {
          //Arrange
          when(() => networkInfo.isConnected).thenAnswer((_) async => true);
          when(() => datasource.loginWithGoogle()).thenThrow(InvalidVerificationCodeException());

          //Act
          final result = await repository.loginWithGoogle();

          //Assert
          expect(result, Left(InvalidVerificationCodeFailure()));
          verify(() => networkInfo.isConnected).called(1);
          verify(() => datasource.loginWithGoogle()).called(1);
        }
      );

      test(
        'should return a InvalidVerificationIdFailure when call to datasource throws an InvalidVerificationIdException',
        () async {
          //Arrange
          when(() => networkInfo.isConnected).thenAnswer((_) async => true);
          when(() => datasource.loginWithGoogle()).thenThrow(InvalidVerificationIdException());

          //Act
          final result = await repository.loginWithGoogle();

          //Assert
          expect(result, Left(InvalidVerificationIdFailure()));
          verify(() => networkInfo.isConnected).called(1);
          verify(() => datasource.loginWithGoogle()).called(1);
        }
      );

      test(
        'should return a LoginFailure when call to datasource throws an LoginException',
        () async {
          //Arrange
          when(() => networkInfo.isConnected).thenAnswer((_) async => true);
          when(() => datasource.loginWithGoogle()).thenThrow(LoginException());

          //Act
          final result = await repository.loginWithGoogle();

          //Assert
          expect(result, Left(LoginFailure()));
          verify(() => networkInfo.isConnected).called(1);
          verify(() => datasource.loginWithGoogle()).called(1);
        }
      );

      test(
        'should return a ServerFailure when call to datasource is unsuccessful with unknown error',
        () async {
          //Arrange
          when(() => networkInfo.isConnected).thenAnswer((_) async => true);
          when(() => datasource.loginWithGoogle()).thenThrow(ServerException());

          //Act
          final result = await repository.loginWithGoogle();

          //Assert
          expect(result, Left(ServerFailure()));
          verify(() => networkInfo.isConnected).called(1);
          verify(() => datasource.loginWithGoogle()).called(1);
        }
      );
    }
  );

  group(
    'getLoggedUser',
    () {
      const tAccount = AccountModel(
        id: "1",
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

      test(
        'should return a account model when calls the datasource',
        () async {
          //Arrange
          when(() => networkInfo.isConnected).thenAnswer((_) async => true);
          when(() => datasource.getLoggedUser()).thenAnswer((_) async => tAccount);

          //Act
          final result = await repository.getLoggedUser();

          //Assert
          expect(result, const Right(tAccount));
          verify(() => networkInfo.isConnected).called(1);
          verify(() => datasource.getLoggedUser()).called(1);
        }
      );

      test(
        'should return a UserNotFoundFailure when call to datasource is unsuccessful',
        () async {
          //Arrange
          when(() => networkInfo.isConnected).thenAnswer((_) async => true);
          when(() => datasource.getLoggedUser()).thenThrow(UserNotFoundException());

          //Act
          final result = await repository.getLoggedUser();

          //Assert
          expect(result, Left(UserNotFoundFailure()));
          verify(() => networkInfo.isConnected).called(1);
          verify(() => datasource.getLoggedUser()).called(1);
        }
      );

      test(
        'should return a NetworkFailure when call to datasource is unsuccessful',
        () async {
          //Arrange
          when(() => networkInfo.isConnected).thenAnswer((_) async => false);

          //Act
          final result = await repository.getLoggedUser();

          //Assert
          expect(result, Left(NetworkFailure()));
          verify(() => networkInfo.isConnected).called(1);
          verifyNever(() => datasource.getLoggedUser());
        }
      );
    }
  );
}
