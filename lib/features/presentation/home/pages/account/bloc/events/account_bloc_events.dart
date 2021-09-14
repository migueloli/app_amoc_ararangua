import 'package:equatable/equatable.dart';

abstract class AccountBlocEvents extends Equatable {
  const AccountBlocEvents();
}

class GetLoggedUserBlocEvent extends AccountBlocEvents {
  const GetLoggedUserBlocEvent();

  @override
  List<Object?> get props => [];
}
