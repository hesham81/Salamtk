import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart';

class SignUpProviders extends ChangeNotifier {
  late LatLng _userLocation;

  Marker? _marker;

  String? _country ;
  String? _state ;
  String? _city ;
  String? _street;

  Marker? get marker => _marker;

  LatLng get userLocation => _userLocation;


  void setMarker(Marker marker) {
    _marker = marker;
    notifyListeners();
    _analyseMarkerLocation();
  }
  String? get country => _country;
  String? get state => _state;
  String? get city => _city;
  String? get street => _street;

  Future<void> _analyseMarkerLocation() async {
    LatLng point = _marker!.point;
    List<Placemark> placemark = await placemarkFromCoordinates(point.latitude, point.longitude);
    _country = placemark.first.country ?? "Not Located";
    _state = placemark.first.administrativeArea ?? "Not Located";
    _city = placemark.first.locality ?? "Not Located";
    _street = placemark.first.street ?? "Not Located";
    notifyListeners();
  }
}
