import 'package:geolocator/geolocator.dart';

Future<Position> determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;
  final GeolocatorPlatform geolocatorPlatform = GeolocatorPlatform.instance;

  // Test if location services are enabled.
  serviceEnabled = await geolocatorPlatform.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  permission = await geolocatorPlatform.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await geolocatorPlatform.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await geolocatorPlatform.getCurrentPosition();
}
