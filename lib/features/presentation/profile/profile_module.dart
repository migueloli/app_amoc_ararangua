import 'package:app_amoc_ararangua/features/domain/usecases/save_account_use_case.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'bloc/profile_bloc.dart';
import 'profile_page.dart';

class LoginModule extends Module {
  @override
  List<Bind> get binds => [
    Bind((i) => SaveAccountUseCase(i.get())),
    Bind((i) => ProfileBloc(i.get())),
  ];

  @override
  List<ModularRoute> get routes => [
    ChildRoute(Modular.initialRoute, child: (_, __) => const ProfilePage()),
  ];
}