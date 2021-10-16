import 'package:flutter/material.dart';
import 'package:base_app/src/utils/routing/routes.dart';

class RouteParser extends RouteInformationParser<BaseRoute> {
  @override
  Future<BaseRoute> parseRouteInformation(
      RouteInformation routeInformation) async {
    switch (routeInformation.location) {
      case RouteHome.name:
        return const RouteHome();
      case RouteLogin.name:
        return const RouteLogin();
      case RouteDummy.name:
        return _redirectHome();
      default:
        return const Route404();
    }
  }

  BaseRoute _redirectHome() {
    return const RouteHome();
  }

  @override
  // ignore: avoid_renaming_method_parameters
  RouteInformation restoreRouteInformation(BaseRoute data) {
    return RouteInformation(location: data.nameOfRoute);
  }
}