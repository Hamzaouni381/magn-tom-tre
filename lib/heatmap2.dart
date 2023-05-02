import 'dart:math';
import 'package:arrow_pad/arrow_pad.dart';
import 'package:flutter/material.dart';
import 'package:fl_heatmap/fl_heatmap.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'calibration.dart';
void main() => runApp(HeatMapApp());

class HeatMapApp extends StatefulWidget {
  @override
  _HeatMapState createState() => _HeatMapState();
}

class _HeatMapState extends State<HeatMapApp> {
  HeatmapItem? selectedItem;
  late HeatmapData heatmapData;
  MagnetometerEvent? magEvent;
  List<List<double>> matrix = List.generate(
      10, (i) => List.generate(10, (j) => 0.0));
  // initialiser la position initial selectionée dans la matrice
  int selrow = 1;
  int cursorCol = 1;
  // nombre de ligne et de collonnes
  int rows = 9;
  int cols = 9;

  // Update the matrix and cursor position based on the button press
  void miseajourmatrice(String direction) {
    MagnetometerCalibration magnetometerCalibration = MagnetometerCalibration();
    if (magEvent != null) {
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
        matrix[selrow][cursorCol] = calculateMagneticValue(
          (magEvent!.x - magnetometerCalibration.magXOffset) / magnetometerCalibration.magXScale,
          (magEvent!.y - magnetometerCalibration.magYOffset) / magnetometerCalibration.magYScale,
          (magEvent!.z - magnetometerCalibration.magZOffset) / magnetometerCalibration.magZScale,
        );

        List<HeatmapItem> items = [];
        for (int row = 0; row < rows; row++) {
          for (int col = 0; col < cols; col++) {
            items.add(
              HeatmapItem(
                value: matrix[row][col],
                unit: unit,
                xAxisLabel: (col + 1).toString(),
                yAxisLabel: (row + 1).toString(),
              ),
            );
          }
        }

        heatmapData = HeatmapData(
          rows: List.generate(rows, (index) => (index + 1).toString()),
          columns: List.generate(cols, (index) => (index + 1).toString()),
          items: items,
          colorPalette: colorPaletteTemperature,
        );
      });
    }
    print(matrix[selrow][cursorCol]);
  }


  double calculateMagneticValue(double x, double y, double z) {
    return sqrt(x * x + y * y + z * z);
  }

  @override
  void initState() {
    _initHeatMapData();
    super.initState();
  }

  Future<void> _initHeatMapData() async {
    magnetometerEvents.listen((MagnetometerEvent event) {
      setState(() {
        magEvent = event;
      });
    });
    final int l = matrix.elementAt(0).length;
    final int c = matrix.length;
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
              value:   matrix[row][col],
              unit: unit,
              xAxisLabel: columns[col],
              yAxisLabel: rows[row],
            ),
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
        ),
      ),
    );
  }
}
