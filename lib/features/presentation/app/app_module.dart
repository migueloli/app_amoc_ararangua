import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../core/network/network_info_implementation.dart';
import '../../data/datasources/accounts_remote_datasource_implementation.dart';
import '../../data/repositories/accounts_repository_implementation.dart';
import '../home/home_module.dart';
import '../login/login_module.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
    Bind((i) => InternetConnectionChecker()),
    Bind((i) => NetworkInfoImplementation(i.get())),
    Bind((i) => FirebaseFirestore.instance),
    Bind((i) => FirebaseAuth.instance),
    Bind((i) => GoogleSignIn()),
    Bind((i) => AccountsRemoteDataSourceImplementation(i.get(), i.get(), i.get())),
    Bind((i) => AccountsRepositoryImplementation(i.get(), i.get())),
  ];

  @override
  List<ModularRoute> get routes => [
    ModuleRoute(Modular.initialRoute, module: HomeModule()),
    ModuleRoute("${Modular.initialRoute}login", module: LoginModule()),
  ];

}