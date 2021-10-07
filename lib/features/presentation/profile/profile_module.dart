import 'package:app_amoc_ararangua/features/presentation/profile/bloc/profile_page_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'bloc/profile_bloc.dart';
import 'bloc/save_profile_bloc.dart';
import 'profile_page.dart';

class ProfileModule extends Module {
  @override
  List<Bind> get binds => [
    Bind((i) => ProfilePageBloc()),
    Bind((i) => SaveProfileBloc(i.get())),
    Bind((i) => ProfileBloc(i.get(), i.get())),
  ];

  @override
  List<ModularRoute> get routes => [
    ChildRoute(Modular.initialRoute, child: (_, __) => const ProfilePage()),
  ];
}