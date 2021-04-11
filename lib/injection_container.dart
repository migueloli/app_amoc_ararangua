import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'core/network/network_info_implementation.dart';
import 'features/data/datasources/accounts_remote_data_source.dart';
import 'features/data/repositories/accounts_repository_implementation.dart';
import 'features/domain/usecases/get_accounts_usecase.dart';
import 'features/presentation/home/bloc/home_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  /* Utilities */
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton(() => NetworkInfoImplementation(sl()));

  /* Data Sources */
  sl.registerLazySingleton(() => AccountsRemoteDataSourceImplementation(sl()));

  /* Repositories */
  sl.registerLazySingleton(
    () => AccountsRepositoryImplementation(
      sl(),
      sl(),
    ),
  );

  sl.registerLazySingleton(() => GetAccountsUseCase(sl()));

  /* Blocs */
  sl.registerFactory(
    () => HomeBloc(
      getAccountUseCase: sl(),
    ),
  );
}