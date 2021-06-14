import 'dart:async';

import 'package:app_amoc_ararangua/core/states/bloc_state.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';

class HomeBloc extends Bloc<HomeEvent, BlocState> {

  static const LAST_PAGE = 2;

  HomeBloc() : super(BlocState.empty());

  @override
  Stream<BlocState> mapEventToState(
    HomeEvent event,
  ) async* {
    if(event is PageControllerEvent) {
      var page = event.page;

      if(page > LAST_PAGE) {
        page = 2;
      } else if(page < 0) {
        page = 0;
      }

      yield SuccessBlocState(value: page);
    }
  }

  bool isFirstPage(int page) => 0 == page;

  bool isLastPage(int page) => LAST_PAGE == page;

}
