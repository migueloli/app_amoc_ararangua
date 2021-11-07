import 'package:equatable/equatable.dart';

abstract class AdminBlocEvent extends Equatable {
  const AdminBlocEvent();
}

class PageAdminBlocEvent extends AdminBlocEvent {
  final int page;

  const PageAdminBlocEvent({this.page = 0});

  @override
  List<Object?> get props => [page,];
}
