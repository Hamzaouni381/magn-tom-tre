import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:arrow_pad/arrow_pad.dart';
import 'calibration.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Magnetometer App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Magnetometer App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();

}

class _MyHomePageState extends State<MyHomePage> {
  // nombre de ligne etde collonnes
  int rows = 10;
  int cols = 10;

  // definir la taille de chaque cellule du matrice
  double cellSize = 40;

  // initialiser la matrice par des zero
  List<List<double>> matrix = List.generate(
      10, (i) => List.generate(10, (j) => 0.0));

  // initialiser la position initial selectionée dans la matrice
  int selrow = 0;
  int cursorCol = 0;

  // initialiser l'evenement d'un capteur
   MagnetometerEvent? magEvent;

  // initialisation du captuer et la situation
  void initializeSensor() {
    magnetometerEvents.listen((MagnetometerEvent event) {
      setState(() {
        magEvent = event;
      });
    });
  }

  // Update the matrix and cursor position based on the button press
  List<List<double>> miseajourmatrice(String direction) {
    MagnetometerCalibration magnetometerCalibration=MagnetometerCalibration();
    setState(() {
      if (direction == "left") {
        if (cursorCol > 0) {
          cursorCol--;
        }
      } else if (direction == "right") {
        if (cursorCol < cols - 1) {
          cursorCol++;
        }
      } else if (direction == "up") {
        if (selrow > 0) {
          selrow--;
        }
      } else if (direction == "down") {
        if (selrow < rows - 1) {
          selrow++;
        }
      }
      if (magEvent != null) {
        matrix[selrow][cursorCol] =calculateMagneticValue((magEvent!.x - magnetometerCalibration.magXOffset) / magnetometerCalibration.magXScale, (magEvent!.y - magnetometerCalibration.magYOffset) / magnetometerCalibration.magYScale,(magEvent!.z
            - magnetometerCalibration.magZOffset) / magnetometerCalibration.magZScale);
      }
    });
    return matrix;
  }

  double calculateMagneticValue(double x, double y, double z) {
    return  sqrt(x * x + y * y + z * z);
  }

  @override
  void initState() {
    super.initState();
    initializeSensor();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,

      ),
      body: Column(
        children: [
          Container(
            width: cols * cellSize,
            height: rows * cellSize,
            child: GridView.count(
              crossAxisCount: cols,
              children: List.generate(rows * cols, (index) {
                int row = (index ~/ cols);
                int col = (index % cols);
                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Center(
                    child: Text(matrix[row][col].toStringAsFixed(3)),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: 10),
          ArrowPad(
            height: 130.0,
            width: 130.0,
            innerColor: Colors.grey,
              iconColor: Colors.white,
            arrowPadIconStyle: ArrowPadIconStyle.arrow,
            clickTrigger: ClickTrigger.onTapDown,
            onPressedUp: () =>miseajourmatrice("up"),
            onPressedLeft: () => miseajourmatrice("left"),
            onPressedRight: () =>miseajourmatrice("right"),
            onPressedDown: () => miseajourmatrice("down")),



        ],
      ),
    );
  }
}
