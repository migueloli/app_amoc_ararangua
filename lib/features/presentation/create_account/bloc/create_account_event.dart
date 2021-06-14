part of 'create_account_bloc.dart';

abstract class CreateAccountEvent extends Equatable {
  const CreateAccountEvent();

  @override
  List<Object> get props => [];
}

class ChangeStepEvent extends CreateAccountEvent {

  final int step;

  ChangeStepEvent({required this.step});

  @override
  List<Object> get props => [step];

}
