import 'package:equatable/equatable.dart';

abstract class StatusAccountAdminBlocEvent extends Equatable {
  const StatusAccountAdminBlocEvent();
}

class ChangeStatusAccountAdminBlocEvent extends StatusAccountAdminBlocEvent {
  final int status;

  const ChangeStatusAccountAdminBlocEvent(this.status);

  @override
  List<Object?> get props => [status];
}
