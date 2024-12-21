import 'package:flutter/material.dart';
import 'package:logistics_express/src/features/subscreens/sidebar/address_filled.dart';

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
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Search Ride'),
        ),
        backgroundColor: Theme.of(context).cardColor,
        body: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              AddressFilled(),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Search Ride'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
