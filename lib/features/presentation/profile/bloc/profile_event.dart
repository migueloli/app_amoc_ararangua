part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class ChangeStepEvent extends ProfileEvent {

  final int step;

  ChangeStepEvent({required this.step});

  @override
  List<Object> get props => [step];

}
