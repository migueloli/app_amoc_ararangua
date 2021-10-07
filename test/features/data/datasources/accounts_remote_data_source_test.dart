import 'package:app_amoc_ararangua/core/errors/exceptions.dart';
import 'package:app_amoc_ararangua/features/data/datasources/accounts_remote_datasource_implementation.dart';
import 'package:app_amoc_ararangua/features/data/models/account_model.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mocktail/mocktail.dart';

mixin LegacyEquality {
  @override
  bool operator ==(dynamic other) => true;

  @override
  int get hashCode => 0;
}

class CustomMockFirebaseAuth extends Mock implements FirebaseAuth {}
class MockUserCredential extends Mock implements UserCredential {}
class MockUser extends Mock implements User {}
class CustomMockGoogleSignIn extends Mock implements GoogleSignIn {}
class MockGoogleSignInAccount extends Mock with LegacyEquality implements GoogleSignInAccount {}
class MockGoogleSignInAuthentication extends Mock implements GoogleSignInAuthentication {}

void main() {
  late AccountsRemoteDataSourceImplementation dataSource;
  late FakeFirebaseFirestore mockFirebaseStore;
  late CustomMockFirebaseAuth mockFirebaseAuth;
  late GoogleSignIn mockGoogleSignIn;

  setUp(() {
    mockFirebaseStore = FakeFirebaseFirestore();
    mockFirebaseAuth = CustomMockFirebaseAuth();
    mockGoogleSignIn = CustomMockGoogleSignIn();
    dataSource = AccountsRemoteDataSourceImplementation(mockFirebaseStore, mockFirebaseAuth, mockGoogleSignIn);
  });

  group(
    'getListOfAccounts',
    () {
      const tListOfAccounts = [
        AccountModel(
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
          status: 1,
          cause: "Test 1",
          categoryId: '',
        ),
        AccountModel(
          id: "2",
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
          isWorker: true,
          description: "Test 2",
          status: 1,
          cause: "Test 2",
          categoryId: '',
        ),
      ];

      test(
        'should return an List<AccountModel>',
        () async {
          //Arrange
          for(final tAccount in tListOfAccounts) {
            final response = await mockFirebaseStore.collection('users').doc(tAccount.id).get();
            await response.reference.set(tAccount.toJson());
          }

          //Act
          final result = await dataSource.getListOfAccounts();

          //Assert
          expect(result, tListOfAccounts);
        }
      );
    }
  );

  group(
    'saveAccount',
    () {
      const tAccount = AccountModel(
        id: "1",
        name: "Test",
        document: "123",
        email: "test@test.com",
        phone: "123456",
        zip: "123456",
        address: "Test",
        number: "123",
        neighborhood: "Test",
        city: "Test",
        state: "Test",
        isWorker: true,
        description: "Test",
        status: 0,
        cause: "Test",
        categoryId: '',
      );

      test(
        'when Account does not exist should create and return an AccountModel',
        () async {
          // Arrange
          final user = MockUser();
          when(() => mockFirebaseAuth.currentUser)
            .thenReturn(user);
          when(() => user.uid).thenReturn('1');
          //Act
          final result = await dataSource.saveAccount(tAccount);
          //Assert
          expect(result, tAccount);
        }
      );

      test(
        'when Account exists should update and return an AccountModel',
        () async {
          // Arrange
          final user = MockUser();
          final response = await mockFirebaseStore.collection('users').doc(tAccount.id).get();
          await response.reference.set(tAccount.toJson());
          when(() => mockFirebaseAuth.currentUser)
            .thenReturn(user);
          when(() => user.uid).thenReturn('1');
          //Act
          final result = await dataSource.saveAccount(tAccount);
          //Assert
          expect(result, tAccount);
        }
      );

      test(
        'when a failure happen should return ServerException',
        () async {
          //Act
          final result = dataSource.saveAccount(tAccount);
          //Assert
          expect(result, throwsA(ServerException()));
        }
      );
    }
  );

  group(
    'getAccount',
    () {
      const tAccount = AccountModel(
        id: "1",
        name: "Test",
        document: "123",
        email: "test@test.com",
        phone: "123456",
        zip: "123456",
        address: "Test",
        number: "123",
        neighborhood: "Test",
        city: "Test",
        state: "Test",
        isWorker: true,
        description: "Test",
        status: 0,
        cause: "Test",
        categoryId: '',
      );

      test(
        'should return an AccountModel for the given id',
        () async {
          //Arrange
          final response = await mockFirebaseStore.collection('users').doc(tAccount.id).get();
          await response.reference.set(tAccount.toJson());

          //Act
          final result = await dataSource.getAccount("1");

          //Assert
          expect(result, tAccount);
        }
      );

      test(
        'should throw an UserNotFoundException when the user does not exist',
        () async {
          //Act
          final result = dataSource.getAccount("1");

          //Assert
          expect(result, throwsA(UserNotFoundException()));
        }
      );
    }
  );

  group(
    'createAccountWithEmailAndPassword',
    () {
      const email = "test@test.com";
      const password = "123456";
      final userCredential = MockUserCredential();
      final user = MockUser();

      test(
        'should return a created AccountModel',
        () async {
          //Arrange
          when(() => mockFirebaseAuth.createUserWithEmailAndPassword(email: email, password: password))
            .thenAnswer((_) async => userCredential);
          when(() => userCredential.user).thenReturn(user);
          when(() => mockFirebaseAuth.currentUser).thenReturn(user);
          when(() => user.uid).thenReturn('1');
          when(() => user.sendEmailVerification()).thenAnswer((_) async {});

          //Act
          final result = await dataSource.createAccountWithEmailAndPassword(email, password);

          //Assert
          expect(result, isA<AccountModel>());
          verify(() => mockFirebaseAuth.createUserWithEmailAndPassword(email: email, password: password)).called(1);
          verify(() => userCredential.user).called(1);
          verify(() => mockFirebaseAuth.currentUser).called(1);
          verify(() => user.uid).called(2);
          verify(() => user.sendEmailVerification()).called(1);
        }
      );

      test(
        'should throw an EmailAlreadyInUseException when trying to create user',
        () async {
          //Arrange
          when(() => mockFirebaseAuth.createUserWithEmailAndPassword(email: email, password: password))
            .thenThrow(FirebaseAuthException(code: 'email-already-in-use'));

          //Act
          final result = dataSource.createAccountWithEmailAndPassword(email, password);

          //Assert
          expect(result, throwsA(EmailAlreadyInUseException()));
          verify(() => mockFirebaseAuth.createUserWithEmailAndPassword(email: email, password: password)).called(1);
        }
      );

      test(
        'should throw an WeakPasswordException when trying to create user',
        () async {
          //Arrange
          when(() => mockFirebaseAuth.createUserWithEmailAndPassword(email: email, password: password))
            .thenThrow(FirebaseAuthException(code: 'weak-password'));

          //Act
          final result = dataSource.createAccountWithEmailAndPassword(email, password);

          //Assert
          expect(result, throwsA(WeakPasswordException()));
          verify(() => mockFirebaseAuth.createUserWithEmailAndPassword(email: email, password: password)).called(1);
        }
      );

      test(
        'should throw an InvalidEmailException when trying to create user',
        () async {
          //Arrange
          when(() => mockFirebaseAuth.createUserWithEmailAndPassword(email: email, password: password))
            .thenThrow(FirebaseAuthException(code: 'invalid-email'));

          //Act
          final result = dataSource.createAccountWithEmailAndPassword(email, password);

          //Assert
          expect(result, throwsA(InvalidEmailException()));
          verify(() => mockFirebaseAuth.createUserWithEmailAndPassword(email: email, password: password)).called(1);
        }
      );

      test(
        'should throw an OperationNotAllowedException when trying to create user',
        () async {
          //Arrange
          when(() => mockFirebaseAuth.createUserWithEmailAndPassword(email: email, password: password))
            .thenThrow(FirebaseAuthException(code: 'operation-not-allowed'));

          //Act
          final result = dataSource.createAccountWithEmailAndPassword(email, password);

          //Assert
          expect(result, throwsA(OperationNotAllowedException()));
          verify(() => mockFirebaseAuth.createUserWithEmailAndPassword(email: email, password: password)).called(1);
        }
      );

      test(
        'should throw an LoginException when trying to create user',
        () async {
          //Arrange
          when(() => mockFirebaseAuth.createUserWithEmailAndPassword(email: email, password: password))
            .thenThrow(Exception());

          //Act
          final result = dataSource.createAccountWithEmailAndPassword(email, password);

          //Assert
          expect(result, throwsA(LoginException()));
          verify(() => mockFirebaseAuth.createUserWithEmailAndPassword(email: email, password: password)).called(1);
          verifyNever(() => mockFirebaseAuth.signInWithEmailAndPassword(email: email, password: password));
        }
      );
    }
  );

  group(
    'loginWithEmailAndPassword',
    () {
      const email = "test@test.com";
      const password = "123456";
      final userCredential = MockUserCredential();
      final user = MockUser();
      const tAccount = AccountModel(
        id: "1",
        name: "Test",
        document: "123",
        email: "test@test.com",
        phone: "123456",
        zip: "123456",
        address: "Test",
        number: "123",
        neighborhood: "Test",
        city: "Test",
        state: "Test",
        isWorker: true,
        description: "Test",
        status: 0,
        cause: "Test",
        categoryId: '',
      );

      test(
        'should return an existent AccountModel with email not verified',
        () async {
          //Arrange
          final response = await mockFirebaseStore.collection('users').doc(tAccount.id).get();
          await response.reference.set(tAccount.toJson());

          when(() => mockFirebaseAuth.signInWithEmailAndPassword(email: email, password: password))
            .thenAnswer((_) async => userCredential);
          when(() => userCredential.user).thenReturn(user);
          when(() => user.uid).thenReturn('1');
          when(() => user.emailVerified).thenReturn(false);
          when(() => user.sendEmailVerification()).thenAnswer((_) async {});

          //Act
          final result = await dataSource.loginWithEmailAndPassword(email, password);

          //Assert
          expect(result, isA<AccountModel>());
          verify(() => mockFirebaseAuth.signInWithEmailAndPassword(email: email, password: password)).called(1);
          verify(() => userCredential.user).called(1);
          verify(() => user.uid).called(1);
          verify(() => user.emailVerified).called(1);
          verify(() => user.sendEmailVerification()).called(1);
        }
      );

      test(
        'should return an existent AccountModel with email verified',
        () async {
          //Arrange
          final response = await mockFirebaseStore.collection('users').doc(tAccount.id).get();
          await response.reference.set(tAccount.toJson());

          when(() => mockFirebaseAuth.signInWithEmailAndPassword(email: email, password: password))
            .thenAnswer((_) async => userCredential);
          when(() => userCredential.user).thenReturn(user);
          when(() => user.uid).thenReturn('1');
          when(() => user.emailVerified).thenReturn(true);
          when(() => user.sendEmailVerification()).thenAnswer((_) async {});

          //Act
          final result = await dataSource.loginWithEmailAndPassword(email, password);

          //Assert
          expect(result, isA<AccountModel>());
          verify(() => mockFirebaseAuth.signInWithEmailAndPassword(email: email, password: password)).called(1);
          verify(() => userCredential.user).called(1);
          verify(() => user.uid).called(1);
          verify(() => user.emailVerified).called(1);
          verifyNever(() => user.sendEmailVerification());
        }
      );

      test(
        'should throw an UserDisabledException when trying to sign in',
        () async {
          //Arrange
          when(() => mockFirebaseAuth.signInWithEmailAndPassword(email: email, password: password))
            .thenThrow(FirebaseAuthException(code: 'user-disabled'));

          //Act
          final result = dataSource.loginWithEmailAndPassword(email, password);

          //Assert
          expect(result, throwsA(UserDisabledException()));
          verify(() => mockFirebaseAuth.signInWithEmailAndPassword(email: email, password: password)).called(1);
        }
      );

      test(
        'should throw an UserNotFoundException trying to sign in',
        () async {
          //Arrange
          when(() => mockFirebaseAuth.signInWithEmailAndPassword(email: email, password: password))
            .thenThrow(FirebaseAuthException(code: 'user-not-found'));

          //Act
          final result = dataSource.loginWithEmailAndPassword(email, password);

          //Assert
          expect(result, throwsA(UserNotFoundException()));
          verify(() => mockFirebaseAuth.signInWithEmailAndPassword(email: email, password: password)).called(1);
        }
      );

      test(
        'should throw an WrongPasswordException trying to sign in',
        () async {
          //Arrange
          when(() => mockFirebaseAuth.signInWithEmailAndPassword(email: email, password: password))
            .thenThrow(FirebaseAuthException(code: 'wrong-password'));

          //Act
          final result = dataSource.loginWithEmailAndPassword(email, password);

          //Assert
          expect(result, throwsA(WrongPasswordException()));
          verify(() => mockFirebaseAuth.signInWithEmailAndPassword(email: email, password: password)).called(1);
        }
      );

      test(
        'should throw an InvalidEmailException when trying to sign in',
        () async {
          //Arrange
          when(() => mockFirebaseAuth.signInWithEmailAndPassword(email: email, password: password))
            .thenThrow(FirebaseAuthException(code: 'invalid-email'));

          //Act
          final result = dataSource.loginWithEmailAndPassword(email, password);

          //Assert
          expect(result, throwsA(InvalidEmailException()));
          verify(() => mockFirebaseAuth.signInWithEmailAndPassword(email: email, password: password)).called(1);
        }
      );

      test(
        'should throw an LoginException when trying to sign in',
        () async {
          //Arrange
          when(() => mockFirebaseAuth.signInWithEmailAndPassword(email: email, password: password))
            .thenThrow(Exception());

          //Act
          final result = dataSource.loginWithEmailAndPassword(email, password);

          //Assert
          expect(result, throwsA(LoginException()));
          verify(() => mockFirebaseAuth.signInWithEmailAndPassword(email: email, password: password)).called(1);
        }
      );
    }
  );

  group(
    'loginWithGoogle',
    () {
      registerFallbackValue(const OAuthCredential(providerId: '', signInMethod: ''));
      final userCredential = MockUserCredential();
      final user = MockUser();
      const tAccount = AccountModel(
        id: "1",
        name: "Test",
        document: "123",
        email: "test@test.com",
        phone: "123456",
        zip: "123456",
        address: "Test",
        number: "123",
        neighborhood: "Test",
        city: "Test",
        state: "Test",
        isWorker: true,
        description: "Test",
        status: 0,
        cause: "Test",
        categoryId: '',
      );

      test(
        'should return a created AccountModel',
        () async {
          //Arrange
          final mockGoogleSignInAccount = MockGoogleSignInAccount();
          final mockGoogleSignInAuthentication = MockGoogleSignInAuthentication();
          when(mockGoogleSignIn.signIn).thenAnswer((_) async => mockGoogleSignInAccount);
          when(() => mockGoogleSignInAccount.authentication).thenAnswer((_) async => mockGoogleSignInAuthentication);
          when(() => mockGoogleSignInAuthentication.idToken).thenAnswer((_) => 'idToken');
          when(() => mockGoogleSignInAuthentication.accessToken).thenAnswer((_) => 'accessToken');
          when(() => mockFirebaseAuth.signInWithCredential(any()))
            .thenAnswer((_) async => userCredential);
          when(() => userCredential.user).thenReturn(user);
          when(() => mockFirebaseAuth.currentUser).thenReturn(user);
          when(() => user.uid).thenReturn('1');

          //Act
          final result = await dataSource.loginWithGoogle();

          //Assert
          expect(result, isA<AccountModel>());
          verify(() => mockFirebaseAuth.signInWithCredential(any())).called(1);
          verify(() => userCredential.user).called(1);
          verify(() => mockFirebaseAuth.currentUser).called(1);
          verify(() => user.uid).called(3);
        }
      );

      test(
        'should return an already created AccountModel',
        () async {
          //Arrange
          final response = await mockFirebaseStore.collection('users').doc(tAccount.id).get();
          await response.reference.set(tAccount.toJson());

          final mockGoogleSignInAccount = MockGoogleSignInAccount();
          final mockGoogleSignInAuthentication = MockGoogleSignInAuthentication();
          when(mockGoogleSignIn.signIn).thenAnswer((_) async => mockGoogleSignInAccount);
          when(() => mockGoogleSignInAccount.authentication).thenAnswer((_) async => mockGoogleSignInAuthentication);
          when(() => mockGoogleSignInAuthentication.idToken).thenAnswer((_) => 'idToken');
          when(() => mockGoogleSignInAuthentication.accessToken).thenAnswer((_) => 'accessToken');
          when(() => mockFirebaseAuth.signInWithCredential(any()))
            .thenAnswer((_) async => userCredential);
          when(() => userCredential.user).thenReturn(user);
          when(() => user.uid).thenReturn('1');

          //Act
          final result = await dataSource.loginWithGoogle();

          //Assert
          expect(result, isA<AccountModel>());
          verify(() => mockFirebaseAuth.signInWithCredential(any())).called(1);
          verify(() => userCredential.user).called(1);
          verify(() => user.uid).called(1);
        }
      );

      test(
        'should throw an OperationNotAllowedException when trying to sign in with Google',
        () async {
          //Arrange
          final mockGoogleSignInAccount = MockGoogleSignInAccount();
          final mockGoogleSignInAuthentication = MockGoogleSignInAuthentication();
          when(mockGoogleSignIn.signIn).thenAnswer((_) async => mockGoogleSignInAccount);
          when(() => mockGoogleSignInAccount.authentication).thenAnswer((_) async => mockGoogleSignInAuthentication);
          when(() => mockGoogleSignInAuthentication.idToken).thenAnswer((_) => 'idToken');
          when(() => mockGoogleSignInAuthentication.accessToken).thenAnswer((_) => 'accessToken');
          when(mockGoogleSignIn.isSignedIn).thenAnswer((_) async => false);
          when(() => mockFirebaseAuth.signInWithCredential(any()))
            .thenThrow(FirebaseAuthException(code: 'operation-not-allowed'));

          //Act
          final result = dataSource.loginWithGoogle();

          //Assert
          expect(result, throwsA(OperationNotAllowedException()));
        }
      );

      test(
        'should throw an AccountExistsWithDifferentCredentialException when trying to sign in with Google',
        () async {
          //Arrange
          final mockGoogleSignInAccount = MockGoogleSignInAccount();
          final mockGoogleSignInAuthentication = MockGoogleSignInAuthentication();
          when(mockGoogleSignIn.signIn).thenAnswer((_) async => mockGoogleSignInAccount);
          when(() => mockGoogleSignInAccount.authentication).thenAnswer((_) async => mockGoogleSignInAuthentication);
          when(() => mockGoogleSignInAuthentication.idToken).thenAnswer((_) => 'idToken');
          when(() => mockGoogleSignInAuthentication.accessToken).thenAnswer((_) => 'accessToken');
          when(mockGoogleSignIn.isSignedIn).thenAnswer((_) async => false);
          when(() => mockFirebaseAuth.signInWithCredential(any()))
            .thenThrow(FirebaseAuthException(code: 'account-exists-with-different-credential'));

          //Act
          final result = dataSource.loginWithGoogle();

          //Assert
          expect(result, throwsA(AccountExistsWithDifferentCredentialException()));
        }
      );

      test(
        'should throw an InvalidCredentialException when trying to sign in with Google',
        () async {
          //Arrange
          final mockGoogleSignInAccount = MockGoogleSignInAccount();
          final mockGoogleSignInAuthentication = MockGoogleSignInAuthentication();
          when(mockGoogleSignIn.signIn).thenAnswer((_) async => mockGoogleSignInAccount);
          when(() => mockGoogleSignInAccount.authentication).thenAnswer((_) async => mockGoogleSignInAuthentication);
          when(() => mockGoogleSignInAuthentication.idToken).thenAnswer((_) => 'idToken');
          when(() => mockGoogleSignInAuthentication.accessToken).thenAnswer((_) => 'accessToken');
          when(mockGoogleSignIn.isSignedIn).thenAnswer((_) async => false);
          when(() => mockFirebaseAuth.signInWithCredential(any()))
            .thenThrow(FirebaseAuthException(code: 'invalid-credential'));

          //Act
          final result = dataSource.loginWithGoogle();

          //Assert
          expect(result, throwsA(InvalidCredentialException()));
        }
      );

      test(
        'should throw an UserDisabledException when trying to sign in with Google',
        () async {
          //Arrange
          final mockGoogleSignInAccount = MockGoogleSignInAccount();
          final mockGoogleSignInAuthentication = MockGoogleSignInAuthentication();
          when(mockGoogleSignIn.signIn).thenAnswer((_) async => mockGoogleSignInAccount);
          when(() => mockGoogleSignInAccount.authentication).thenAnswer((_) async => mockGoogleSignInAuthentication);
          when(() => mockGoogleSignInAuthentication.idToken).thenAnswer((_) => 'idToken');
          when(() => mockGoogleSignInAuthentication.accessToken).thenAnswer((_) => 'accessToken');
          when(mockGoogleSignIn.isSignedIn).thenAnswer((_) async => false);
          when(() => mockFirebaseAuth.signInWithCredential(any()))
            .thenThrow(FirebaseAuthException(code: 'user-disabled'));

          //Act
          final result = dataSource.loginWithGoogle();

          //Assert
          expect(result, throwsA(UserDisabledException()));
        }
      );

      test(
        'should throw an UserNotFoundException when trying to sign in with Google',
        () async {
          //Arrange
          final mockGoogleSignInAccount = MockGoogleSignInAccount();
          final mockGoogleSignInAuthentication = MockGoogleSignInAuthentication();
          when(mockGoogleSignIn.signIn).thenAnswer((_) async => mockGoogleSignInAccount);
          when(() => mockGoogleSignInAccount.authentication).thenAnswer((_) async => mockGoogleSignInAuthentication);
          when(() => mockGoogleSignInAuthentication.idToken).thenAnswer((_) => 'idToken');
          when(() => mockGoogleSignInAuthentication.accessToken).thenAnswer((_) => 'accessToken');
          when(mockGoogleSignIn.isSignedIn).thenAnswer((_) async => false);
          when(() => mockFirebaseAuth.signInWithCredential(any()))
            .thenThrow(FirebaseAuthException(code: 'user-not-found'));

          //Act
          final result = dataSource.loginWithGoogle();

          //Assert
          expect(result, throwsA(UserNotFoundException()));
        }
      );

      test(
        'should throw an WrongPasswordException trying to sign in',
        () async {
          //Arrange
          final mockGoogleSignInAccount = MockGoogleSignInAccount();
          final mockGoogleSignInAuthentication = MockGoogleSignInAuthentication();
          when(mockGoogleSignIn.signIn).thenAnswer((_) async => mockGoogleSignInAccount);
          when(() => mockGoogleSignInAccount.authentication).thenAnswer((_) async => mockGoogleSignInAuthentication);
          when(() => mockGoogleSignInAuthentication.idToken).thenAnswer((_) => 'idToken');
          when(() => mockGoogleSignInAuthentication.accessToken).thenAnswer((_) => 'accessToken');
          when(mockGoogleSignIn.isSignedIn).thenAnswer((_) async => false);
          when(() => mockFirebaseAuth.signInWithCredential(any()))
            .thenThrow(FirebaseAuthException(code: 'wrong-password'));

          //Act
          final result = dataSource.loginWithGoogle();

          //Assert
          expect(result, throwsA(WrongPasswordException()));
        }
      );

      test(
        'should throw an InvalidVerificationCodeException when trying to sign in with Google',
        () async {
          //Arrange
          final mockGoogleSignInAccount = MockGoogleSignInAccount();
          final mockGoogleSignInAuthentication = MockGoogleSignInAuthentication();
          when(mockGoogleSignIn.signIn).thenAnswer((_) async => mockGoogleSignInAccount);
          when(() => mockGoogleSignInAccount.authentication).thenAnswer((_) async => mockGoogleSignInAuthentication);
          when(() => mockGoogleSignInAuthentication.idToken).thenAnswer((_) => 'idToken');
          when(() => mockGoogleSignInAuthentication.accessToken).thenAnswer((_) => 'accessToken');
          when(mockGoogleSignIn.isSignedIn).thenAnswer((_) async => false);
          when(() => mockFirebaseAuth.signInWithCredential(any()))
            .thenThrow(FirebaseAuthException(code: 'invalid-verification-code'));

          //Act
          final result = dataSource.loginWithGoogle();

          //Assert
          expect(result, throwsA(InvalidVerificationCodeException()));
        }
      );

      test(
        'should throw an InvalidVerificationIdException when trying to sign in with Google',
        () async {
          //Arrange
          final mockGoogleSignInAccount = MockGoogleSignInAccount();
          final mockGoogleSignInAuthentication = MockGoogleSignInAuthentication();
          when(mockGoogleSignIn.signIn).thenAnswer((_) async => mockGoogleSignInAccount);
          when(() => mockGoogleSignInAccount.authentication).thenAnswer((_) async => mockGoogleSignInAuthentication);
          when(() => mockGoogleSignInAuthentication.idToken).thenAnswer((_) => 'idToken');
          when(() => mockGoogleSignInAuthentication.accessToken).thenAnswer((_) => 'accessToken');
          when(mockGoogleSignIn.isSignedIn).thenAnswer((_) async => false);
          when(() => mockFirebaseAuth.signInWithCredential(any()))
            .thenThrow(FirebaseAuthException(code: 'invalid-verification-id'));

          //Act
          final result = dataSource.loginWithGoogle();

          //Assert
          expect(result, throwsA(InvalidVerificationIdException()));
        }
      );

      test(
        'should throw an LoginException when trying to sign in with Google',
        () async {
          //Arrange
          final mockGoogleSignInAccount = MockGoogleSignInAccount();
          final mockGoogleSignInAuthentication = MockGoogleSignInAuthentication();
          when(mockGoogleSignIn.signIn).thenAnswer((_) async => mockGoogleSignInAccount);
          when(() => mockGoogleSignInAccount.authentication).thenAnswer((_) async => mockGoogleSignInAuthentication);
          when(() => mockGoogleSignInAuthentication.idToken).thenAnswer((_) => 'idToken');
          when(() => mockGoogleSignInAuthentication.accessToken).thenAnswer((_) => 'accessToken');
          when(mockGoogleSignIn.isSignedIn).thenAnswer((_) async => false);
          when(() => mockFirebaseAuth.signInWithCredential(any()))
            .thenThrow(Exception());

          //Act
          final result = dataSource.loginWithGoogle();

          //Assert
          expect(result, throwsA(LoginException()));
        }
      );
    }
  );

  group(
    'getLoggedUser',
    () {
      final user = MockUser();
      const tAccount = AccountModel(
        id: "1",
        name: "Test",
        document: "123",
        email: "test@test.com",
        phone: "123456",
        zip: "123456",
        address: "Test",
        number: "123",
        neighborhood: "Test",
        city: "Test",
        state: "Test",
        isWorker: true,
        description: "Test",
        status: 0,
        cause: "Test",
        categoryId: '',
      );

      test(
        'should return an AccountModel for the given id',
        () async {
          //Arrange
          final response = await mockFirebaseStore.collection('users').doc(tAccount.id).get();
          await response.reference.set(tAccount.toJson());
          when(() => mockFirebaseAuth.currentUser).thenReturn(user);
          when(() => user.uid).thenReturn('1');

          //Act
          final result = await dataSource.getLoggedUser();

          //Assert
          expect(result, tAccount);
        }
      );

      test(
        'should throw an UserNotFoundException when the user does not exist',
        () async {
          //Arrange
          when(() => mockFirebaseAuth.currentUser)
            .thenThrow(UserNotFoundException());

          //Act
          final result = dataSource.getLoggedUser();

          //Assert
          expect(result, throwsA(UserNotFoundException()));
        }
      );
    }
  );
}