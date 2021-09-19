import 'package:flutter_modular/flutter_modular.dart';

import '../../domain/usecases/get_accounts_use_case.dart';
import 'bloc/home_bloc.dart';
import 'home_page.dart';
import 'pages/account/bloc/account_bloc.dart';
import 'pages/services/bloc/services_bloc.dart';

class HomeModule extends Module {
  @override
  List<Bind> get binds => [
    Bind((i) => HomeBloc()),
    Bind((i) => GetAccountsUseCase(i.get())),
    Bind((i) => ServicesBloc(i.get())),
    Bind((i) => AccountBloc(i.get())),
  ];

  @override
  List<ModularRoute> get routes => [
    ChildRoute(Modular.initialRoute, child: (_, __) => HomePage()),
  ];
}