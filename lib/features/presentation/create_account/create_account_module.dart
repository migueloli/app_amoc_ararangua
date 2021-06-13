import 'package:flutter_modular/flutter_modular.dart';

import 'create_account_page.dart';

class CreateAccountModule extends Module {

  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
    ChildRoute('${Modular.initialRoute}about', child: (_, __) => CreateAccountPage()),
  ];

}