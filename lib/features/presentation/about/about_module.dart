import 'package:flutter_modular/flutter_modular.dart';

import 'about_page.dart';

class AboutModule extends Module {

  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
    ChildRoute('${Modular.initialRoute}about', child: (_, __) => AboutPage()),
  ];

}