import 'package:flutter/material.dart';
import 'package:logistics_express/src/features/subscreens/address_field/address_filled.dart';

class UpdateRide extends StatelessWidget {
  const UpdateRide({super.key});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Updated Ride'),
        ),
        backgroundColor: Theme.of(context).cardColor,
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                AddressFilled(),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Update Ride'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
