import 'package:equatable/equatable.dart';

abstract class LoginBlocEvent extends Equatable {
  const LoginBlocEvent();
}

class LoginWithEmailAndPasswordBlocEvent extends LoginBlocEvent {
  const LoginWithEmailAndPasswordBlocEvent();

  @override
  List<Object?> get props => [];
}

class LoginWithGoogleBlocEvent extends LoginBlocEvent {
  const LoginWithGoogleBlocEvent();
  @override
  List<Object?> get props => [];
}
