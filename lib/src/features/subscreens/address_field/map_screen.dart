import 'dart:async';
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
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  double defaultLat = 0.0;
  double defaultLng = 0.0;
  bool isLoading = true;

  PlaceFromCoordinates placeFromCoordinates = PlaceFromCoordinates();
  Timer? _debounce;
  GoogleMapController? _mapController;

  void getAddress(double lat, double lng) async {
    try {
      var value = await ApiServices().placeFromCoordinates(lat, lng);
      if (value.results != null && value.results!.isNotEmpty) {
        setState(() {
          defaultLat = value.results![0].geometry!.location!.lat ?? 0.0;
          defaultLng = value.results![0].geometry!.location!.lng ?? 0.0;
          placeFromCoordinates = value;
          isLoading = false;
        });

        // Update camera position after receiving the location data
        _mapController?.animateCamera(
          CameraUpdate.newLatLng(LatLng(defaultLat, defaultLng)),
        );
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getAddress(widget.lat, widget.lng);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      appBar: AppBar(
        title: const Text("Choose Address"),
        actions: [
          IconButton(
            onPressed: () {
              // When user selects the address, return it to AutoSearch screen
              Navigator.pop(
                context,
                placeFromCoordinates.results![0].formattedAddress,
              );
            },
            icon: const Icon(FontAwesomeIcons.check),
          ),
        ],
      ),
      body: isLoading
          ? const CustomLoader()
          : Stack(
              children: [
                GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(widget.lat, widget.lng),
                    zoom: 14.4746,
                  ),
                  onMapCreated: (GoogleMapController controller) {
                    _mapController = controller;
                  },
                  onCameraMove: (CameraPosition position) {
                    setState(() {
                      defaultLat = position.target.latitude;
                      defaultLng = position.target.longitude;
                    });
                  },
                  onCameraIdle: () {
                    if (_debounce?.isActive ?? false) _debounce!.cancel();
                    _debounce = Timer(const Duration(seconds: 1), () {
                      getAddress(defaultLat, defaultLng);
                    });
                  },
                ),
                const Center(
                  child: Icon(
                    FontAwesomeIcons.locationDot,
                    size: 40,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
      bottomSheet: Container(
        color: Theme.of(context).colorScheme.primaryContainer,
        padding: const EdgeInsets.all(25),
        child: Row(
          children: [
            const Icon(FontAwesomeIcons.locationDot),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                placeFromCoordinates.results?.isNotEmpty == true
                    ? placeFromCoordinates.results![0].formattedAddress ??
                        "Loading..."
                    : "No address found",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
