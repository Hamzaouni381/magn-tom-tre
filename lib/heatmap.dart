import 'dart:math';

import 'package:flutter/material.dart';

import 'package:fl_heatmap/fl_heatmap.dart';
import 'matrice.dart';
void main() => runApp((ExampleApp()));

class ExampleApp extends StatefulWidget {
  @override
  _ExampleState createState() => _ExampleState();
}

class _ExampleState extends State<ExampleApp> {
  HeatmapItem? selectedItem;

  late HeatmapData heatmapData;

  @override
  void initState() {
    _initExampleData();
    super.initState();
  }

  void _initExampleData() {
    MyHomePage A =MyHomePage();
    Future List<List<double>> data =   A.getMagneticField();
    final int l = data.elementAt(0).length;
    final int c = data.length;

    List<String> rows = [];
    List<String> columns = [];
    for (int i = 1; i <= l; i++) {
      columns.add(i.toString());
    }

    for (int j = 1; j <= c; j++) {
      rows.add(j.toString());
    }

    const String unit = '(Tesla) ';
    heatmapData = HeatmapData(rows: rows, columns: columns, items: [
      for (int row = 0; row < rows.length; row++)
        for (int col = 0; col < columns.length; col++)
          HeatmapItem(
              value: data[row][col],
              unit: unit,
              xAxisLabel: columns[col],
              yAxisLabel: rows[row]),
    ]);
  }

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
        appBar: AppBar(
          title: const Text('Heatmap Example '),
        ),
        body: SingleChildScrollView(
          child: Column(
              children: [
              const SizedBox(height: 16),
          Text(title, textScaleFactor: 1.4),
          Text(subtitle),
          const SizedBox(height: 8),
            Heatmap(
                onItemSelectedListener: (HeatmapItem? selectedItem) {
                  setState(() {
                    this.selectedItem = selectedItem;
                  });
                },
                heatmapData: heatmapData)
            ],
          ),
        ),
      ),
    );
  }
}