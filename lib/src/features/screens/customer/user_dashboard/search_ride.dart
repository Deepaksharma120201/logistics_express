import 'package:flutter/material.dart';
import 'package:logistics_express/src/features/screens/customer/user_dashboard/available_rides.dart';
import 'package:logistics_express/src/features/subscreens/address_field/address_filled.dart';

class SearchRide extends StatefulWidget {
  const SearchRide({super.key});

  @override
  State<SearchRide> createState() {
    return _SearchRideState();
  }
}

class _SearchRideState extends State<SearchRide> {
  @override
  Widget build(BuildContext context) {
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
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AvailableRides(
                      source: 'Kurukshetra',
                      destination: 'Delhi',
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
