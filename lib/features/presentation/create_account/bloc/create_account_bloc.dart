import 'dart:async';

import 'package:app_amoc_ararangua/core/states/bloc_state.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'create_account_event.dart';

class CreateAccountBloc extends Bloc<CreateAccountEvent, BlocState> {

  static const LAST_STEP = 2;

  CreateAccountBloc() : super(BlocState.empty());

  @override
  Stream<BlocState> mapEventToState(
    CreateAccountEvent event,
  ) async* {
    if(event is ChangeStepEvent) {
      var step = event.step;

      if(step > LAST_STEP) {
        step = 2;
      } else if(step < 0) {
        step = 0;
      }

      yield SuccessBlocState(value: step);
    }
  }

  bool isFirstStep(int step) => 0 == step;

  bool isLastStep(int step) => LAST_STEP == step;

}
