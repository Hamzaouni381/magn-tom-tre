import 'package:flutter/material.dart';
import 'hor_drawer.dart';
class Interface extends StatelessWidget {
  const Interface({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          centerTitle: true,
        ),
        body: Stack(
          children:
            CustomAppBar()
        ),
      ),
    );
  }
}

void main() {
  runApp(Interface());
}
