import 'dart:async';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logistics_express/src/services/map_services/api_services.dart';

class LiveGPSTracking extends StatefulWidget {
  final String source;
  final String destination;
  final bool isDelivered;
  final String deliveryId;

  const LiveGPSTracking({
    super.key,
    required this.source,
    required this.destination,
    required this.isDelivered,
    required this.deliveryId,
  });

  @override
  State<LiveGPSTracking> createState() => _LiveGPSTrackingState();
}

class _LiveGPSTrackingState extends State<LiveGPSTracking> {
  final Completer<GoogleMapController> _mapController = Completer();
  final Set<Polyline> _polylines = {};
  final Set<Marker> _markers = {};

  final List<LatLng> _polylineCoordinates = [];
  final PolylinePoints _polylinePoints = PolylinePoints();

  StreamSubscription<DocumentSnapshot>? _driverSub;

  bool _isLoading = true;
  String? _errorMessage;
  String? _driverError;

  @override
  void initState() {
    super.initState();
    _loadRoute().then((_) {
      _subscribeToDriver();
    });
  }

  @override
  void dispose() {
    _driverSub?.cancel();
    super.dispose();
  }

  Future<void> _loadRoute() async {
    try {
      final waypoints = await ApiServices()
          .getIntermediateCities(widget.source, widget.destination);

      if (waypoints.isEmpty) {
        throw Exception(
            'No route found between ${widget.source} → ${widget.destination}');
      }

      final coords =
      waypoints.map((gp) => LatLng(gp.latitude, gp.longitude)).toList();

      await _getPolyline(coords);

      final originMarker = Marker(
        markerId: const MarkerId('source'),
        position: coords.first,
        infoWindow: InfoWindow(title: 'Source', snippet: widget.source),
      );
      final destMarker = Marker(
        markerId: const MarkerId('destination'),
        position: coords.last,
        infoWindow:
        InfoWindow(title: 'Destination', snippet: widget.destination),
        icon: BitmapDescriptor.defaultMarkerWithHue(90),
      );

      setState(() {
        _polylines.add(
          Polyline(
            polylineId: const PolylineId('route'),
            color: Theme.of(context).colorScheme.primary,
            width: 5,
            points: _polylineCoordinates,
          ),
        );
        _markers.addAll([originMarker, destMarker]);
        _isLoading = false;
      });

      final bounds = _computeBounds(coords);
      final controller = await _mapController.future;
      controller.animateCamera(
        CameraUpdate.newLatLngBounds(bounds, 50),
      );
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  void _subscribeToDriver() {
    // listen on root‐level `deliveries/{deliveryId}`
    final docRef = FirebaseFirestore.instance
        .collection('deliveries')
        .doc(widget.deliveryId);

    _driverSub = docRef.snapshots().listen((snap) {
      if (!snap.exists) return;
      final data = snap.data()!;
      if (data['driverLocation'] != null) {
        final gp = data['driverLocation'] as GeoPoint;
        final pos = LatLng(gp.latitude, gp.longitude);

        // 1) update driver marker
        setState(() {
          _markers.removeWhere((m) => m.markerId.value == 'driver');
          _markers.add(
            Marker(
              markerId: const MarkerId('driver'),
              position: pos,
              icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueAzure,
              ),
              infoWindow: const InfoWindow(title: 'Driver'),
            ),
          );
        });

        // 2) follow the driver
        _mapController.future.then(
              (ctrl) => ctrl.animateCamera(
            CameraUpdate.newLatLng(pos),
          ),
        );
      }
    }, onError: (e) {
      setState(() => _driverError = e.toString());
    });
  }

  Future<void> _getPolyline(List<LatLng> coords) async {
    final result = await _polylinePoints.getRouteBetweenCoordinates(
      googleApiKey: dotenv.env['GOOGLE_MAP_API'] ?? '',
      request: PolylineRequest(
        origin: PointLatLng(coords.first.latitude, coords.first.longitude),
        destination: PointLatLng(coords.last.latitude, coords.last.longitude),
        mode: TravelMode.driving,
      ),
    );

    if (result.points.isEmpty) {
      throw Exception('Unable to fetch route polyline');
    }

    _polylineCoordinates
      ..clear()
      ..addAll(result.points.map((p) => LatLng(p.latitude, p.longitude)));
  }

  LatLngBounds _computeBounds(List<LatLng> coords) {
    final lats = coords.map((p) => p.latitude);
    final lngs = coords.map((p) => p.longitude);
    final south = lats.reduce(min);
    final north = lats.reduce(max);
    final west = lngs.reduce(min);
    final east = lngs.reduce(max);
    return LatLngBounds(
      southwest: LatLng(south, west),
      northeast: LatLng(north, east),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Live GPS Tracking')),
      backgroundColor: theme.cardColor,
      body: Stack(
        children: [
          // 1. The map
          GoogleMap(
            initialCameraPosition: const CameraPosition(
              target: LatLng(0, 0),
              zoom: 15,
            ),
            onMapCreated: (controller) {
              if (!_mapController.isCompleted) {
                _mapController.complete(controller);
              }
            },
            markers: _markers,
            polylines: _polylines,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
          ),

          // 2. Loading spinner
          if (_isLoading) const Center(child: CircularProgressIndicator()),

          // 3. Route‐load error overlay
          if (!_isLoading && _errorMessage != null)
            Center(
              child: Container(
                color: Colors.white70,
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Error:\n$_errorMessage',
                  style: const TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              ),
            ),

          // 4. Driver‐subscription error
          if (_driverError != null)
            Center(
              child: Container(
                color: Colors.white70,
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Driver update error:\n$_driverError',
                  style: const TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
