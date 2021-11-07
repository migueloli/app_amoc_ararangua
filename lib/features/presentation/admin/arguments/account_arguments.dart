import 'package:equatable/equatable.dart';

import '../../../domain/entities/account_entity.dart';

class AccountArguments extends Equatable {
  final AccountEntity entity;

  const AccountArguments(this.entity);

  @override
  List<Object?> get props => [entity];
}
