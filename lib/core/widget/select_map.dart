import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import '/core/providers/sign_up_providers/sign_up_providers.dart';
import '/core/theme/app_colors.dart';

class SelectMap extends StatefulWidget {
  const SelectMap({super.key});

  @override
  State<SelectMap> createState() => _SelectMapState();
}

class _SelectMapState extends State<SelectMap> {
  MapController controller = MapController();
  Location location = Location();

  bool _serviceEnabled = false;
  PermissionStatus? _permissionGranted;

  LocationData? _locationData;

  @override
  void initState() {
    _initLocation();

    super.initState();
  }

  _initLocation() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    _locationData = await location.getLocation();
  }

  List<Marker> markers = [
    // Marker(point: point, child: child)
  ];

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SignUpProviders>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.move(
            LatLng(_locationData!.latitude!, _locationData!.longitude!),
            17.0,
          );
        },
        backgroundColor: AppColors.secondaryColor,
        child: Icon(
          Icons.my_location,
          color: AppColors.primaryColor,
        ),
      ),
      body: FlutterMap(
        mapController: controller,
        options: MapOptions(
          initialCenter: LatLng(
            _locationData?.latitude ?? 50,
            _locationData?.longitude ?? 50,
          ),
          onTap: (tapPosition, point) {
            provider.setMarker(
              Marker(
                point: point,
                child: Icon(
                  FontAwesomeIcons.houseMedicalFlag,
                  color: AppColors.secondaryColor,
                ),
              ),
            );
          },
        ),
        children: [
          TileLayer(
            userAgentPackageName: "com.maps.app",
            urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
          ),
          CurrentLocationLayer(
            style: LocationMarkerStyle(
              marker: const DefaultLocationMarker(
                child: Icon(
                  Icons.navigation,
                  color: Colors.white,
                ),
              ),
              showAccuracyCircle: false,
              markerSize: const Size(40, 40),
              markerDirection: MarkerDirection.heading,
            ),
          ),
          MarkerLayer(
            markers: (provider.marker == null)
                ? []
                : [
                    provider.marker!,
                  ],
          ),
        ],
      ),
    );
  }
}
