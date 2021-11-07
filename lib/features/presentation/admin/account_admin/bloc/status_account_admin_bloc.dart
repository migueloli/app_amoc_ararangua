import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/states/bloc_state.dart';
import 'event/status_account_admin_bloc_event.dart';

class StatusAccountAdminBloc extends Bloc<StatusAccountAdminBlocEvent, BlocState> {
  StatusAccountAdminBloc() : super(BlocState.empty());

  @override
  Stream<BlocState> mapEventToState(StatusAccountAdminBlocEvent event) async* {
    if(event is ChangeStatusAccountAdminBlocEvent) {
      yield BlocState.success(event.status);
    }
  }

}
