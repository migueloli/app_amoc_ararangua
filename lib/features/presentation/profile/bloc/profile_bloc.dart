import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/states/bloc_state.dart';
import '../../../domain/usecases/save_account_use_case.dart';
import 'events/profile_event_bloc.dart';

class ProfileBloc extends Bloc<ProfileEventBloc, BlocState> {
  final SaveAccountUseCase saveAccountUseCase;

  ProfileBloc(this.saveAccountUseCase) : super(BlocState.empty());

  @override
  Stream<BlocState> mapEventToState(ProfileEventBloc event) async* {
    if(event is GetProfileEventBloc) {
      yield BlocState.loading();
    } else if(event is SaveProfileEventBloc) {
      yield BlocState.loading();
    }
  }
}