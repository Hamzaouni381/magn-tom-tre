

import 'package:flutter/material.dart';

import 'package:sensors_plus/sensors_plus.dart';
import 'dart:async';
class Valeur {
   static final magnetometerValues = <List<double>>[];
   static List<List<double>> store() {
    final streamSubscriptions = <StreamSubscription<dynamic>>[];

    streamSubscriptions.add(
      magnetometerEvents.listen(
            (MagnetometerEvent event) {
          magnetometerValues.add([event.x, event.y, event.z]);
        },
      ),
    );

    // Wait for 10 seconds before cancelling the stream subscriptions
    Future.delayed(const Duration(seconds: 10)).then((_) {
      for (final subscription in streamSubscriptions) {
        subscription.cancel();
      }
    });

    return (magnetometerValues);
  }
}
