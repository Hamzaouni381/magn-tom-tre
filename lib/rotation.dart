import 'dart:math';

class RotationMatrix {
  double _roll = 0;
  double _pitch = 0;
  double _yaw = 0;
  double _gyroX = 0;
  double _gyroY = 0;
  double _gyroZ = 0;
  double _accelX = 0;
  double _accelY = 0;
  double _accelZ = 0;

  void update(List<double> gyroscopeValues, List<double> accelerometerValues) {
    // Calcule d'angle roll et pitch d'euler
    _roll = atan2(accelerometerValues[1], accelerometerValues[2]);
    _pitch = atan2(-accelerometerValues[0], sqrt(pow(accelerometerValues[1], 2) + pow(accelerometerValues[2], 2)));

    //
    final dt = 1 / 60; // Sample time in seconds
    _gyroX += gyroscopeValues[0] * dt;
    _gyroY += gyroscopeValues[1] * dt;
    _gyroZ += gyroscopeValues[2] * dt;
    _yaw += _gyroZ * dt;

    // calcule de certaines composantes
    final cr = cos(_roll);
    final sr = sin(_roll);
    final cp = cos(_pitch);
    final sp = sin(_pitch);
    final cy = cos(_yaw);
    final sy = sin(_yaw);

    final m11 = cy * cp;
    final m12 = cy * sp * sr - sy * cr;
    final m13 = cy * sp * cr + sy * sr;
    final m21 = sy * cp;
    final m22 = sy * sp * sr + cy * cr;
    final m23 = sy * sp * cr - cy * sr;
    final m31 = -sp;
    final m32 = cp * sr;
    final m33 = cp * cr;


