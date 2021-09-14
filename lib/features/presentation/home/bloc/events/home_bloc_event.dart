import 'package:equatable/equatable.dart';

abstract class HomeBlocEvent extends Equatable {
  const HomeBlocEvent();
}

class PageHomeBlocEvent extends HomeBlocEvent {
  final int page;

  const PageHomeBlocEvent({required this.page});

  @override
  List<Object?> get props => [page];
}