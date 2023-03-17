import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';
import 'package:charts_flutter/flutter.dart' as charts;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Accelerometer Chart',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Accelerometer Chart'),
        ),
        body: accelerometerChart(),
      ),
    );
  }
}

class accelerometerChart extends StatefulWidget {
  const accelerometerChart({super.key});

  @override
  State<accelerometerChart> createState() => _AccelerometerChartState();
}

class _AccelerometerChartState extends State<accelerometerChart> {
  late List<charts.Series<AccelerometerData, DateTime>> _seriesData;
  late DateTime _timeStamp;
  late List<AccelerometerData> _data;
  final _ttimeStamp = DateTime.now();
  @override
  void initState() {
    super.initState();
    _data = [];
    _timeStamp = DateTime.now();

    // Start listening to accelerometer sensor data
    accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        _data.add(AccelerometerData(
            _timeStamp.add(Duration(milliseconds: _timeStamp.second)),
            event.x,
            event.y,
            event.z));
      });
    });

    // Create the series to be displayed on the chart
    _seriesData = [
      charts.Series<AccelerometerData, DateTime>(
          id: 'X',
          colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
          domainFn: (AccelerometerData data, _) => data.timeStamp,
          measureFn: (AccelerometerData data, _) => data.x,
          data: _data),
      charts.Series<AccelerometerData, DateTime>(
          id: 'Y',
          colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
          domainFn: (AccelerometerData data, _) => data.timeStamp,
          measureFn: (AccelerometerData data, _) => data.y,
          data: _data),
      charts.Series<AccelerometerData, DateTime>(
          id: 'Z',
          colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
          domainFn: (AccelerometerData data, _) => data.timeStamp,
          measureFn: (AccelerometerData data, _) => data.z,
          data: _data),
    ];
  }

  Widget build(BuildContext context) {
    return Container(
      child: charts.TimeSeriesChart(
        _seriesData,
        animate: true,
      ),
    );
  }
}

class AccelerometerData {
  final DateTime timeStamp;
  final double x;
  final double y;
  final double z;

  AccelerometerData(this.timeStamp, this.x, this.y, this.z);
}
