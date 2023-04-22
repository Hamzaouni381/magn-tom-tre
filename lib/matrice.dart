import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<List<double>> _magneticField = List.generate(10, (_) => List.filled(10, 0.0));

  void _startListening() {
    magnetometerEvents.listen((MagnetometerEvent event) {
      setState(() {
        int row = event.x.round();
        int col = event.y.round();
        double magneticValue = _calculateMagneticValue(event.x, event.y, event.z);

        if (row >= 0 && row < _magneticField.length && col >= 0 && col < _magneticField[row].length) {
          _magneticField[row][col] = magneticValue;
        }
      });
    });
  }

  void _stopListening() {
    //_magnetometerSubscription.cancel();
  }

  double _calculateMagneticValue(double x, double y, double z) {
    return sqrt(x * x + y * y + z * z);
  }

  @override
  void initState() {
    super.initState();
    _startListening();
  }

  @override
  void dispose() {
    _stopListening();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Carte magnétique'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Valeurs du champ magnétique :'),
              SizedBox(height: 10),
              SizedBox(
                width: 300,
                height: 300,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: _magneticField.length),
                  itemBuilder: (BuildContext context, int index) {
                    int row = index ~/ _magneticField.length;
                    int col = index % _magneticField.length;
                    return Center(
                      child: Text(
                        _magneticField[row][col].toStringAsFixed(2),
                        style: TextStyle(fontSize: 12),
                      ),
                    );
                  },
                  itemCount: _magneticField.length * _magneticField.length,
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _stopListening,
                child: Text('Arrêter'),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: _startListening,
                child: Text('Démarrer'),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _magneticField = List.generate(10, (_) => List.filled(10, 0.0));
                  });
                },
                child: Text('Réinitialiser'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


void main() {
  runApp(MyHomePage());
}
