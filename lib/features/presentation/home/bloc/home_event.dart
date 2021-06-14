part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class PageControllerEvent extends HomeEvent {

  final int page;

  PageControllerEvent({required this.page});

  @override
  List<Object?> get props => [page];
}
