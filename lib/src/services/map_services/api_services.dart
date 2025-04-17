import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:logistics_express/src/services/map_services/get_distance_from_places.dart';
import 'package:logistics_express/src/services/map_services/place_from_coordinates.dart';
import 'package:logistics_express/src/services/map_services/get_places.dart';

class ApiServices {
  String apiKey = dotenv.env['GOOGLE_MAP_API'] ?? '';

  Future<PlaceFromCoordinates> placeFromCoordinates(
      double lat, double lng) async {
    Uri url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$apiKey');

    var respones = await http.get(url);

    if (respones.statusCode == 200) {
      return PlaceFromCoordinates.fromJson(jsonDecode(respones.body));
    } else {
      throw Exception("API ERROR!!");
    }
  }

  Future<GetPlaces> getPlaces(String placeName) async {
    Uri url = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$placeName&key=$apiKey');

    var respones = await http.get(url);

    if (respones.statusCode == 200) {
      return GetPlaces.fromJson(jsonDecode(respones.body));
    } else {
      throw Exception("API ERROR!!");
    }
  }

  Future<GetDistanceFromPlaces> getDistanceFromPlaces(
      String source, String des) async {
    Uri url = Uri.parse(
        'https://maps.googleapis.com/maps/api/distancematrix/json?destinations=$des&origins=$source&key=$apiKey');

    var respones = await http.get(url);

    if (respones.statusCode == 200) {
      return GetDistanceFromPlaces.fromJson(jsonDecode(respones.body));
    } else {
      throw Exception("API ERROR!!");
    }
  }

  /// Fetches optimized intermediate cities between source and destination
  Future<List<GeoPoint>> getIntermediateCities(
      String source, String destination) async {
    final String url = "https://maps.googleapis.com/maps/api/directions/json?"
        "origin=$source&destination=$destination&key=$apiKey";

    final response = await http.get(Uri.parse(url));
    final int skipInterval = 3;
    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data['routes'].isNotEmpty) {
        List<GeoPoint> waypoints = [];
        var route = data['routes'][0];

        if (route.containsKey('legs')) {
          int count = 0;

          for (var leg in route['legs']) {
            for (var step in leg['steps']) {
              double lat = step['end_location']['lat'];
              double lng = step['end_location']['lng'];

              // Skip some points (e.g., every 5th point)
              if (count % skipInterval == 0) {
                waypoints.add(GeoPoint(lat, lng));
              }
              count++;
            }
          }
        }
        return waypoints;
      }
    } else {
      // print("Error: ${response.body}");
    }
    return [];
  }

  // Convert location name to lat/lng using Google Geocoding API
  Future<Map<String, double>?> getLatLngFromAddress(String address) async {
    final String url =
        "https://maps.googleapis.com/maps/api/geocode/json?address=$address&key=$apiKey";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['status'] == 'OK' && data['results'].isNotEmpty) {
        final location = data['results'][0]['geometry']['location'];
        return {"lat": location['lat'], "lng": location['lng']};
      }
    }
    return null;
  }
}
