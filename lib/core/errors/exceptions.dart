import 'package:equatable/equatable.dart';

abstract class CustomException extends Equatable implements Exception {}

class ServerException extends CustomException {

  @override
  List<Object> get props => [];

}

class LoginException extends CustomException {

  @override
  List<Object> get props => [];

}

class InvalidEmailException extends LoginException {

  @override
  List<Object> get props => [];

}

class OperationNotAllowedException extends LoginException {

  @override
  List<Object> get props => [];

}

class WeakPasswordException extends LoginException {

  @override
  List<Object> get props => [];

}

class UserDisabledException extends LoginException {

  @override
  List<Object> get props => [];

}

class UserNotFoundException extends LoginException {

  @override
  List<Object> get props => [];

}

class WrongPasswordException extends LoginException {

  @override
  List<Object> get props => [];

}

class AccountExistsWithDifferentCredentialException extends LoginException {

  @override
  List<Object> get props => [];

}

class InvalidCredentialException extends LoginException {

  @override
  List<Object> get props => [];

}

class InvalidVerificationCodeException extends LoginException {

  @override
  List<Object> get props => [];

}

class InvalidVerificationIdException extends LoginException {

  @override
  List<Object> get props => [];

}
