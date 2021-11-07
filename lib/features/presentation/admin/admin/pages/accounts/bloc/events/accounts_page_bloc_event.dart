import 'package:equatable/equatable.dart';

abstract class AccountsPageBlocEvent extends Equatable {
  const AccountsPageBlocEvent();
}

class GetAccountsBlocEvent extends AccountsPageBlocEvent {
  const GetAccountsBlocEvent();

  @override
  List<Object?> get props => [];
}
