import 'dart:async';
import 'package:base_app/src/domain/interactors/home_interactor.dart';
import 'package:base_app/src/utils/routing/routes.dart';
import 'app_bloc.dart';
import 'base/common_bloc.dart';
import 'base/common_bloc_state.dart';

class BlocHome extends BlocCommon  {

  late InteractorHome _interactor;
  AppBloc appBloc;

  BlocHome({required InteractorHome interactor,required this.appBloc}) : super(BlocCommonStateLoaded()) {
    _interactor=interactor;
  }

  gotoDummy() {
    appBloc.navigator.goTo(const RouteDummy(20));
  }

  logOut() {
    appBloc.logOut();
  }

  @override
  Future<void> close() {
    return super.close();
  }

}