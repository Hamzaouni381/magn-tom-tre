import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';
import 'package:sensors_plus/sensors_plus.dart';

class Browse extends StatefulWidget {
  const Browse({Key? key}) : super(key: key);

  @override
  State<Browse> createState() => _BrowseState();
}

class _BrowseState extends State<Browse> {
  // definir la taille de la matrice
  int row = 5;
  int col = 5;
  // definir la taille de chaque cellule
  double cellSize = 50;

  // initialiser la matrice
  List<List<double>> matrix = List.generate(
      5, (i) => List.generate(5, (j) => 0.0));
  @override
  Widget build(BuildContext context) {
    return const ;
  }
}
