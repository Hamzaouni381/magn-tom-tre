import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fl_heatmap/fl_heatmap.dart';
import 'new.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'calibration.dart';
void main() => runApp((HeatMapApp2()));

class HeatMapApp2 extends StatefulWidget {
  @override
  _HeatMapState createState() => _HeatMapState();
}

class _HeatMapState extends State<HeatMapApp2> {
  HeatmapItem? selectedItem;
  late HeatmapData heatmapData;
  MagnetometerEvent? magEvent;
  List<List<double>> matrix = List.generate(
      10, (i) => List.generate(10, (j) => 0.0));
  List<List<double>> valeurs = List.generate(
      10, (i) => List.generate(10, (j) => 0.0));
  // initialiser la position initial selectionée dans la matrice
  int selrow = 0;
  int cursorCol = 0;
  // nombre de ligne etde collonnes
  int rows = 10;
  int cols = 10;

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
    _initHeatMapData();
    super.initState();
  }
  /*void initializeSensor() {
    magnetometerEvents.listen((MagnetometerEvent event) {
      setState(() {
        magEvent = event;
      });
    });
  }*/

  void _initHeatMapData() async{
    magnetometerEvents.listen((MagnetometerEvent event) {
      setState(() {
        magEvent = event;
      });
    });
    MyHomePage a =MyHomePage(title: 'Magnetometer App');
    List<List<double>> valeurs = (await miseajourmatrice) as List<List<double>> ;

    final int l = valeurs.elementAt(0).length;
    final int c = valeurs.length;
    List<String> rows = [];
    List<String> columns = [];
    for (int i = 1; i <= l; i++) {
      columns.add(i.toString());
    }
    for (int j = 1; j <= c; j++) {
      rows.add(j.toString());
    }

    List<Color> colorPalette = colorPaletteTemperature;

    heatmapData = HeatmapData(
      rows: rows,
      columns: columns,
      items: [
        for (int row = 0; row < rows.length; row++)
          for (int col = 0; col < columns.length; col++)
            HeatmapItem(
                value: valeurs[row][col],
                unit: unit,
                xAxisLabel: columns[col],
                yAxisLabel: rows[row]),
      ],
      colorPalette: colorPalette,
    );
  }

  String unit = '(Tesla) ';

  @override
  Widget build(BuildContext context) {
    final title = selectedItem != null
        ? 'Value = ${selectedItem!.value.toStringAsFixed(10)} ${selectedItem!.unit}'
        : 'Value = --- ${heatmapData.items.first.unit}';
    final subtitle = selectedItem != null
        ? 'Position = [${selectedItem!.xAxisLabel},${selectedItem!.yAxisLabel}]'
        : 'Position = [-,-]';
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 200),
              Heatmap(
                  onItemSelectedListener: (HeatmapItem? selectedItem) {
                    setState(() {
                      this.selectedItem = selectedItem;
                    });
                  },
                  heatmapData: heatmapData),
              Text(title, textScaleFactor: 1.4),
              Text(subtitle),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}