import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

class ServerFailure extends Failure {
  @override
  List<Object> get props => [];
}

class NetworkFailure extends Failure {
  @override
  List<Object> get props => [];
}

class LoginFailure extends Failure {
  @override
  List<Object> get props => [];
}

class InvalidEmailFailure extends LoginFailure {
  @override
  List<Object> get props => [];
}

class OperationNotAllowedFailure extends LoginFailure {
  @override
  List<Object> get props => [];
}

class WeakPasswordFailure extends LoginFailure {
  @override
  List<Object> get props => [];
}

class UserDisabledFailure extends LoginFailure {
  @override
  List<Object> get props => [];
}

class UserNotFoundFailure extends LoginFailure {
  @override
  List<Object> get props => [];
}

class WrongPasswordFailure extends LoginFailure {
  @override
  List<Object> get props => [];
}

class AccountExistsWithDifferentCredentialFailure extends LoginFailure {
  @override
  List<Object> get props => [];
}

class InvalidCredentialFailure extends LoginFailure {
  @override
  List<Object> get props => [];
}

class InvalidVerificationCodeFailure extends LoginFailure {
  @override
  List<Object> get props => [];
}

class InvalidVerificationIdFailure extends LoginFailure {
  @override
  List<Object> get props => [];
}

class EmailAlreadyInUseFailure extends LoginFailure {
  @override
  List<Object> get props => [];
}