import 'package:flutter_modular/flutter_modular.dart';

import '../../domain/usecases/login_with_email_and_password_use_case.dart';
import '../../domain/usecases/login_with_google_use_case.dart';
import 'bloc/login_bloc.dart';
import 'login_page.dart';

class LoginModule extends Module {
  @override
  List<Bind> get binds => [
    Bind((i) => LoginWithEmailAndPasswordUseCase(i.get())),
    Bind((i) => LoginWithGoogleUseCase(i.get())),
    Bind((i) => LoginBloc(i.get(), i.get())),
  ];

  @override
  List<ModularRoute> get routes => [
    ChildRoute(Modular.initialRoute, child: (_, __) => const LoginPage()),
  ];
}