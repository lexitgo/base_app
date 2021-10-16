import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:base_app/src/presentation/bloc/base/common_bloc_state.dart';
import 'package:base_app/src/presentation/bloc/login_bloc.dart';
import 'package:base_app/src/presentation/ui/widget/bloc/bloc_widget.dart';
import 'package:base_app/src/utils/locale_helper/l10n.dart';

class ScreenLogin extends WidgetBloc<BlocLogin> {
  const ScreenLogin({Key? key}) : super(key: key);

  @override
  Widget buildUI(BuildContext context, BlocLogin bloc) {
    return Scaffold(
      body: BlocBuilder<BlocLogin,BlocCommonState>(
        builder: (context,state) {
          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top:28.0),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IntrinsicWidth(
                        child: Column(
                          //mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(HelperLocale.of(context).appName,style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold)),
                            const SizedBox(height: 15),
                            _buildButton(context,HelperLocale.of(context).ScreenTitle_Login,Icons.login, () {
                              bloc.authAnonymous();
                            }),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              AnimatedSwitcher(duration: const Duration(milliseconds: 380),
                  child:  (state is BlocCommonStateLoading) ? Container(
                color: Colors.black45,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ) : const SizedBox(height: 0))
            ],
          );
        }
      ),
    );
  }

  Widget _buildButton(BuildContext context, String title, IconData icon, Function() callback) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
          onPressed: () {
            if (findBloc(context).state is BlocCommonStateLoaded) callback();
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Icon(icon),
                  SizedBox(width: 10),
                  Text(title)
                ],
              ),
            ),
          )
        ),
    );
  }

}