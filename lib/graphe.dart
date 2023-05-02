import 'dart:async';
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class FlutterMagnetometer {
  static final FlutterMagnetometer _instance = FlutterMagnetometer._();

  static const EventChannel _eChannel =
  EventChannel("flutter_magnetometer/magnetometer-events");

    static late  Stream<MagnetometerData> _streamMagnetometer;

  static Stream<MagnetometerData> get events {
    if (_streamMagnetometer == null) {
      _streamMagnetometer = _eChannel
          .receiveBroadcastStream()
          .map<MagnetometerData>(
              (dynamic data) => _listToMagnetometerData(data.cast<double>()));
    }
    return _streamMagnetometer;
  }

  factory FlutterMagnetometer() {
    return _instance;
  }

  FlutterMagnetometer._();

  static MagnetometerData _listToMagnetometerData(List<double> list) =>
      MagnetometerData(list[0], list[1], list[2]);
}


@immutable
class MagnetometerData extends Equatable {
  final double x;
  final double y;
  final double z;

  MagnetometerData(this.x, this.y, this.z);

  factory MagnetometerData.fromMap(Map<String, dynamic> map) =>
      MagnetometerData(map['x'], map['y'], map['z']);

  Map<String, double> toMap() => {'x': x, 'y': y, 'z': z};

  String toStringDeep() => toMap().toString();

  @override
  //
  List<Object?> get props => throw UnimplementedError();
}