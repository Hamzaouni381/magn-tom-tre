import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

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
  int rows = 5;
  int cols = 5;

  // definir la taille de chaque cellule du matrice
  double cellSize = 70;

  // initialiser la matrice par des zero
  List<List<double>> matrix = List.generate(
      5, (i) => List.generate(5, (j) => 0.0));

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
  void miseajourmatrice(String direction) {
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
        matrix[selrow][cursorCol] =
            sqrt(magEvent!.x*magEvent!.x + magEvent!.y*magEvent!.y + magEvent!.z* magEvent!.z);
      }
    });
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
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color:Colors.blueAccent,
                  ),
                  child: IconButton(
                    color:Colors.white,
                    icon: const Icon(Icons.arrow_left),
                    onPressed: () {
                      miseajourmatrice("left");
                    },
                  ),
                ),
                const SizedBox(width: 20),
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color:Colors.blueAccent,
                  ),
                  child: IconButton(
                    color:Colors.white,
                    icon: const Icon(Icons.arrow_upward),
                    onPressed: () {
                      miseajourmatrice("up");
                    },
                  ),
                ),
                const SizedBox(width: 20),
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color:Colors.blueAccent,
                  ),
                  child: IconButton(
                    color:Colors.white,
                    icon: const Icon(Icons.arrow_downward),
                    onPressed: () {
                      miseajourmatrice("down");
                    },
                  ),
                ),
                const SizedBox(width: 20),
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color:Colors.blueAccent,
                  ),
                  child: IconButton(
                    color:Colors.white,
                    icon: const Icon(Icons.arrow_right),
                    onPressed: () {
                      miseajourmatrice("right");
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
