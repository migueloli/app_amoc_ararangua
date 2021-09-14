import 'package:equatable/equatable.dart';

abstract class BlocState extends Equatable {
  const BlocState._();

  factory BlocState.empty() => const EmptyBlocState();
  factory BlocState.loading() => const LoadingBlocState();
  factory BlocState.success(value) => SuccessBlocState(value: value);
  factory BlocState.error(String message) => ErrorBlocState(message: message);
}

class EmptyBlocState extends BlocState {
  const EmptyBlocState() : super._();

  @override
  List<Object> get props => [];
}

class LoadingBlocState extends BlocState {
  const LoadingBlocState() : super._();

  @override
  List<Object> get props => [];
}

class SuccessBlocState<T> extends BlocState {
  final T value;

  const SuccessBlocState({required this.value}): super._();

  @override
  List<Object?> get props => [value];
}

class ErrorBlocState extends BlocState {
  final String message;

  const ErrorBlocState({required this.message}): super._();

  @override
  List<Object?> get props => [message];
}