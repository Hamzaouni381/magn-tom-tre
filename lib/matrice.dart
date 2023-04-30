import 'dart:async';
import 'dart:math';
import 'package:plot/valeurs.dart';

import 'calibration.dart';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Magnetic Field Matrix',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
  Future<List<List<double>>>  getMagneticField() async {
    return await _MyHomePageState().startRecording();
  }

}

class _MyHomePageState extends State<MyHomePage> {
  static const int row = 10;
  static const int COLUMN_COUNT = 10;

     //late List<List<double>>Matrice;
    List<List<double>> magneticField =
  List.generate(row, (_) => List.filled(COLUMN_COUNT, 0.0));
  int _rowCount = 0;
  int _columnCount = 0;
  bool _isRecording = false;

  StreamSubscription<MagnetometerEvent>? _magnetometerSubscription;

  List<List<double>> startRecording() {
    MagnetometerCalibration magnetometerCalibration=MagnetometerCalibration();
    _isRecording = true;
    _magnetometerSubscription =
        magnetometerEvents.listen((MagnetometerEvent event) {
          List<List<double>> val = Valeur.store();
          double magneticValue = _calculateMagneticValue(
              (event.x - magnetometerCalibration.magXOffset) / magnetometerCalibration.magXScale, (event.y - magnetometerCalibration.magYOffset) / magnetometerCalibration.magYScale, (event.z
              - magnetometerCalibration.magZOffset) / magnetometerCalibration.magZScale);
          magneticField[_rowCount][_columnCount] = magneticValue;
          _columnCount++;
          if (_columnCount >= COLUMN_COUNT) {
            _rowCount++;
            _columnCount = 0;
            if (_rowCount >= row) {
              _stopRecording();
            }
          }
          //Matrice=magneticField;
          setState(() {});
        });
   return magneticField;
  }

  void _stopRecording() {
    if (_magnetometerSubscription != null) {
      _magnetometerSubscription!.cancel();
      _magnetometerSubscription = null;
    }
    _isRecording = false;
  }
  @override
  void initState() {
    super.initState();
    startRecording();
  }

  double _calculateMagneticValue(double x, double y, double z) {
    return  sqrt(x * x + y * y + z * z);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Magnetic Field Matrix'),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              'Magnetic Field Values:',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: COLUMN_COUNT,
                  childAspectRatio: 1,
                ),
                itemCount: row * COLUMN_COUNT,
                itemBuilder: (BuildContext context, int index) {
                  int row = index ~/ COLUMN_COUNT;
                  int col = index % COLUMN_COUNT;
                  return Center(
                    child: Text(
                      magneticField[row][col].toStringAsFixed(2),
                      style: TextStyle(fontSize: 16),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                if (_isRecording) {
                  _stopRecording();
                } else {
                  _rowCount = 0;
                  _columnCount = 0;
                  startRecording();
                }
                setState(() {});
              },
              child: Text(_isRecording ? 'Stop Recording' : 'Start Recording'),
            ),
            ElevatedButton(
              onPressed: (){
                magneticField = List.generate(10, (_) => List.filled(10, 0.0));
              },
              child: Text('reset'),
            ),
          ],
        ),
      ),
    );
  }
}