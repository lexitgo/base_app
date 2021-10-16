import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScreenDummy extends StatelessWidget{

  final int someInt;

  const ScreenDummy({Key? key, required this.someInt}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dummy"),
      ),
      body: Center(child: Text("Param = $someInt")),
    );
  }

}