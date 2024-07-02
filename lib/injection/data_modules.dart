import 'package:dio/dio.dart';
import 'package:flutter_bloc_base/config/constants.dart';
import 'package:flutter_bloc_base/data/remote/api/app_api.dart';
import 'package:flutter_bloc_base/data/remote/exception_mapper.dart';
import 'package:flutter_bloc_base/data/repository/auth_repository_impl.dart';
import 'package:flutter_bloc_base/data/repository/user_repository_impl.dart';
import 'package:flutter_bloc_base/data/storage/shared_pref_manager.dart';
import 'package:flutter_bloc_base/domain/repository/auth_repository.dart';
import 'package:flutter_bloc_base/domain/repository/user_repository.dart';
import 'package:flutter_bloc_base/domain/usecases/usecases.dart';
import 'package:flutter_bloc_base/domain/usecases/user_usecase.dart';
import 'package:flutter_bloc_base/injection/injector.dart';
import 'package:flutter_bloc_base/ui/app/bloc/app_bloc.dart';
import 'package:flutter_bloc_base/ui/login/bloc/login_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/remote/builder/dio_builder.dart';
import '../data/socket/socket_service.dart';

class DataModules {
  static Future<void> inject() async {
    injector.registerLazySingleton<Dio>(
      Dio.new,
    );

    /// Local storage
    injector
      ..registerSingletonAsync<SharedPreferences>(() async {
        return SharedPreferences.getInstance();
      })
      ..registerLazySingleton<SharedPreferencesManager>(
        () => SharedPreferencesManager(injector.get<SharedPreferences>()),
      )

      /// Network client
      ..registerLazySingleton<AppApi>(
        () => AppApi(
          DioBuilder.getInstance(),
          baseUrl: Constants.shared().endpoint,
        ),
      )

      ///Socket
      ..registerLazySingleton<SocketService>(
        SocketService.new,
      )
      ..registerFactory<ExceptionMapper>(
        ExceptionMapper.new,
      );

    /// Repository
    registerRepository();

    /// UsesCase
    registerUsesCase();

    registerBloc();
  }

  static void registerRepository() {
    injector.registerFactory<AuthRepository>(AuthRepositoryImpl.new);
    injector.registerFactory<UserRepository>(
      () => UserRepositoryImpl(injector.get<ExceptionMapper>()),
    );
  }

  static void registerUsesCase() {
    injector.registerFactory<AuthUseCase>(
      () => AuthUseCase(injector.get<AuthRepository>()),
    );
    injector.registerFactory<UserUseCase>(
      () => UserUseCase(injector.get<UserRepository>()),
    );
  }

  static void registerBloc() {
    injector.registerLazySingleton<AppBloc>(AppBloc.new);
    injector.registerFactory<LoginBloc>(
      () => LoginBloc(injector.get<AuthUseCase>()),
    );
  }
}
