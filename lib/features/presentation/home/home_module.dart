import 'package:flutter_modular/flutter_modular.dart';

import '../../domain/usecases/get_accounts_usecase.dart';
import 'pages/services/store/account_search_store.dart';
import 'store/home_store.dart';
import 'home_page.dart';

class HomeModule extends Module {
  @override
  List<Bind> get binds => [
    Bind((i) => HomeStore()),
    Bind((i) => GetAccountsUseCase(i.get())),
    Bind((i) => AccountSearchStore(getAccountUseCase: i.get())),
  ];

  @override
  List<ModularRoute> get routes => [
    ChildRoute(Modular.initialRoute, child: (_, __) => HomePage()),
  ];

}