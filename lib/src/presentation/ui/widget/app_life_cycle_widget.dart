import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WidgetAppLifecycle extends StatefulWidget {
  final Widget child;
  const WidgetAppLifecycle({required this.child }) : super();

  @override
  _WidgetAppLifecycleState createState() => _WidgetAppLifecycleState();
}


class _WidgetAppLifecycleState extends State<WidgetAppLifecycle> with WidgetsBindingObserver {
  //AppLifecycleState _notification;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        if (kDebugMode) print("app in resumed");
        break;
      case AppLifecycleState.inactive:
        if (kDebugMode) print("app in inactive");
        break;
      case AppLifecycleState.paused:
        if (kDebugMode) print("app in paused");
        break;
      case AppLifecycleState.detached:
        if (kDebugMode) print("app in detached");
        break;
    }
  }

  @override
  initState() {
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}