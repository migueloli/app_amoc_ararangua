import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/states/bloc_state.dart';
import 'events/profile_event_bloc.dart';

class ProfilePageBloc extends Bloc<ProfileEventBloc, BlocState> {
  ProfilePageBloc() : super(BlocState.empty());

  @override
  Stream<BlocState> mapEventToState(ProfileEventBloc event) async* {
    if(event is PageProfileEventBloc) {
      yield BlocState.success(event.page);
    }
  }
}
