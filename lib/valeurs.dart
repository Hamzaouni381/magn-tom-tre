import 'dart:async';
import 'package:sensors/sensors.dart';
import 'package:sensors_plus/sensors_plus.dart';

class MagnetometreData {
  List<List<double>> magnetometerValues = [];
   StreamSubscription<dynamic>? _magnetometerSubscription;
   Timer? _timer;

   void collecte() {
    // Annuler une collecte en cours s'il y en a une
    stopCollecte();
    // Réinitialiser la liste des valeurs précédentes
    magnetometerValues.clear();

    // Abonner à l'événement des données du capteur de magnétomètre
    _magnetometerSubscription =
        magnetometerEvents.listen((MagnetometerEvent event) {
      // Enregistrer la valeur du champ magnétique toutes les 5 secondes
      if (_timer == null || !_timer!.isActive) {
        _timer = Timer(const Duration(seconds: 5), () {
          magnetometerValues.add([event.x, event.y, event.z]);
        });
      }
    });
  }

  void stopCollecte() {
    if (_magnetometerSubscription != null) {
      _magnetometerSubscription?.cancel();
      _magnetometerSubscription = null;
    }
    if (_timer != null) {
      _timer?.cancel();
      _timer = null;
    }
  }
}
/*import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';
import 'package:sensors_plus/sensors_plus.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Magnetometer Demo',
      home: MagnetometerPage(),
    );
  }
}

class MagnetometerPage extends StatefulWidget {
  @override
  _MagnetometerPageState createState() => _MagnetometerPageState();
}

class _MagnetometerPageState extends State<MagnetometerPage> {
  List<List<double>> _magnetometerValues = [];
  late StreamSubscription<dynamic> _magnetometerSubscription;
  late Timer _collectTimer;

  void _collect() {
    // Ajoute les valeurs actuelles du champ magnétique à la liste
    _magnetometerValues.add([..._magnetometerValues.last]);

    // Si la liste est trop longue, on enlève les premiers éléments
    if (_magnetometerValues.length > 10) {
      _magnetometerValues.removeRange(0, _magnetometerValues.length - 10);
    }
  }

  @override
  void initState() {
    super.initState();
    _magnetometerSubscription =
        magnetometerEvents.listen((MagnetometerEvent event) {
      setState(() {
        _magnetometerValues.add([event.x, event.y, event.z]);
      });
    });

    // Lance un Timer toutes les 5 secondes pour collecter les valeurs
    _collectTimer = Timer.periodic(Duration(seconds: 5), (timer) {
      _collect();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _magnetometerSubscription.cancel();
    _collectTimer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Magnetometer Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Magnetometer values:',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            Text(
              'x: ${_magnetometerValues.last[0].toStringAsFixed(2)}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 5),
            Text(
              'y: ${_magnetometerValues.last[1].toStringAsFixed(2)}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 5),
            Text(
              'z: ${_magnetometerValues.last[2].toStringAsFixed(2)}',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}*/
