import 'package:flutter/material.dart';

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
    return Positioned(
      left: _left,
      top: _top,
      child: GestureDetector(
        onScaleUpdate: (ScaleUpdateDetails details) {
          setState(() {
            _scale = details.scale;
            _left = details.focalPoint.dx - (100 * _scale / 2);
            _top = details.focalPoint.dy - (100 * _scale / 2);
          });
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Object Detected",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Transform.scale(
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
          ],
        ),
      ),
    );
  }
}
