/*import 'package:flutter/material.dart';
import'valeurs.dart';
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isMethodOneOpened = false;
  String _message = '';
  MagnetometreData md= MagnetometreData();
  void _onButtonPressed() {
    setState(() {
      if (_isMethodOneOpened) {
        md.collecte();
        _message = 'Méthode deux ouverte';
      } else {
        md.stopCollecte();
        _message = 'Méthode un ouverte';
      }
      _isMethodOneOpened = !_isMethodOneOpened;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Bouton à bascule'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: _onButtonPressed,
                child: Text(_isMethodOneOpened ? 'Méthode deux' : 'Méthode un'),
              ),
              const SizedBox(height: 20),
              Text(_message),
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
*/
import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';
import 'valeurs.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late MagnetometreData _magnetometreData;
  bool _isCollecteDemarree = false;

  @override
  void initState() {
    super.initState();
    _magnetometreData = MagnetometreData();
  }

  @override
  void dispose() {
    _magnetometreData.stopCollecte();
    super.dispose();
  }

  void _onButtonPressed() {
    setState(() {
      if (_isCollecteDemarree) {
        _magnetometreData.collecte();
      } else {
        _magnetometreData.stopCollecte();
      }
      _isCollecteDemarree = !_isCollecteDemarree;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Bouton de collecte'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: _onButtonPressed,
                child: Text(_isCollecteDemarree ? 'Arrêter la collecte' : 'Démarrer la collecte'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
void main(){
  runApp(MyHomePage());
}