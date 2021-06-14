import 'package:flutter_modular/flutter_modular.dart';

import 'bloc/create_account_bloc.dart';
import 'create_account_page.dart';

class CreateAccountModule extends Module {

  @override
  List<Bind> get binds => [
    Bind((i) => CreateAccountBloc())
  ];

  @override
  List<ModularRoute> get routes => [
    ChildRoute('${Modular.initialRoute}create-account', child: (_, __) => CreateAccountPage()),
  ];

}