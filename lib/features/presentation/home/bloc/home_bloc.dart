import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/states/bloc_state.dart';
import 'events/home_bloc_event.dart';

class HomeBloc extends Bloc<HomeBlocEvent, BlocState>{
  HomeBloc() : super(BlocState.empty());

  @override
  Stream<BlocState> mapEventToState(HomeBlocEvent event) async* {
    if(event is PageHomeBlocEvent) {
      yield BlocState.success(event.page);
    }
  }
}