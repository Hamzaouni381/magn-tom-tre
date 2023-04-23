import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  final firstCamera = cameras.first;

  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('Camera'),
      ),
      body: Stack(
        children: [
          CameraScreen(camera: firstCamera),
          Align(
            alignment: Alignment.center,
            child: ScalableRectangle(),
          ),
        ],
      ),
    ),
  ));
}

class CameraScreen extends StatefulWidget {
  final CameraDescription camera;

  const CameraScreen({
    Key? key,
    required this.camera,
  }) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(widget.camera, ResolutionPreset.high);
    _controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_controller.value.isInitialized) {
      return Container();
    }

    return CameraPreview(_controller);
  }
}

class ScalableRectangle extends StatefulWidget {
  @override
  _ScalableRectangleState createState() => _ScalableRectangleState();
}

class _ScalableRectangleState extends State<ScalableRectangle> {
  double _left = 0.0;
  double _top = 0.0;
  double _scale = 1.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onScaleUpdate: (ScaleUpdateDetails details) {
        setState(() {
          _scale = details.scale;
          _left = details.focalPoint.dx - (100 * _scale / 2);
          _top = details.focalPoint.dy - (100 * _scale / 2);
        });
      },
      child: Stack(
        children: [
          Positioned(
            left: _left,
            top: _top,
            child: Transform.scale(
              scale: _scale,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                    width: 2.0,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
