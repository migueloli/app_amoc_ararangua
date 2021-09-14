import 'package:equatable/equatable.dart';

abstract class ServicesBlocEvent extends Equatable {
  const ServicesBlocEvent();
}

class SearchServicesBlocEvent extends ServicesBlocEvent {
  final String? search;

  const SearchServicesBlocEvent({this.search});

  @override
  List<Object?> get props => [search];
}