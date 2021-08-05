import 'package:flutter_modular/flutter_modular.dart';

import '../../domain/usecases/get_accounts_usecase.dart';
import '../../domain/usecases/get_logged_user_usecase.dart';
import 'home_page.dart';
import 'pages/account/store/account_store.dart';
import 'pages/services/store/services_store.dart';
import 'store/home_store.dart';

class HomeModule extends Module {
  @override
  List<Bind> get binds => [
    Bind((i) => HomeStore()),
    Bind((i) => GetAccountsUseCase(i.get())),
    Bind((i) => GetLoggedUserUseCase(i.get())),
    Bind((i) => ServicesStore(i.get())),
    Bind((i) => AccountStore(i.get())),
  ];

  @override
  List<ModularRoute> get routes => [
    ChildRoute(Modular.initialRoute, child: (_, __) => HomePage()),
  ];
}