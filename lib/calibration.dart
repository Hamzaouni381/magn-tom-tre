import 'dart:math';
import 'package:sensors_plus/sensors_plus.dart';
import 'dart:async';

class MagnetometerCalibration {
   double magXOffset = 0;
   double magYOffset = 0;
     double magZOffset = 0;
   double magXScale = 1.5;
  double magYScale = 1.5;
    double magZScale = 1.5;

  List<double> calibrate(List<List<double>> tmp ) {
    if (tmp == null || tmp.isEmpty) {
      throw ArgumentError('magnetometerValues cannot be null or empty');
    }

    // Compute min/max values for each axis
    double minX = double.infinity;
    double minY = double.infinity;
    double minZ = double.infinity;
    double maxX = double.negativeInfinity;
    double maxY = double.negativeInfinity;
    double maxZ = double.negativeInfinity;

    for (final values in tmp) {
      final magX = values[0];
      final magY = values[1];
      final magZ = values[2];

      if (magX < minX) {
        minX = magX;
      }
      if (magY < minY) {
        minY = magY;
      }
      if (magZ < minZ) {
        minZ = magZ;
      }
      if (magX > maxX) {
        maxX = magX;
      }
      if (magY > maxY) {
        maxY = magY;
      }
      if (magZ > maxZ) {
        maxZ = magZ;
      }
    }

    // Compute offsets and scales
    magXOffset = (minX + maxX) / 2;
    magYOffset = (minY + maxY) / 2;
    magZOffset = (minZ + maxZ) / 2;
    magXScale = (maxX - minX) / 2;
    magYScale = (maxY - minY) / 2;
    magZScale = (maxZ - minZ) / 2;


    return [ magXOffset,magYOffset,magZOffset,magXScale,magYScale,magZScale];
  }
}
 /* List<double> applyCalibration(List<double> liste) {
    if (liste == null || liste.length != 3) {
      throw ArgumentError('magnetometerValues must be a list of length 3');
    }

    final magX = (liste[0] - _magXOffset) / _magXScale;
    final magY = (liste[1] - _magYOffset) / _magYScale;
    final magZ = (liste[2] - _magZOffset) / _magZScale;

    return [magX, magY, magZ];
  }
}*/
