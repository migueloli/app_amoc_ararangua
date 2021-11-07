import 'package:app_amoc_ararangua/features/domain/entities/account_entity.dart';
import 'package:equatable/equatable.dart';

abstract class AccountAdminBlocEvent extends Equatable {
  const AccountAdminBlocEvent();
}

class SaveAccountAdminBlocEvent extends AccountAdminBlocEvent {
  final AccountEntity account;
  final int status;

  const SaveAccountAdminBlocEvent(this.account, this.status);

  @override
  List<Object?> get props => [account, status];
}
