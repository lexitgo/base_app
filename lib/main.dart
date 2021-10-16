import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:base_app/src/presentation/bloc/app_bloc.dart';
import 'package:base_app/src/presentation/ui/widget/app_life_cycle_widget.dart';
import 'package:base_app/src/utils/dependency_helper.dart';
import 'package:base_app/src/utils/locale_helper/l10n.dart';
import 'package:base_app/src/utils/routing/parser.dart';
import 'package:base_app/src/utils/routing/router.dart';
import 'package:base_app/src/utils/theme_helper.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var dependencyHelper=HelperDependency();
  await dependencyHelper.initDependencies();

  runApp(BaseApp(dependencyHelper));
}

// ignore: camel_case_types
class BaseApp extends StatelessWidget {

  final HelperDependency dependencyHelper;

  const BaseApp(this.dependencyHelper, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => dependencyHelper.dependencies<AppBloc>(),
      child: BlocBuilder<AppBloc,AppBlocState>(builder: (cont,state) {
          return MaterialApp.router(
            builder: (cnt,Widget? widget) {
              return WidgetAppLifecycle(
                  child: widget ?? const SizedBox()
              );
            },
            theme: HelperTheme.theme,
            supportedLocales: HelperLocale.delegate.supportedLocales,
            localizationsDelegates: const [
              HelperLocale.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            title: "RosLink",
            routerDelegate: AppRouterDelegate(
                dependencyHelper.dependencies<AppBloc>()
            ),
            routeInformationParser: RouteParser(),
            debugShowCheckedModeBanner: false,
          );
        }
      ),
    );
  }
}

