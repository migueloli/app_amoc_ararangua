import 'package:app_amoc_ararangua/features/domain/usecases/create_account_with_google_use_case.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../domain/usecases/create_account_with_email_and_password_use_case.dart';
import 'bloc/create_account_bloc.dart';
import 'create_account_page.dart';


class LoginModule extends Module {
  @override
  List<Bind> get binds => [
    Bind((i) => CreateAccountWithEmailAndPasswordUseCase(i.get())),
    Bind((i) => CreateAccountWithGoogleUseCase(i.get())),
    Bind((i) => CreateAccountBloc(i.get(), i.get())),
  ];

  @override
  List<ModularRoute> get routes => [
    ChildRoute(Modular.initialRoute, child: (_, __) => const CreateAccountPage()),
  ];
}