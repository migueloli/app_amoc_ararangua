import 'dart:async';

import 'package:app_amoc_ararangua/core/states/bloc_state.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';

class HomeBloc extends Bloc<HomeEvent, BlocState> {

  HomeBloc() : super(BlocState.empty());

  @override
  Stream<BlocState> mapEventToState(
    HomeEvent event,
  ) async* {
    if(event is PageControllerEvent) {
      yield SuccessBlocState(value: event.page);
    }
  }
}
