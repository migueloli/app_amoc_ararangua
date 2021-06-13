import 'package:flutter_modular/flutter_modular.dart';

import '../../domain/usecases/get_accounts_usecase.dart';
import 'bloc/home_bloc.dart';
import 'home_page.dart';
import 'pages/services/bloc/account_search_bloc.dart';

class HomeModule extends Module {
  @override
  List<Bind> get binds => [
    Bind((i) => HomeBloc()),
    Bind((i) => GetAccountsUseCase(i.get())),
    Bind((i) => AccountsSearchBloc(getAccountUseCase: i.get())),
  ];

  @override
  List<ModularRoute> get routes => [
    ChildRoute(Modular.initialRoute, child: (_, __) => HomePage()),
  ];

}