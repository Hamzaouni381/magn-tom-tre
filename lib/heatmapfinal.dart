import 'package:flutter/material.dart';
import 'package:fl_heatmap/fl_heatmap.dart';

void main() => runApp((HeatMapApp()));

class HeatMapApp extends StatefulWidget {
  @override
  _HeatMapState createState() => _HeatMapState();
}

class _HeatMapState extends State<HeatMapApp> {
  HeatmapItem? selectedItem;
  late HeatmapData heatmapData;

  @override
  void initState() {
    _initHeatMapData();
    super.initState();
  }

  void _initHeatMapData() {
    List<List<double>> valeurs = [
      [
        1.48,
        0.74,
        1.12,
        0.98,
        1.73,
        1.28,
        0.33,
        0.79,
        0.42,
        1.92,
        1.64,
        1.09,
        0.64,
        0.36,
        1.39
      ],
      [
        2.48,
        1.74,
        2.12,
        2.98,
        0.73,
        1.28,
        2.33,
        0.79,
        0.42,
        3.92,
        1.64,
        0.09,
        0.64,
        2.36,
        1.39
      ],
      [
        1.5643275,
        2.765487,
        1.76,
        2.764,
        1.6743,
        1.28,
        0.33,
        1.87687,
        2.42,
        1.92,
        2.7683876,
        1.09,
        2.64,
        1.36,
        2.39
      ],
      [
        0.99,
        1.444,
        1.12,
        0.98,
        1.73,
        1.28,
        0.33,
        0.79,
        0.42,
        1.92,
        1.64,
        1.09,
        0.64,
        0.36,
        1.39
      ],
      [
        1.48,
        0.74,
        1.12,
        0.98,
        1.73,
        1.28,
        0.33,
        0.79,
        0.42,
        1.92,
        1.64,
        1.09,
        0.64,
        0.36,
        1.39
      ],
      [
        1.48,
        0.74,
        1.12,
        0.98,
        1.73,
        1.28,
        0.33,
        0.79,
        0.42,
        1.92,
        1.64,
        1.09,
        0.64,
        0.36,
        1.39
      ],
      [
        1.12,
        0.98,
        1.73,
        1.28,
        0.33,
        0.79,
        0.42,
        1.92,
        1.64,
        1.09,
        0.64,
        0.36,
        1.39,
        2.4991,
        2.171
      ],
      [
        1.12,
        0.98,
        1.73,
        1.28,
        0.33,
        0.79,
        0.42,
        1.92,
        1.64,
        1.09,
        0.64,
        0.36,
        1.39,
        0.79,
        0.42
      ],
      [
        1.48,
        0.74,
        1.12,
        0.98,
        1.73,
        1.28,
        0.33,
        0.79,
        0.42,
        1.92,
        1.64,
        1.09,
        0.64,
        0.36,
        1.39
      ],
      [
        0.42,
        1.05,
        0.87,
        1.73,
        1.34,
        0.67,
        0.56,
        1.45,
        1.61,
        0.39,
        1.88,
        1.16,
        0.81,
        1.52,
        0.34
      ],
      [
        0.95,
        1.72,
        0.67,
        1.08,
        1.91,
        0.77,
        1.37,
        0.33,
        1.12,
        1.48,
        0.49,
        0.87,
        1.63,
        1.25,
        0.62
      ],
      [
        0.95,
        1.72,
        0.67,
        1.08,
        1.91,
        0.77,
        1.37,
        0.33,
        1.12,
        1.48,
        0.49,
        0.87,
        1.63,
        1.25,
        0.62
      ],
    ];

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

    var colorList = [
      Color.fromARGB(255, 5, 62, 249).withOpacity(.5),
      Color.fromARGB(255, 19, 206, 220).withOpacity(0.6),
      Color.fromARGB(255, 52, 232, 16).withOpacity(0.7),
      Color.fromARGB(255, 242, 226, 6).withOpacity(0.8),
      Color.fromARGB(255, 211, 27, 14).withOpacity(0.9),
      Color.fromARGB(255, 226, 22, 165).withOpacity(1),
    ];

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
    return  MaterialApp(
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
