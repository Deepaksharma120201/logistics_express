import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:logistics_express/src/services/map_services/get_coordinates_from_place_id.dart';
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

  Future<GetCoordinatesFromPlaceId> getCoordinatesFromPlaceId(
      String placeId) async {
    Uri url = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$apiKey');

    var respones = await http.get(url);

    if (respones.statusCode == 200) {
      return GetCoordinatesFromPlaceId.fromJson(jsonDecode(respones.body));
    } else {
      throw Exception("API ERROR!!");
    }
  }
}
