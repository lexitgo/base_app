import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:base_app/src/data/api/api_service.dart';
import 'package:base_app/src/data/repos/users_repo.dart';
import 'package:base_app/src/domain/i_repo/i_users_repo.dart';
import 'package:base_app/src/domain/interactors/home_interactor.dart';
import 'package:base_app/src/domain/interactors/login_interactor.dart';
import 'package:base_app/src/domain/interactors/session_interactor.dart';
import 'package:base_app/src/presentation/bloc/app_bloc.dart';
import 'package:base_app/src/presentation/bloc/home_bloc.dart';
import 'package:base_app/src/presentation/bloc/login_bloc.dart';
import 'package:base_app/src/presentation/bloc/nav_bloc.dart';

class HelperDependency {

  GetIt dependencies = GetIt.instance;

  initDependencies() {
    try {
      _registerHelpers();
      _registerData();
      _registerInteractors();
      _registerAppBloc();
      _registerBlocs();
      _registerOther();
    } catch (e,s) {
      if (kDebugMode) {
        print("dependencies error");
        print(s);
      }
    }
  }

  void _registerHelpers() {

  }

  void _registerData() {
    gRegisterSingleton<ApiService>( () =>
        ApiService()
    );
    gRegisterSingleton<IRepoUsers>( () =>
        RepoUsers(dependencies())
    );

  }

  void _registerInteractors() {
    gRegisterSingleton<InteractorSession>( () =>
        InteractorSession(
            repo:dependencies()
        )
    );
    gRegisterFactory<InteractorLogin>( () =>
        InteractorLogin(
            repo:dependencies()
        )
    );
    gRegisterFactory<InteractorHome>( () =>
        InteractorHome()
    );
  }

  void _registerAppBloc() {
    gRegisterFactory<BlocNav>( () =>
        BlocNav()
    );
    gRegisterSingletonLazy<AppBloc>( () =>
        AppBloc(dependencies(),dependencies(),dependencies)
    );
  }

  void _registerBlocs() {
    gRegisterFactory<BlocLogin>( () =>
        BlocLogin(
            appBloc:dependencies(), interactor:dependencies()
        )
    );
    gRegisterFactory<BlocHome>( () =>
        BlocHome(
            appBloc:dependencies(), interactor:dependencies()
        )
    );
  }

  void _registerOther() {

  }

  gRegisterFactory<T extends Object>(T Function() creator) {
    dependencies.registerFactory<T>(creator);
  }

  gRegisterFactoryParam<T extends Object, T2, T3>(T Function(T2,T3) creator) {
    dependencies.registerFactoryParam<T, T2, T3>(creator);
  }

  gRegisterSingleton<T extends Object>(T Function() creator) {
    dependencies.registerSingleton<T>(creator());
  }

  gRegisterSingletonLazy<T extends Object>(T Function() creator) {
    dependencies.registerLazySingleton<T>(creator);
  }


}

