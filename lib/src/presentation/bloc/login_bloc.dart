import 'dart:async';
import 'package:base_app/src/domain/interactors/login_interactor.dart';
import 'package:base_app/src/utils/routing/routes.dart';
import 'app_bloc.dart';
import 'base/common_bloc.dart';
import 'base/common_bloc_state.dart';

class BlocLogin extends BlocCommon {

  late InteractorLogin _interactor;
  AppBloc appBloc;

  StreamSubscription? subsSession;
  Timer? loadingTimeoutTimer;

  BlocLogin({required InteractorLogin interactor,required this.appBloc}) : super(BlocCommonStateLoaded()) {
    _interactor=interactor;
    if (appBloc.session.value!=null) {
      appBloc.navigator.goTo(RouteHome());
    } else {
      subsSession=appBloc.session.listen((session) {
        auth();
      });

    }
  }

  authAnonymous() async {
    emit(BlocCommonStateLoading());
    loadingTimeoutTimer=Timer(const Duration(seconds: 15),() {
      emit(BlocCommonStateLoaded());
    });
    if (!auth()) {
      //await _interactor.auth();
    }
  }

  bool auth() {
    if (appBloc.session.value!=null) {
      appBloc.navigator.goTo(RouteHome());
      return true;
    }
    else {
      return false;
    }
  }

  @override
  Future<void> close() {
    subsSession?.cancel();
    loadingTimeoutTimer?.cancel();
    return super.close();
  }

}