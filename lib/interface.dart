import 'package:flutter/material.dart';
import 'hor_drawer.dart';
import 'mon_drawer.dart';
import 'cameraapp.dart';
import 'nouveau.dart';

class Interface extends StatelessWidget {
  const Interface({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children:[
            CameraApp(),
           CustomAppBar(),

            ],
        ),
      ),
    );
  }
}

void main() {
  runApp(Interface());
}
