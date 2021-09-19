import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../core/errors/exceptions.dart';
import '../models/account_model.dart';
import 'accounts_remote_datasource.dart';

class AccountsRemoteDataSourceImplementation extends IAccountsRemoteDataSource {
  final FirebaseFirestore store;
  final FirebaseAuth auth;
  final GoogleSignIn googleSignIn;

  AccountsRemoteDataSourceImplementation(this.store, this.auth, this.googleSignIn);

  @override
  Future<List<AccountModel>> getListOfAccounts() async {
    try {
      final response = await store.collection('users')
          .where('is_worker', isEqualTo: true)
          .where('status', isEqualTo: 1)
          .get();
      final accountList = <AccountModel>[];

      for(final doc in response.docs) {
        accountList.add(AccountModel.fromJson(doc.data()));
      }

      return accountList;
    } catch(exception) {
      throw ServerException;
    }
  }

  @override
  Future<AccountModel> saveAccount(AccountModel account) async {
    try {
      final response = await store.collection('users').add(account.toJson());
      final doc = await response.get();
      final data = doc.data();

      if(data != null) {
        return AccountModel.fromJson(data);
      } else {
        throw UserNotSavedException();
      }
    } catch(exception) {
      throw ServerException();
    }
  }

  @override
  Future<AccountModel> getAccount(String uid) async {
    try {
      final response = await store.collection('users').where('id', isEqualTo: uid).get();
      if(response.docs.isEmpty) throw UserNotFoundException();
      return AccountModel.fromJson(response.docs.first.data());
    } catch(e) {
      if(e is UserNotFoundException) rethrow;

      throw ServerException;
    }
  }

  @override
  Future<AccountModel> createAccountWithEmailAndPassword(String email, String password) async {
    try {
      final credential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user;
      if(user != null) {
        final account = await saveAccount(AccountModel.fromUser(user));
        await user.sendEmailVerification();
        return account;
      }

      throw LoginException();
    } on FirebaseAuthException catch (e) {
      throw _prepareFirebaseException(e.code);
    } catch (e) {
      throw LoginException();
    }
  }

  @override
  Future<AccountModel> loginWithEmailAndPassword(String email, String password) async {
    try {
      final credential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user;
      if(user != null) {
        final account = await getAccount(user.uid);
        if(!user.emailVerified) await user.sendEmailVerification();

        return account;
      }

      throw LoginException();
    } on FirebaseAuthException catch (e) {
      throw _prepareFirebaseException(e.code);
    } catch (e) {
      throw LoginException();
    }
  }

  @override
  Future<AccountModel> loginWithGoogle() async {
    try {
      final googleUser = await googleSignIn.signIn();
      final googleAuth = await googleUser?.authentication;
      final googleCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      final credential = await auth.signInWithCredential(googleCredential);
      final user = credential.user;
      if(user != null) {
        try{
          return await getAccount(user.uid);
        } catch(e) {
          return await saveAccount(AccountModel.fromUser(user));
        }
      }

      throw LoginException();
    } on FirebaseAuthException catch (e) {
      throw _prepareFirebaseException(e.code);
    } catch (e) {
      throw LoginException();
    }
  }

  @override
  Future<AccountModel> getLoggedUser() async {
    try {
      final user = auth.currentUser;
      if(user == null) throw UserNotFoundException();
      return await getAccount(user.uid);
    } catch (e) {
      rethrow;
    }
  }

  Exception _prepareFirebaseException(String code) {
    switch(code) {
      case 'email-already-in-use':
        return EmailAlreadyInUseException();
      case 'weak-password':
        return WeakPasswordException();
      case 'invalid-email':
        return InvalidEmailException();
      case 'operation-not-allowed':
        return OperationNotAllowedException();
      case 'user-disabled':
        return UserDisabledException();
      case 'user-not-found':
        return UserNotFoundException();
      case 'wrong-password':
        return WrongPasswordException();
      case 'account-exists-with-different-credential':
        return AccountExistsWithDifferentCredentialException();
      case 'invalid-credential':
        return InvalidCredentialException();
      case 'invalid-verification-code':
        return InvalidVerificationCodeException();
      case 'invalid-verification-id':
        return InvalidVerificationIdException();
      default:
        return LoginException();
    }
  }
}