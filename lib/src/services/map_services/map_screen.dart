import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logistics_express/src/custom_widgets/custom_loader.dart';
import 'package:logistics_express/src/services/map_services/place_from_coordinates.dart';
import 'package:logistics_express/src/services/map_services/api_services.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({
    super.key,
    required this.lat,
    required this.lng,
  });
  final double lat, lng;

  @override
  State<MapScreen> createState() => _MapSreenState();
}

class _MapSreenState extends State<MapScreen> {
  double defaultLat = 0.0;
  double defaultLng = 0.0;
  bool isLoading = true;
  PlaceFromCoordinates placeFromCoordinates = PlaceFromCoordinates();

  getAddress() {
    ApiServices().placeFromCoordinates(widget.lat, widget.lng).then((value) {
      setState(() {
        defaultLat = value.results?[0].geometry?.location?.lat ?? 0.0;
        defaultLng = value.results?[0].geometry?.location?.lng ?? 0.0;
        placeFromCoordinates = value;
        isLoading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getAddress();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      appBar: AppBar(title: const Text("Choose Address")),
      body: isLoading
          ? CustomLoader()
          : Stack(
              children: [
                GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(widget.lat, widget.lng),
                    zoom: 14.4746,
                  ),
                  onCameraIdle: () {
                    ApiServices()
                        .placeFromCoordinates(defaultLat, defaultLng)
                        .then((value) {
                      setState(() {
                        defaultLat =
                            value.results?[0].geometry?.location?.lat ?? 0.0;
                        defaultLng =
                            value.results?[0].geometry?.location?.lng ?? 0.0;
                        placeFromCoordinates = value;
                      });
                    });
                  },
                  onCameraMove: (CameraPosition position) {
                    setState(() {
                      defaultLat = position.target.latitude;
                      defaultLng = position.target.longitude;
                    });
                  },
                ),
                Center(
                  child: Icon(
                    FontAwesomeIcons.locationDot,
                    size: 40,
                    color: Colors.red,
                  ),
                )
              ],
            ),
      bottomSheet: Container(
        color: Colors.greenAccent,
        padding: EdgeInsets.only(
          top: 20,
          bottom: 30,
          left: 20,
          right: 20,
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: Icon(FontAwesomeIcons.locationDot),
            ),
            Expanded(
              child: Text(
                placeFromCoordinates.results?[0].formattedAddress! ??
                    "Loading...",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
