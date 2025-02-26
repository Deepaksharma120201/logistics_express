import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logistics_express/src/features/screens/customer/user_dashboard/available_rides.dart';
import 'package:logistics_express/src/features/subscreens/address_field/address_filled.dart';
import 'package:logistics_express/src/services/authentication/auth_controller.dart';

class SearchRide extends ConsumerStatefulWidget {
  const SearchRide({super.key});

  @override
  ConsumerState<SearchRide> createState() {
    return _SearchRideState();
  }
}

class _SearchRideState extends ConsumerState<SearchRide> {
  @override
  Widget build(BuildContext context) {
    final authController = ref.read(authControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Search Ride'),
      ),
      backgroundColor: Theme.of(context).cardColor,
      body: Container(
        padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AddressFilled(),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AvailableRides(
                      source: authController.sourceAddressController.text
                          .trim()
                          .toUpperCase(),
                      destination: authController
                          .destinationAddressController.text
                          .trim()
                          .toUpperCase(),
                    ),
                  ),
                );
              },
              child: const Text('Search Ride'),
            ),
          ],
        ),
      ),
    );
  }
}
