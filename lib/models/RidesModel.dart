// ignore_for_file: unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:geoflutterfire2/geoflutterfire2.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_app/models/UserModel.dart';

//These class represents public rides. rides that you can find searching...
//Should be used when someone click CREATE
class RidesModel {
  String fromText;
  String toText;
  List<LatLng> randPoints;
  LatLng toLatLng;
  DateTime dateTime;
  UserModel driver;
  int fare;

  final GeoFlutterFire geo = GeoFlutterFire();

  RidesModel(
      {this.fromText,
      this.toText,
      this.fare,
      this.randPoints,
      this.toLatLng,
      this.dateTime,
      this.driver});

  RidesModel copyWith({
    String fromText,
    String toText,
    int fare,
    List<LatLng> randPoints,
    LatLng toLatLng,
    DateTime dateTime,
    UserModel driver,
  }) {
    return RidesModel(
        fromText: fromText ?? this.fromText,
        toText: toText ?? this.toText,
        randPoints: randPoints ?? this.randPoints,
        toLatLng: toLatLng ?? this.toLatLng,
        dateTime: dateTime ?? this.dateTime,
        driver: driver ?? this.driver,
        fare: fare ?? this.fare);
  }

  Map fromLatLngtoGeoFirePoint(LatLng latLng) {
    return geo
        .point(latitude: latLng.latitude, longitude: latLng.longitude)
        .data;
  }

  LatLng fromGeoPointToLatLng(GeoFirePoint point) {
    return LatLng(point.latitude, point.longitude);
  }

  Map<String, dynamic> toMap() {
    return {
      'fromText': fromText,
      'toText': toText,
      'randPoints':
          randPoints?.map((x) => fromLatLngtoGeoFirePoint(x))?.toList(),
      'toLatLng': fromLatLngtoGeoFirePoint(toLatLng),
      'dateTime': dateTime?.millisecondsSinceEpoch,
      'driver': driver?.toMap(),
      'fare': fare
    };
  }

  static RidesModel fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    LatLng fromGeoPointToLatLng(Map<String, dynamic> map) {
      GeoPoint point = map['geopoint'];
      Map result = {
        'geopoint': map['geopoint'],
        'geohash': map['geohash'],
      };
      return LatLng(point.latitude, point.longitude);
    }

    return RidesModel(
        fromText: map['fromText'],
        toText: map['toText'],
        randPoints: List<LatLng>.from(
            map['randPoints']?.map((x) => fromGeoPointToLatLng(x))),
        toLatLng: fromGeoPointToLatLng(map['toLatLng']),
        dateTime: DateTime.fromMillisecondsSinceEpoch(map['dateTime']),
        driver: UserModel.fromMap(map['driver']),
        fare: map['fare']);
  }

  //String toJson() => json.encode(toMap());

  //static RidesModel fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'RidesModel(fromText: $fromText, toText: $toText, randPoints: $randPoints, toLatLng: $toLatLng, dateTime: $dateTime, driver: $driver, fare: $fare)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is RidesModel &&
        o.fromText == fromText &&
        o.toText == toText &&
        listEquals(o.randPoints, randPoints) &&
        o.toLatLng == toLatLng &&
        o.dateTime == dateTime &&
        o.driver == driver &&
        o.fare == fare;
  }

  @override
  int get hashCode {
    return fromText.hashCode ^
        toText.hashCode ^
        randPoints.hashCode ^
        toLatLng.hashCode ^
        dateTime.hashCode ^
        fare.hashCode ^
        driver.hashCode;
  }
}
