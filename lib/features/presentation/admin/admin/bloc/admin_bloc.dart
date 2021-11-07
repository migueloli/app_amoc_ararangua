import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/states/bloc_state.dart';
import 'events/admin_bloc_event.dart';

class AdminBloc extends Bloc<AdminBlocEvent, BlocState> {
  AdminBloc() : super(BlocState.empty());

  @override
  Stream<BlocState> mapEventToState(AdminBlocEvent event) async* {
    if(event is PageAdminBlocEvent) {
      yield BlocState.success(event.page);
    }
  }

}
