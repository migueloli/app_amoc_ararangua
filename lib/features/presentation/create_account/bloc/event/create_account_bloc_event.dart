import 'package:equatable/equatable.dart';

abstract class CreateAccountBlocEvent extends Equatable {
  const CreateAccountBlocEvent();
}

class CreateAccountWithEmailAndPasswordEvent extends CreateAccountBlocEvent {
  const CreateAccountWithEmailAndPasswordEvent();

  @override
  List<Object?> get props => [];
}

class CreateAccountWithGoogleEvent extends CreateAccountBlocEvent {
  const CreateAccountWithGoogleEvent();

  @override
  List<Object?> get props => [];
}