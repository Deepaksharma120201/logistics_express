import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapSreenState();
}

class _MapSreenState extends State<MapScreen> {
  double defaultLat = 29.969513;
  double defaultLng = 76.878281;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Theme.of(context).cardColor,
          appBar: AppBar(title: const Text("Choose Address")),
          body: GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
              target: LatLng(defaultLat, defaultLng),
              zoom: 14.4746,
            ),
            onCameraMove: (CameraPosition position) {},
          ),
        ),
        Center(
          child: Icon(
            FontAwesomeIcons.locationDot,
            size: 30,
            color: Colors.red,
          ),
        ),
      ],
    );
  }
}
