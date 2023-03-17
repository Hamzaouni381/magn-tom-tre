import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<double> _gyroscopeValues = [0, 0, 0];
  double _xa = 0.0, _ya = 0.0, _za = 0.0;
  double _magnetometerX = 0.0;
  double _magnetometerY = 0.0;
  double _magnetometerZ = 0.0;
  @override
  void initState() {
    super.initState();
    _gyroscopeValues = [0.0, 0.0, 0.0];
    gyroscopeEvents.listen((GyroscopeEvent event) {
      setState(() {
        _gyroscopeValues = [event.x, event.y, event.z];
      });
    });
    accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        _xa = event.x;
        _ya = event.y;
        _za = event.z;
      });
    });
    /*magnetometerEvents.listen((MagnetometerEvent event) {
  double x = event.x;
  double y = event.y;
  double z = event.z;
}); */
    accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        _magnetometerX = event.x;
        _magnetometerY = event.y;
        _magnetometerZ = event.z;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Sensors'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Gyroscope Data:', style: TextStyle(fontSize: 30.0)),
              SizedBox(height: 20.0),
              Text('Gyroscope X: ${_gyroscopeValues[0].toStringAsFixed(3)}',
                  style: TextStyle(fontSize: 16.0)),
              Text('Gyroscope Y: ${_gyroscopeValues[1].toStringAsFixed(3)}',
                  style: TextStyle(fontSize: 16.0)),
              Text('Gyroscope Z: ${_gyroscopeValues[2].toStringAsFixed(3)}',
                  style: TextStyle(fontSize: 16.0)),
              Text('Accelerometer Data:', style: TextStyle(fontSize: 30.0)),
              Text('Accelerometer X: $_xa', style: TextStyle(fontSize: 18)),
              Text('Accelerometer Y: $_ya', style: TextStyle(fontSize: 18)),
              Text('Accelerometer Z: $_za', style: TextStyle(fontSize: 18)),
              Text('Magnetometer Data:', style: TextStyle(fontSize: 30.0)),
              SizedBox(height: 20),
              Text('Magnetometer X: $_magnetometerX',
                  style: TextStyle(fontSize: 18)),
              Text('Magnetometer Y: $_magnetometerY',
                  style: TextStyle(fontSize: 18)),
              Text('Magnetometer Z: $_magnetometerZ',
                  style: TextStyle(fontSize: 18)),
            ],
          ),
        ),
      ),
    );
  }
}
