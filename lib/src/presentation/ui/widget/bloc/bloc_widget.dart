import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:base_app/src/presentation/bloc/app_bloc.dart';

abstract class WidgetBloc<T extends BlocBase> extends StatelessWidget {
  const WidgetBloc({Key? key}) : super(key: key);

   T findBloc(BuildContext context) {
      return BlocProvider.of<T>(context);
   }

   Widget buildUI(BuildContext context, T bloc);

   ///Don't user build, use buildUI instead
   @override
   @nonVirtual
   Widget build(BuildContext context) {
      return BlocProvider(
         create: (BuildContext context) => findAppBloc(context).dependencies<T>(),
         child: Builder(
           builder: (context) {
             return Builder(
               builder: (context) {
                 return buildUI(context, findBloc(context));
               }
             );
           }
         ),
      );
   }

}
