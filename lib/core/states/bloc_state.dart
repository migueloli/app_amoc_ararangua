import 'package:equatable/equatable.dart';

abstract class BlocState extends Equatable {

  BlocState._();

  factory BlocState.empty() => EmptyBlocState();
  factory BlocState.loading() => LoadingBlocState();
  factory BlocState.success(value) => SuccessBlocState(value: value);
  factory BlocState.error(String message) => ErrorBlocState(message: message);

}

class EmptyBlocState extends BlocState {

  EmptyBlocState() : super._();

  @override
  List<Object> get props => [];

}

class LoadingBlocState extends BlocState {

  LoadingBlocState() : super._();

  @override
  List<Object> get props => [];

}

class SuccessBlocState<T> extends BlocState {

  final T value;
  SuccessBlocState({required this.value}): super._();

  @override
  List<Object?> get props => [value];

}

class ErrorBlocState extends BlocState {

  final String message;

  ErrorBlocState({required this.message}): super._();

  @override
  List<Object?> get props => [message];

}