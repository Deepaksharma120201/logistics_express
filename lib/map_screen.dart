import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapSreenState();
}

class _MapSreenState extends State<MapScreen> {
  late GoogleMapController mapController;

  final CameraPosition _initialPosition = const CameraPosition(
    target: LatLng(29.969513, 76.878281),
    zoom: 14.4746,
  );

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      appBar: AppBar(title: const Text(" Screen")),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        mapType: MapType.normal,
        initialCameraPosition: _initialPosition,
        myLocationEnabled: true, // Enables user location
        myLocationButtonEnabled: true,
      ),
    );
  }
}
