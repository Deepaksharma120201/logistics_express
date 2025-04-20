import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart';
import 'package:logistics_express/src/services/authentication/auth_controller.dart';
import 'package:logistics_express/src/services/map_services/api_services.dart';

Future<double> getDistance(WidgetRef ref) async {
  try {
    final source =
        ref.read(authControllerProvider).sourceAddressController.text.trim();
    final destination = ref
        .read(authControllerProvider)
        .destinationAddressController
        .text
        .trim();

    final response =
        await ApiServices().getDistanceFromPlaces(source, destination);

    if (response.rows != null &&
        response.rows!.isNotEmpty &&
        response.rows![0].elements != null &&
        response.rows![0].elements!.isNotEmpty) {
      String? distanceText = response.rows![0].elements![0].distance?.text;

      if (distanceText != null) {
        return double.parse(distanceText.split(" ")[0]);
      }
    }
  } catch (e) {
    debugPrint("Error getting distance: $e");
  }
  return 0.0;
}

Future<double> estimatePrice(WidgetRef ref) async {
  try {
    final authController = ref.read(authControllerProvider);
    double basePrice = 50.0;
    double weight = double.parse(authController.weightController.text.trim());
    double volume = double.parse(authController.volumeController.text.trim());
    double distance = await getDistance(ref);

    double weightRate = 10.0;
    double volumeRate = 10.0;
    double distanceRate = 2.0;

    return basePrice +
        (weight * weightRate) +
        (volume * volumeRate) +
        (distance * distanceRate);
  } catch (e) {
    debugPrint("Error estimating price: $e");
    return 0.0;
  }
}
