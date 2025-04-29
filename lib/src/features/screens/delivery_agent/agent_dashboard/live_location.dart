import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LiveLocation extends StatefulWidget {

  const LiveLocation({
    super.key,
  });

  @override
  State<LiveLocation> createState() => _LiveLocationState();
}

class _LiveLocationState extends State<LiveLocation> {
  StreamSubscription<Position>? _positionSub;
  LatLng? _driverLatLng;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _startTracking();
  }

  @override
  void dispose() {
    _positionSub?.cancel();
    super.dispose();
  }

  Future<void> _startTracking() async {
    try {
      // 1. Ensure location services are enabled
      if (!await Geolocator.isLocationServiceEnabled()) {
        throw 'Location services are disabled. Please enable them.';
      }

      // 2. Request & check permissions
      LocationPermission perm = await Geolocator.checkPermission();
      if (perm == LocationPermission.denied) {
        perm = await Geolocator.requestPermission();
      }
      if (perm == LocationPermission.denied) {
        throw 'Location permissions are denied';
      }
      if (perm == LocationPermission.deniedForever) {
        throw 'Location permissions are permanently denied.';
      }

      // 1. Fetch your agent’s UUID
      final user    = FirebaseAuth.instance.currentUser!;
      final agentDoc = await FirebaseFirestore.instance
          .collection('agents')
          .doc(user.uid)
          .get();
      final id = agentDoc.get('id') as String;

// 2. Run the deliveries query *and await it* immediately*
      final QuerySnapshot<Map<String,dynamic>> snapshot =
      await FirebaseFirestore.instance

          .collection('deliveries')
          .where('Did', isEqualTo: id)
          .get();

// 3. Prepare your location‐stream listener
      final locationSettings = defaultTargetPlatform == TargetPlatform.android
          ? AndroidSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 5,
        intervalDuration: const Duration(seconds: 5),
        forceLocationManager: true,
      )
          : LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 20,
      );

      _positionSub = Geolocator.getPositionStream(
        locationSettings: locationSettings,
      ).listen((pos) async {
        final gp = GeoPoint(pos.latitude, pos.longitude);

        // 4. Now `snapshot.docs` is valid
        for (final doc in snapshot.docs) {
          await doc.reference.update({ 'driverLocation': gp });
        }
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // If we encountered an error, show it
    if (_errorMessage != null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Driver Tracking')),
        body: Center(
          child: Text(
            _errorMessage!,
            style: const TextStyle(color: Colors.red, fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    // Still waiting on the first location fix?
    if (_driverLatLng == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Driver Tracking')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    // We have a location → display the live map
    return Scaffold(
      appBar: AppBar(title: const Text('Driver Tracking')),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _driverLatLng!,
          zoom: 16,
        ),
        markers: {
          Marker(
            markerId: const MarkerId('driver'),
            position: _driverLatLng!,
            infoWindow: const InfoWindow(title: 'Your Location'),
            icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueAzure,
            ),
          ),
        },
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        onMapCreated: (controller) {
          // Optionally you can keep a reference to animate the camera later
        },
      ),
    );
  }
}
