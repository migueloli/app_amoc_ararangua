part of 'account_search_bloc.dart';

abstract class AccountSearchEvent extends Equatable {
  const AccountSearchEvent();
}

class GetAccountsEvent extends AccountSearchEvent {
  @override
  List<Object> get props => [];
}
