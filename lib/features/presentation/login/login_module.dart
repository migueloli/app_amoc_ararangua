import 'package:flutter_modular/flutter_modular.dart';

import 'bloc/login_bloc.dart';
import 'login_page.dart';

class LoginModule extends Module {
  @override
  List<Bind> get binds => [
    Bind((i) => LoginBloc(i.get())),
  ];

  @override
  List<ModularRoute> get routes => [
    ChildRoute(Modular.initialRoute, child: (_, __) => const LoginPage()),
  ];
}