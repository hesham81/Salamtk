import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart';

abstract class LocationServices {
  static Future<void> getCity(LatLng location) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
      location.latitude,
      location.longitude,
    );
    Placemark place = placemarks[0];
    print(place.locality);
  }

  static String calculateDistance(LatLng location1, LatLng location2) {
    final Distance distance = Distance();
    return (distance.as(LengthUnit.Kilometer, location1, location2) == 0)
        ? "${distance.as(LengthUnit.Meter, location1, location2)} Meter"
        : "${distance.as(LengthUnit.Kilometer, location1, location2)} KM";
  }

  static double calculateDistanceNumbers(LatLng location1, LatLng location2) {
    final Distance distance = Distance();
    return distance.as(LengthUnit.Kilometer, location1, location2);
  }
}
