import 'dart:math';

class MagnetometerCalibration {
  double _magXOffset = 0;
  double _magYOffset = 0;
  double _magZOffset = 0;
  double _magXScale = 1;
  double _magYScale = 1;
  double _magZScale = 1;

  void calibrate(List<List<double>> magnetometerValues) {
    if (magnetometerValues == null || magnetometerValues.isEmpty) {
      throw ArgumentError('magnetometerValues cannot be null or empty');
    }

    // Compute min/max values for each axis
    double minX = double.infinity;
    double minY = double.infinity;
    double minZ = double.infinity;
    double maxX = double.negativeInfinity;
    double maxY = double.negativeInfinity;
    double maxZ = double.negativeInfinity;

    for (final values in magnetometerValues) {
      final magX = values[0];
      final magY = values[1];
      final magZ = values[2];

      if (magX < minX) {
        minX = magX;}
      if (magY < minY) {
        minY = magY;}
      if (magZ < minZ) {
        minZ = magZ;}
      if (magX > maxX) {
        maxX = magX;}
      if (magY > maxY) {
        maxY = magY;}
      if (magZ > maxZ){
        maxZ = magZ;
      }
    }

    // Compute offsets and scales
    _magXOffset = (minX + maxX) / 2;
    _magYOffset = (minY + maxY) / 2;
    _magZOffset = (minZ + maxZ) / 2;
    _magXScale = (maxX - minX) / 2;
    _magYScale = (maxY - minY) / 2;
    _magZScale = (maxZ - minZ) / 2;
  }


  List<double> applyCalibration(List<double> liste) {
    if (liste == null || liste.length != 3) {
      throw ArgumentError('magnetometerValues must be a list of length 3');
    }

    final magX = (liste[0] - _magXOffset) / _magXScale;
    final magY = (liste[1] - _magYOffset) / _magYScale;
    final magZ = (liste[2] - _magZOffset) / _magZScale;

    return [magX, magY, magZ];
  }
}
