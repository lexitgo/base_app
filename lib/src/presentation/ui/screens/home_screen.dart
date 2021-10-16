import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:base_app/src/presentation/bloc/home_bloc.dart';
import 'package:base_app/src/presentation/ui/widget/bloc/bloc_widget.dart';
import 'package:base_app/src/utils/locale_helper/l10n.dart';

class ScreenHome extends WidgetBloc<BlocHome> {
  const ScreenHome({Key? key}) : super(key: key);

  @override
  Widget buildUI(BuildContext context, BlocHome bloc) {
    return Scaffold(
      appBar: AppBar(
        title: Text(HelperLocale.of(context).ScreenTitle_Home),
      ),
      body: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                      onPressed: () {
                       bloc.gotoDummy();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            children: [
                              Text(HelperLocale.of(context).home_goDummy)
                            ],
                          ),
                        ),
                      )
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.logout),
        onPressed: () async {
          findBloc(context).logOut();
        },
      ),
    );
  }

}