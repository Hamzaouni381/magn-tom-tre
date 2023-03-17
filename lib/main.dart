import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:async';
import 'dart:math' as math;
import 'package:sensors/sensors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Accelerometer Chart',
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'Accelerometer Chart'),
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
  late List<LiveData> chartData;
  late ChartSeriesController _chartSeriesController;
  double _xa = 0;
  double _ya = 0;
  double _za = 0;

  @override
  void initState() {
    chartData = getChartData();
    Timer.periodic(const Duration(seconds: 1), updateDataSource);
    accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        _xa = event.x;
        _ya = event.y;
        _za = event.z;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Opacity(
            opacity: 0.8,
            child: Scaffold(
                body: SfCartesianChart(
                    series: <LineSeries<LiveData, double>>[
                  LineSeries<LiveData, double>(
                    onRendererCreated: (ChartSeriesController controller) {
                      _chartSeriesController = controller;
                    },
                    dataSource: chartData,
                    color: Color.fromARGB(255, 5, 2, 88),
                    xValueMapper: (LiveData sales, _) => sales.time,
                    yValueMapper: (LiveData sales, _) => sales.x_acc,
                  ),
                  LineSeries<LiveData, double>(
                    onRendererCreated: (ChartSeriesController controller) {
                      _chartSeriesController = controller;
                    },
                    dataSource: chartData,
                    color: Color.fromARGB(255, 94, 91, 247),
                    xValueMapper: (LiveData sales, _) => sales.time,
                    yValueMapper: (LiveData sales, _) => sales.y_acc,
                  ),
                  LineSeries<LiveData, double>(
                    onRendererCreated: (ChartSeriesController controller) {
                      _chartSeriesController = controller;
                    },
                    dataSource: chartData,
                    color: Color.fromARGB(255, 31, 161, 194),
                    xValueMapper: (LiveData sales, _) => sales.time,
                    yValueMapper: (LiveData sales, _) => sales.z_acc,
                  )
                ],
                    primaryXAxis: NumericAxis(
                        majorGridLines: const MajorGridLines(width: 0),
                        edgeLabelPlacement: EdgeLabelPlacement.shift,
                        interval: 3,
                        title: AxisTitle(text: 'Time (seconds)')),
                    primaryYAxis: NumericAxis(
                        axisLine: const AxisLine(width: 0),
                        majorTickLines: const MajorTickLines(size: 0),
                        title: AxisTitle(
                          text: 'Accelorometer',
                          textStyle: TextStyle(
                            color: Color.fromRGBO(3, 3, 3, 1),
                          ),
                        ))))));
  }

  double time = 10;
  void updateDataSource(Timer timer) {
    chartData.add(LiveData(time++, _xa, _ya, _za));
    chartData.removeAt(0);
    _chartSeriesController.updateDataSource(
        addedDataIndex: chartData.length - 1, removedDataIndex: 0);
  }

  List<LiveData> getChartData() {
    return <LiveData>[
      LiveData(0, _xa, _ya, _za),
      LiveData(1, _xa, _ya, _za),
      LiveData(2, _xa, _ya, _za),
      LiveData(3, _xa, _ya, _za),
      LiveData(4, _xa, _ya, _za),
      LiveData(5, _xa, _ya, _za),
      LiveData(6, _xa, _ya, _za),
      LiveData(7, _xa, _ya, _za),
      LiveData(8, _xa, _ya, _za),
      LiveData(9, _xa, _ya, _za),
      LiveData(10, _xa, _ya, _za),
    ];
  }
}

class LiveData {
  LiveData(this.time, this.x_acc, this.y_acc, this.z_acc);
  final double time;
  final double x_acc;
  final double y_acc;
  final double z_acc;
}
