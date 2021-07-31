import 'package:flutter_modular/flutter_modular.dart';

import 'bloc/profile_bloc.dart';
import 'profile_page.dart';

class ProfileModule extends Module {

  @override
  List<Bind> get binds => [
    Bind((i) => ProfileBloc())
  ];

  @override
  List<ModularRoute> get routes => [
    ChildRoute('${Modular.initialRoute}profile', child: (_, __) => ProfilePage()),
  ];

}