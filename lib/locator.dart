import 'package:clean_arc_flutter/features/home/domain/usecases/load_data.dart';
import 'package:clean_arc_flutter/features/login/data/datasources/login_data_source.dart';
import 'package:clean_arc_flutter/features/login/data/repositories/login_repositories_impl.dart';
import 'package:clean_arc_flutter/features/login/domain/repositories/login_repositories.dart';
import 'package:clean_arc_flutter/features/login/domain/usecases/login_usecase.dart';
import 'package:clean_arc_flutter/features/login/domain/usecases/logout_usecase.dart';
import 'package:get_it/get_it.dart';
import 'package:clean_arc_flutter/core/constants/api_constants.dart';
import 'package:clean_arc_flutter/features/home/presentation/bloc/home_bloc.dart';

import 'core/network/api_client.dart';
import 'features/home/data/datasources/home_data_source.dart';
import 'features/home/data/repositories/home_repositories_impl.dart';
import 'features/home/domain/repositories/home_repositories.dart';
import 'features/login/presentation/bloc/login_bloc.dart';
import 'features/signup/data/datasources/signup_data_source.dart';
import 'features/signup/data/repositories/signup_repositories_impl.dart';
import 'features/signup/domain/repositories/signup_repositories.dart';
import 'features/signup/domain/usecases/signup_usecase.dart';
import 'features/signup/presentation/bloc/signup_bloc.dart';

final locator = GetIt.instance;

Future<void> initDependencies() async {
  // Api Client
  locator.registerLazySingleton<ApiClient>(() => ApiClient(baseUrl: ApiConstants.baseUrl));

  // Login
  locator.registerLazySingleton<LoginDataSource>(() => LoginDataSourceImpl(apiClient: locator()));
  locator.registerLazySingleton<LoginRepositories>(() => LoginRepositoriesImpl(locator()));
  locator.registerLazySingleton<LoginUseCase>(() => LoginUseCase(locator()));
  locator.registerLazySingleton<LogoutUseCase>(() => LogoutUseCase(locator()));
  locator.registerFactory<LoginBloc>(() => LoginBloc(loginUseCase: locator(),logoutUseCase: locator()));

  // Signup
  locator.registerLazySingleton<SignupDataSource>(() => SignupDataSourceImpl(apiClient: locator()));
  locator.registerLazySingleton<SignupRepositories>(() => SignupRepositoriesImpl(locator()));
  locator.registerLazySingleton<SignupUseCase>(() => SignupUseCase(locator()));
  locator.registerFactory<SignupBloc>(() => SignupBloc(signupUseCase: locator()));

  // Home
  locator.registerLazySingleton<HomeDataSource>(() => HomeDataSourceImpl( locator()));
  locator.registerLazySingleton<HomeRepositories>(() => HomeRepositoriesImpl(locator()));
  locator.registerLazySingleton<LoadData>(() => LoadData(locator()));
  locator.registerFactory<HomeBloc>(() => HomeBloc(locator()));


}