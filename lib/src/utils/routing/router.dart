import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:base_app/src/presentation/bloc/app_bloc.dart';
import 'package:base_app/src/presentation/bloc/nav_bloc.dart';
import 'package:base_app/src/presentation/ui/screens/home/screen_dummy.dart';
import 'package:base_app/src/presentation/ui/screens/home_screen.dart';
import 'package:base_app/src/presentation/ui/screens/login_screen.dart';
import 'package:base_app/src/utils/routing/routes.dart';

class AppRouterDelegate extends _AppRouterDelegate {

  AppRouterDelegate(AppBloc appBloc) : super(appBloc) {
    _currentPages=[
      if (appBloc.session.value==null) _createPage(const ScreenLogin(), const RouteLogin())
      else _createPage(const ScreenHome(), const RouteHome())
    ];
  }

  @override
  MaterialPage _getPageFromRoute(BaseRoute route) {
    if (route is RouteHome) {
      return _createPage(
          const ScreenHome(),route
      );
    } else if (route is RouteLogin) {
      return _createPage(
          const ScreenLogin(),route
      );
    } else if (route is RouteDummy) {
      return _createPage(
          ScreenDummy(someInt: route.someInt),route
      );
    } else {
      return _createPage(
          const Text("404"),route
      );
    }
  }

  redirectToAuth() {
    _pushPage(const RouteLogin(),removeAll: true);
    if (kDebugMode) print("redirected to"+RouteLogin.name);
    notifyListeners();
  }

  redirectToHome() {
    _pushPage(const RouteHome(),removeAll: true);
    if (kDebugMode) print("redirected to"+RouteHome.name);
    notifyListeners();
  }

  @override
  _pushPage(BaseRoute route, {bool? replace,bool? removeAll}) {

    if (route.authType==authTypes.requiredLogIn && appBloc.session.value==null) {
      redirectToAuth();
      return;
    } else if (route.authType==authTypes.requiredLogOut && appBloc.session.value!=null) {
      redirectToHome();
      return;
    }


    var page = _getPageFromRoute(route);

    removeAll = removeAll ?? route.pushType==pushTypes.removeAll;
    replace = replace ?? route.pushType==pushTypes.replace;

    if (route==(_currentPages.last.arguments as BaseRoute)) {
      return;
    }

    if (kDebugMode) print("nav pushed ${(removeAll) ? "removed all " : ""}${(replace) ? "replaced " : ""}"+route.nameOfRoute);

    if (removeAll) {
      _currentPages.clear();
    } else if (replace) {
      _currentPages.removeLast();
    }
    _currentPages.add(page);
  }

  @override
  _removePage(Page? page) {
    if (page != null) {
      _currentPages.remove(page);
      if (kDebugMode) print("nav popped to "+(_currentPages.last.arguments as BaseRoute).nameOfRoute);
    }
  }

  @override
  _showSnack(BuildContext context,{required String text, Color? color}) {
    var snack = SnackBar(
      backgroundColor: color,
      content: Text(text),
    );

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snack);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: navigator,
      child: BlocConsumer<BlocNav,BlocNavState>(
        listenWhen: (prev,next) {
          //if (next is BlocNavNavigatingToRoute) print(next.runtimeType.toString()+" "+next.route.nameOfRoute);
          return (next is BlocNavNavigating);
        },
        listener: (context, state) {
          if (state is BlocNavNavigateToReplace) {
            _pushPage(state.route,replace: true,removeAll: false);
          } else if (state is BlocNavNavigateToRemove) {
            _pushPage(state.route,removeAll: true,replace: false);
          } else if (state is BlocNavNavigateToPush) {
            _pushPage(state.route,replace: false, removeAll: false);
          } else if (state is BlocNavNavigateToDefault) {
            _pushPage(state.route);
          } else if (state is BlocNavShowSnackBar) {
            _showSnack(context,text: state.text);
          } else if (state is BlocNavPop) {
            _pop();
          }

          notifyListeners();
        },
        buildWhen: (prev,next) {
          return (next is BlocNavNavigating);
        },
        builder: (context,state) {
          return Navigator(
            key: navigatorKey,
            pages: _buildList(),
            onPopPage: _onPopPage,
          );
        }
      ),
    );
  }

  static MaterialPage _createPage(Widget screen,BaseRoute route) {
    return MaterialPage(
      name: route.nameOfRoute,
      key: ValueKey(route.nameOfRoute),
      arguments: route,
      child: Builder(
        builder: (context) => screen,
      ),
    );
  }

}


abstract class _AppRouterDelegate extends RouterDelegate<BaseRoute>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<BaseRoute> {

  @override
  @nonVirtual
  final GlobalKey<NavigatorState> navigatorKey;

  final AppBloc appBloc;

  BlocNav get navigator => appBloc.navigator;

  _AppRouterDelegate(this.appBloc) : navigatorKey = GlobalKey<NavigatorState>();

  @override
  @nonVirtual
  BaseRoute get currentConfiguration => _currentPages.last.arguments as BaseRoute;

  late final List<Page> _currentPages;

  @nonVirtual
  List<Page> _buildList() {
    List<Page> pages = [];
    pages.addAll(_currentPages);
    return pages;
  }

  MaterialPage _getPageFromRoute(BaseRoute route);

  _pushPage(BaseRoute route, {bool? replace,bool? removeAll});

  _removePage(Page? page);

  _showSnack(BuildContext context,{required String text, Color? color});

  void _pop() {
    if (_canPop()) {
      _removePage(_currentPages.last);
    }
  }

  bool _canPop() {
    return _currentPages.length > 1;
  }

  bool _onPopPage(Route<dynamic> route, result) {
    // 1
    final didPop = route.didPop(result);
    if (!didPop) {
      return false;
    }
    // 2
    if (_canPop()) {
      _pop();
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context);

  @override
  Future<bool> popRoute() {
    if (_canPop()) {
      _removePage(_currentPages.last);
      return Future.value(true);
    }
    return Future.value(false);
  }

  @override
  Future<void> setNewRoutePath(BaseRoute path) async {
    navigator.goTo(path);
  }

  @override
  void dispose() {
    appBloc.close();
    super.dispose();
  }

}