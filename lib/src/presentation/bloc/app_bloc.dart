import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:base_app/src/domain/entities/session_entity.dart';
import 'package:base_app/src/domain/interactors/session_interactor.dart';
import 'package:base_app/src/extensions/rx_ext.dart';
import 'package:base_app/src/utils/routing/routes.dart';

import 'nav_bloc.dart';

class AppBlocState {

}

AppBloc findAppBloc(BuildContext context) {
  ///Use only inside AppBloc provider
  return BlocProvider.of<AppBloc>(context);
}

class AppBloc extends Cubit<AppBlocState> {

  final InteractorSession _interactorSession;
  final GetIt dependencies;
  final BlocNav navigator;

  late final StreamSubscription subsSession;

  AppBloc(this._interactorSession,this.navigator,this.dependencies) : super(AppBlocState()) {
    subsSession=session.listen((session) {
      if (session==null) {
        navigator.goTo(const RouteLogin());
      }
    });
  }

  Rxv<EntitySession?> get session => _interactorSession.session;

  logOut() async {
    await _interactorSession.logoutUser();
  }

  @override
  Future<void> close() {
    _interactorSession.close();
    navigator.close();
    subsSession.cancel();
    return super.close();
  }

}