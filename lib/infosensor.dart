import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
class Info extends StatefulWidget {
  const Info({Key? key}) : super(key: key);

  @override
  _InfoState createState() => _InfoState();
}

class _InfoState extends State<Info> {
  late final MagnetometerEvent? _magnetometerData;
  late final String _sensorName;
  late final String _sensorType;
  late final String _sensorVendor;
  late final double _sensorPower;

  @override
  void initState() {
    super.initState();
    _initMagnetometer();
  }

  Future<void> _initMagnetometer() async {
    final magnetometerAvailable = await Magnetometer.isAvailable();
    if (magnetometerAvailable) {
      final magnetometer = Magnetometer.sensor;
      magnetometer.setSamplingRate(
        Duration.microsecondsPerSecond ~/ 10,
      );
      magnetometer.setDataRate(
        Duration.microsecondsPerSecond ~/ 20,
      );
      magnetometer.setBatched(true);
      magnetometer.setDataCallback((MagnetometerEvent event) {
        setState(() {
          _magnetometerData = event;
        });
      });
      magnetometer.activate();
      final sensor = await magnetometer.describe();
      setState(() {
        _sensorName = sensor.name;
        _sensorType = sensor.type.toString();
        _sensorVendor = sensor.vendor;
        _sensorPower = sensor.resolution;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Informations sur le capteur'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Capteur active: Magnetometre',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Nom du capteur: $_sensorName',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            Text(
              'Type de capteur: $_sensorType',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            Text(
              'Fournisseur du capteur: $_sensorVendor',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            Text(
              'Consommation électrique: $_sensorPower A',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            if (_magnetometerData != null)
              Text(
                'Dernière mesure de champ magnétique: \n'
                'X: ${_magnetometerData!.x.toStringAsFixed(2)} μT\n'
                'Y: ${_magnetometerData!.y.toStringAsFixed(2)} μT\n'
                'Z: ${_magnetometerData!.z.toStringAsFixed(2)} μT',
                style: TextStyle(fontSize: 16),
              ),
          ],
        ),
      ),
    );
  }
}
