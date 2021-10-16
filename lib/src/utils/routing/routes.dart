import 'package:equatable/equatable.dart';

enum pushTypes {removeAll,replace,common}
enum authTypes {requiredLogOut,requiredLogIn,noCare}

class _Routes {
  static const String Login='/auth';
  static const String Home='/';
  static const String Route404='/404';
  static const String Dummy='/dummy';
}

abstract class BaseRoute extends Equatable {

  final String nameOfRoute;
  final pushTypes pushType;
  final authTypes authType;

  const BaseRoute(this.nameOfRoute,{this.pushType=pushTypes.common,this.authType=authTypes.requiredLogIn});

  @override
  List<Object?> get props => [nameOfRoute,pushType];
}

class RouteHome extends BaseRoute {

  static const name=_Routes.Home;
  const RouteHome() : super(name, pushType: pushTypes.removeAll);
}

class RouteLogin extends BaseRoute {

  static const name=_Routes.Login;
  const RouteLogin() : super(name, pushType: pushTypes.removeAll,authType: authTypes.requiredLogOut);
}

class Route404 extends BaseRoute {

  static const name=_Routes.Route404;
  const Route404() : super(name, authType: authTypes.noCare);
}

class RouteDummy extends BaseRoute {
  final int someInt;

  static const name=_Routes.Dummy;
  const RouteDummy(this.someInt) : super(name);
}
