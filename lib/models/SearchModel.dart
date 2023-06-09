// ignore_for_file: unused_local_variable

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire2/geoflutterfire2.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:flutter_app/models/UserModel.dart';

class SearchModel {
  String fromText;
  String toText;
  LatLng fromCords;
  LatLng toCords;
  int fare;
  DateTime searchDate;
  UserModel searcher;

  final GeoFlutterFire geo = GeoFlutterFire();

  SearchModel({
    this.fromText,
    this.toText,
    this.fare,
    this.fromCords,
    this.toCords,
    this.searchDate,
    this.searcher,
  });

  SearchModel copyWith({
    String fromText,
    String toText,
    int fare,
    LatLng fromCords,
    LatLng toCords,
    DateTime searchDate,
    UserModel searcher,
  }) {
    return SearchModel(
      fromText: fromText ?? this.fromText,
      toText: toText ?? this.toText,
      fare: fare ?? this.fare,
      fromCords: fromCords ?? this.fromCords,
      toCords: toCords ?? this.toCords,
      searchDate: searchDate ?? this.searchDate,
      searcher: searcher ?? this.searcher,
    );
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
      'fare': fare,
      'fromCords': fromLatLngtoGeoFirePoint(fromCords),
      'toCords': fromLatLngtoGeoFirePoint(toCords),
      'searchDate': searchDate?.millisecondsSinceEpoch,
      'searcher': searcher?.toMap(),
    };
  }

  static SearchModel fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    LatLng fromGeoPointToLatLng(Map<String, dynamic> map) {
      GeoPoint point = map['geopoint'];
      Map result = {
        'geopoint': map['geopoint'],
        'geohash': map['geohash'],
      };
      return LatLng(point.latitude, point.longitude);
    }

    return SearchModel(
      fromText: map['fromText'],
      toText: map['toText'],
      fare: map['fare'],
      fromCords: fromGeoPointToLatLng(map['fromCords']),
      toCords: fromGeoPointToLatLng(map['toCords']),
      searchDate: DateTime.fromMillisecondsSinceEpoch(map['searchDate']),
      searcher: UserModel.fromMap(map['searcher']),
    );
  }

  String toJson() => json.encode(toMap());

  static SearchModel fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'SearchModel(fromText: $fromText, toText: $toText, fromCords: $fromCords, toCords: $toCords, searchDate: $searchDate, searcher: $searcher, fare: $fare)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is SearchModel &&
        o.fromText == fromText &&
        o.toText == toText &&
        o.fromCords == fromCords &&
        o.toCords == toCords &&
        o.fare == fare &&
        o.searchDate == searchDate &&
        o.searcher == searcher;
  }

  @override
  int get hashCode {
    return fromText.hashCode ^
        toText.hashCode ^
        fromCords.hashCode ^
        toCords.hashCode ^
        fare.hashCode ^
        searchDate.hashCode ^
        searcher.hashCode;
  }
}
