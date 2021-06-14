import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../core/network/network_info_implementation.dart';
import '../../data/datasources/accounts_remote_data_source.dart';
import '../../data/repositories/accounts_repository_implementation.dart';
import '../about/about_module.dart';
import '../create_account/create_account_module.dart';
import '../home/home_module.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
    Bind((i) => InternetConnectionChecker()),
    Bind((i) => NetworkInfoImplementation(i.get())),
    Bind((i) {
      var dio = Dio(
        BaseOptions(
          baseUrl: 'http://192.168.0.100:8081/api/v1/',
          headers: {
            Headers.contentTypeHeader: Headers.jsonContentType
          }
        )
      );

      dio.interceptors.add(LogInterceptor(
        requestBody: true, responseBody: true
      ));

      return dio;
    }),
    Bind((i) => AccountsRemoteDataSourceImplementation(i.get())),
    Bind((i) => AccountsRepositoryImplementation(i.get(), i.get()))
  ];

  @override
  List<ModularRoute> get routes => [
    ModuleRoute(Modular.initialRoute, module: HomeModule()),
    ModuleRoute(Modular.initialRoute, module: CreateAccountModule()),
    ModuleRoute(Modular.initialRoute, module: AboutModule()),
  ];

}